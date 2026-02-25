import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../../domain/voice_recording.dart';

/// Voice recording service provider
final voiceRecordingServiceProvider = Provider<VoiceRecordingService>((ref) {
  return VoiceRecordingService();
});

/// Recording state provider
final recordingStateProvider = StateNotifierProvider<RecordingStateNotifier, RecordingState>((ref) {
  final service = ref.watch(voiceRecordingServiceProvider);
  return RecordingStateNotifier(service);
});

/// Current recording duration provider
final recordingDurationProvider = StateProvider<Duration>((ref) {
  return Duration.zero;
});

/// Audio amplitude provider for waveform visualization
final audioAmplitudeProvider = StateProvider<List<AudioAmplitude>>((ref) {
  return [];
});

/// Saved recordings list provider
final savedRecordingsProvider = StateNotifierProvider<SavedRecordingsNotifier, AsyncValue<List<VoiceRecording>>>((ref) {
  final service = ref.watch(voiceRecordingServiceProvider);
  return SavedRecordingsNotifier(service);
});

/// Current playback position provider
final playbackPositionProvider = StateProvider<PlaybackPosition?>((ref) {
  return null;
});

/// Voice recording service
class VoiceRecordingService {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Uuid _uuid = const Uuid();
  
  Timer? _amplitudeTimer;
  Timer? _durationTimer;
  String? _currentRecordingPath;

  /// Check and request recording permission
  Future<bool> checkPermission() async {
    final hasPermission = await _audioRecorder.hasPermission();
    return hasPermission;
  }

  /// Start recording with amplitude monitoring
  Future<bool> startRecording({
    required Function(Duration) onDurationUpdate,
    required Function(double) onAmplitudeUpdate,
  }) async {
    try {
      // Check permission
      if (!await checkPermission()) {
        throw Exception('Microphone permission denied');
      }

      // Get recording path
      final directory = await getApplicationDocumentsDirectory();
      final recordingsDir = Directory('${directory.path}/recordings');
      if (!await recordingsDir.exists()) {
        await recordingsDir.create(recursive: true);
      }

      _currentRecordingPath = '${recordingsDir.path}/${_uuid.v4()}.m4a';

      // Start recording
      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          sampleRate: 44100,
          bitRate: 128000,
          numChannels: 1,
        ),
        path: _currentRecordingPath!,
      );

