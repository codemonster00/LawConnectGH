import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_recording.freezed.dart';
part 'voice_recording.g.dart';

/// Voice recording data model
@freezed
class VoiceRecording with _$VoiceRecording {
  const factory VoiceRecording({
    required String id,
    required String title,
    required String filePath,
    required DateTime createdAt,
    required Duration duration,
    String? description,
    List<String>? tags,
    @Default(false) bool isFavorite,
    double? fileSize, // in MB
  }) = _VoiceRecording;

  factory VoiceRecording.fromJson(Map<String, dynamic> json) =>
      _$VoiceRecordingFromJson(json);
}

/// Recording state for UI
enum RecordingState {
  idle,
  recording,
  paused,
  stopped,
  playing,
  playingPaused,
  loading,
  error,
}

/// Audio amplitude data for waveform visualization
@freezed
class AudioAmplitude with _$AudioAmplitude {
  const factory AudioAmplitude({
    required double amplitude,
    required DateTime timestamp,
  }) = _AudioAmplitude;
}

/// Playback position info
@freezed
class PlaybackPosition with _$PlaybackPosition {
  const factory PlaybackPosition({
    required Duration position,
    required Duration duration,
    required double progress, // 0.0 to 1.0
  }) = _PlaybackPosition;
}

/// Recording configuration
@freezed
class RecordingConfig with _$RecordingConfig {
  const factory RecordingConfig({
    @Default(44100) int sampleRate,
    @Default(128000) int bitRate,
    @Default('m4a') String format,
    @Default(true) bool enableNoiseSuppression,
    @Default(true) bool enableEchoCancellation,
  }) = _RecordingConfig;
}