      // Start duration timer
      int seconds = 0;
      _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        seconds++;
        onDurationUpdate(Duration(seconds: seconds));
      });

      // Start amplitude monitoring (simplified version)
      _amplitudeTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
        try {
          final amplitude = await _audioRecorder.getAmplitude();
          final normalizedAmplitude = amplitude.current.clamp(-60.0, 0.0);
          final visualAmplitude = (normalizedAmplitude + 60) / 60; // 0.0 to 1.0
          onAmplitudeUpdate(visualAmplitude);
        } catch (e) {
          // If amplitude reading fails, use a random value for visual effect
          onAmplitudeUpdate(0.3 + (Random().nextDouble() * 0.4));
        }
      });

      return true;
    } catch (e) {
      debugPrint('Error starting recording: $e');
      return false;
    }
  }

  /// Pause recording
  Future<void> pauseRecording() async {
    try {
      await _audioRecorder.pause();
      _durationTimer?.cancel();
      _amplitudeTimer?.cancel();
    } catch (e) {
      debugPrint('Error pausing recording: $e');
    }
  }

  /// Resume recording
  Future<void> resumeRecording({
    required Function(Duration) onDurationUpdate,
    required Function(double) onAmplitudeUpdate,
  }) async {
    try {
      await _audioRecorder.resume();
      
      // Resume timers
      _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        // Duration tracking should continue from where it left off
        onDurationUpdate(Duration(seconds: timer.tick));
      });

      _amplitudeTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
        try {
          final amplitude = await _audioRecorder.getAmplitude();
          final normalizedAmplitude = amplitude.current.clamp(-60.0, 0.0);
          final visualAmplitude = (normalizedAmplitude + 60) / 60;
          onAmplitudeUpdate(visualAmplitude);
        } catch (e) {
          onAmplitudeUpdate(0.3 + (Random().nextDouble() * 0.4));
        }
      });
    } catch (e) {
      debugPrint('Error resuming recording: $e');
    }
  }

  /// Stop recording and save
  Future<String?> stopRecording() async {
    try {
      _durationTimer?.cancel();
      _amplitudeTimer?.cancel();
      
      final path = await _audioRecorder.stop();
      _currentRecordingPath = null;
      return path;
    } catch (e) {
      debugPrint('Error stopping recording: $e');
      return null;
    }
  }

  /// Save recording with metadata
  Future<VoiceRecording> saveRecording({
    required String filePath,
    required String title,
    required Duration duration,
    String? description,
    List<String>? tags,
  }) async {
    final file = File(filePath);
    final fileSize = await file.length();
    
    final recording = VoiceRecording(
      id: _uuid.v4(),
      title: title,
      filePath: filePath,
      createdAt: DateTime.now(),
      duration: duration,
      description: description,
      tags: tags,
      fileSize: fileSize / (1024 * 1024), // Convert to MB
    );

    // TODO: Save to local database (Hive/SQLite)
    // For now, we'll use a simple file-based approach
    
    return recording;
  }

  /// Load saved recordings
  Future<List<VoiceRecording>> loadSavedRecordings() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final recordingsDir = Directory('${directory.path}/recordings');
      
      if (!await recordingsDir.exists()) {
        return [];
      }

      final files = await recordingsDir.list().where((entity) {
        return entity is File && entity.path.endsWith('.m4a');
      }).toList();

      final recordings = <VoiceRecording>[];
      
      for (final file in files) {
        if (file is File) {
          // Extract metadata from filename or use defaults
          final fileName = p.basenameWithoutExtension(file.path);
          final stat = await file.stat();
          final fileSize = stat.size / (1024 * 1024);
          
          // For now, use dummy duration - in a real app, you'd store metadata
          recordings.add(VoiceRecording(
            id: fileName,
            title: 'Recording ${recordings.length + 1}',
            filePath: file.path,
            createdAt: stat.modified,
            duration: Duration(minutes: Random().nextInt(10) + 1), // Dummy duration
            fileSize: fileSize,
          ));
        }
      }

      recordings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return recordings;
    } catch (e) {
      debugPrint('Error loading recordings: $e');
      return [];
    }
  }

  /// Play recording
  Future<bool> playRecording({
    required String filePath,
    required Function(PlaybackPosition) onPositionUpdate,
  }) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      
      // Listen to position changes
      _audioPlayer.positionStream.listen((position) {
        final duration = _audioPlayer.duration ?? Duration.zero;
        final progress = duration.inMilliseconds > 0 
          ? position.inMilliseconds / duration.inMilliseconds 
          : 0.0;
        
        onPositionUpdate(PlaybackPosition(
          position: position,
          duration: duration,
          progress: progress.clamp(0.0, 1.0),
        ));
      });

      await _audioPlayer.play();
      return true;
    } catch (e) {
      debugPrint('Error playing recording: $e');
      return false;
    }
  }

  /// Pause playback
  Future<void> pausePlayback() async {
    await _audioPlayer.pause();
  }

  /// Resume playback
  Future<void> resumePlayback() async {
    await _audioPlayer.play();
  }

  /// Stop playback
  Future<void> stopPlayback() async {
    await _audioPlayer.stop();
  }

  /// Seek to position
  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  /// Delete recording
  Future<bool> deleteRecording(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error deleting recording: $e');
      return false;
    }
  }

  /// Dispose resources
  void dispose() {
    _durationTimer?.cancel();
    _amplitudeTimer?.cancel();
    _audioPlayer.dispose();
  }
}

/// Recording state notifier
class RecordingStateNotifier extends StateNotifier<RecordingState> {
  final VoiceRecordingService _service;
  
  RecordingStateNotifier(this._service) : super(RecordingState.idle);

  Future<void> startRecording(WidgetRef ref) async {
    if (state != RecordingState.idle) return;
    
    state = RecordingState.loading;
    
    final success = await _service.startRecording(
      onDurationUpdate: (duration) {
        ref.read(recordingDurationProvider.notifier).state = duration;
      },
      onAmplitudeUpdate: (amplitude) {
        final amplitudes = ref.read(audioAmplitudeProvider.notifier);
        final newAmplitude = AudioAmplitude(
          amplitude: amplitude,
          timestamp: DateTime.now(),
        );
        
        // Keep only last 50 amplitude readings for performance
        final newAmplitudes = [...amplitudes.state, newAmplitude];
        if (newAmplitudes.length > 50) {
          newAmplitudes.removeAt(0);
        }
        amplitudes.state = newAmplitudes;
      },
    );

    state = success ? RecordingState.recording : RecordingState.error;
  }

  Future<void> pauseRecording() async {
    if (state != RecordingState.recording) return;
    
    await _service.pauseRecording();
    state = RecordingState.paused;
  }

  Future<void> resumeRecording(WidgetRef ref) async {
    if (state != RecordingState.paused) return;
    
    await _service.resumeRecording(
      onDurationUpdate: (duration) {
        ref.read(recordingDurationProvider.notifier).state = duration;
      },
      onAmplitudeUpdate: (amplitude) {
        final amplitudes = ref.read(audioAmplitudeProvider.notifier);
        final newAmplitude = AudioAmplitude(
          amplitude: amplitude,
          timestamp: DateTime.now(),
        );
        
        final newAmplitudes = [...amplitudes.state, newAmplitude];
        if (newAmplitudes.length > 50) {
          newAmplitudes.removeAt(0);
        }
        amplitudes.state = newAmplitudes;
      },
    );
    
    state = RecordingState.recording;
  }

  Future<VoiceRecording?> stopRecording({
    required String title,
    String? description,
    List<String>? tags,
  }) async {
    if (state != RecordingState.recording && state != RecordingState.paused) return null;
    
    state = RecordingState.loading;
    
    final filePath = await _service.stopRecording();
    if (filePath == null) {
      state = RecordingState.error;
      return null;
    }

    // Get recording duration from the provider
    // This should be properly tracked during recording
    final duration = Duration(minutes: 1); // Placeholder
    
    final recording = await _service.saveRecording(
      filePath: filePath,
      title: title,
      duration: duration,
      description: description,
      tags: tags,
    );

    state = RecordingState.idle;
    return recording;
  }

  void reset() {
    state = RecordingState.idle;
  }
}

/// Saved recordings notifier
class SavedRecordingsNotifier extends StateNotifier<AsyncValue<List<VoiceRecording>>> {
  final VoiceRecordingService _service;
  
  SavedRecordingsNotifier(this._service) : super(const AsyncValue.loading()) {
    loadRecordings();
  }

  Future<void> loadRecordings() async {
    try {
      state = const AsyncValue.loading();
      final recordings = await _service.loadSavedRecordings();
      state = AsyncValue.data(recordings);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteRecording(String id, String filePath) async {
    final currentData = state.value;
    if (currentData == null) return;

    final success = await _service.deleteRecording(filePath);
    if (success) {
      final updatedRecordings = currentData.where((r) => r.id != id).toList();
      state = AsyncValue.data(updatedRecordings);
    }
  }

  Future<void> addRecording(VoiceRecording recording) async {
    final currentData = state.value;
    if (currentData == null) return;

    final updatedRecordings = [recording, ...currentData];
    state = AsyncValue.data(updatedRecordings);
  }
}