import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/formatters.dart';
import '../domain/voice_recording.dart';
import 'providers/voice_recording_provider.dart';
import 'widgets/audio_waveform_visualizer.dart';
import 'widgets/recording_controls.dart';
import 'widgets/saved_recordings_list.dart';

/// Voice recording screen with Material Design 3 interface
class VoiceRecordingScreen extends ConsumerStatefulWidget {
  const VoiceRecordingScreen({super.key});

  @override
  ConsumerState<VoiceRecordingScreen> createState() => _VoiceRecordingScreenState();
}

class _VoiceRecordingScreenState extends ConsumerState<VoiceRecordingScreen> 
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _waveController;
  
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    // Start wave animation
    _waveController.repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recordingState = ref.watch(recordingStateProvider);
    final recordingDuration = ref.watch(recordingDurationProvider);
    final audioAmplitudes = ref.watch(audioAmplitudeProvider);
    final savedRecordings = ref.watch(savedRecordingsProvider);
    
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Handle recording state animations
    _handleRecordingStateAnimation(recordingState);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Recording'),
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        actions: [
          IconButton(
            onPressed: () => _showSettingsBottomSheet(context),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          // Recording section
          Expanded(
            flex: 3,
            child: _buildRecordingSection(
              context,
              recordingState,
              recordingDuration,
              audioAmplitudes,
              colorScheme,
            ),
          ),
          
          // Controls section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: RecordingControls(
              recordingState: recordingState,
              onStartRecording: () => _startRecording(),
              onPauseRecording: () => _pauseRecording(),
              onResumeRecording: () => _resumeRecording(),
              onStopRecording: () => _showSaveRecordingDialog(),
            ),
          ),
          
          // Saved recordings section
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Saved Recordings',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () => ref.read(savedRecordingsProvider.notifier).loadRecordings(),
                        icon: const Icon(Icons.refresh_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SavedRecordingsList(savedRecordings: savedRecordings),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingSection(
    BuildContext context,
    RecordingState recordingState,
    Duration duration,
    List<AudioAmplitude> amplitudes,
    ColorScheme colorScheme,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Recording indicator with animation
          _buildRecordingIndicator(recordingState, colorScheme),
          
          const SizedBox(height: 32),
          
          // Duration display
          Text(
            Formatters.formatDurationFromDuration(duration),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w300,
              fontFeatures: [const FontFeature.tabularFigures()],
            ),
          ).animate(
            effects: recordingState == RecordingState.recording 
              ? [const ScaleEffect(duration: Duration(milliseconds: 300))]
              : [],
          ),
          
          const SizedBox(height: 32),
          
          // Audio waveform visualizer
          if (recordingState == RecordingState.recording || amplitudes.isNotEmpty)
            SizedBox(
              height: 100,
              width: double.infinity,
              child: AudioWaveformVisualizer(
                amplitudes: amplitudes,
                isRecording: recordingState == RecordingState.recording,
                color: colorScheme.primary,
              ),
            )
          else
            _buildIdleWaveform(colorScheme),
          
          const SizedBox(height: 32),
          
          // Status text
          Text(
            _getStatusText(recordingState),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingIndicator(RecordingState state, ColorScheme colorScheme) {
    const size = 120.0;
    
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulse rings for recording state
        if (state == RecordingState.recording) ...[
          _buildPulseRing(size * 1.5, colorScheme.primary, 0.1),
          _buildPulseRing(size * 1.3, colorScheme.primary, 0.2),
          _buildPulseRing(size * 1.1, colorScheme.primary, 0.3),
        ],
        
        // Main recording button
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _getIndicatorColors(state, colorScheme),
            ),
            boxShadow: [
              BoxShadow(
                color: _getIndicatorColors(state, colorScheme)[0].withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            _getIndicatorIcon(state),
            size: 48,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPulseRing(double size, Color color, double opacity) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: size * (0.5 + 0.5 * _pulseController.value),
          height: size * (0.5 + 0.5 * _pulseController.value),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withValues(alpha: opacity * (1 - _pulseController.value)),
              width: 2,
            ),
          ),
        );
      },
    );
  }

  Widget _buildIdleWaveform(ColorScheme colorScheme) {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return CustomPaint(
          painter: IdleWaveformPainter(
            animation: _waveController,
            color: colorScheme.primary.withValues(alpha: 0.3),
          ),
          size: const Size(double.infinity, 100),
        );
      },
    );
  }

  List<Color> _getIndicatorColors(RecordingState state, ColorScheme colorScheme) {
    switch (state) {
      case RecordingState.recording:
        return [const Color(0xFFFF4444), const Color(0xFFFF6B6B)];
      case RecordingState.paused:
        return [colorScheme.secondary, colorScheme.secondaryContainer];
      case RecordingState.loading:
        return [colorScheme.tertiary, colorScheme.tertiaryContainer];
      default:
        return [colorScheme.primary, colorScheme.primaryContainer];
    }
  }

  IconData _getIndicatorIcon(RecordingState state) {
    switch (state) {
      case RecordingState.recording:
        return Icons.mic_rounded;
      case RecordingState.paused:
        return Icons.pause_rounded;
      case RecordingState.loading:
        return Icons.hourglass_empty_rounded;
      default:
        return Icons.mic_none_rounded;
    }
  }

  String _getStatusText(RecordingState state) {
    switch (state) {
      case RecordingState.recording:
        return 'Recording in progress...';
      case RecordingState.paused:
        return 'Recording paused';
      case RecordingState.loading:
        return 'Processing...';
      case RecordingState.error:
        return 'Error occurred. Please try again.';
      default:
        return 'Tap the record button to start';
    }
  }

  void _handleRecordingStateAnimation(RecordingState state) {
    if (state == RecordingState.recording) {
      _pulseController.repeat();
    } else {
      _pulseController.stop();
    }
  }

  Future<void> _startRecording() async {
    await ref.read(recordingStateProvider.notifier).startRecording(ref);
  }

  Future<void> _pauseRecording() async {
    await ref.read(recordingStateProvider.notifier).pauseRecording();
  }

  Future<void> _resumeRecording() async {
    await ref.read(recordingStateProvider.notifier).resumeRecording(ref);
  }

  Future<void> _showSaveRecordingDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _SaveRecordingDialog(
        titleController: _titleController,
        descriptionController: _descriptionController,
      ),
    );

    if (result == true) {
      final recording = await ref.read(recordingStateProvider.notifier).stopRecording(
        title: _titleController.text.trim().isEmpty 
          ? 'Recording ${DateTime.now().millisecondsSinceEpoch}' 
          : _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty 
          ? null 
          : _descriptionController.text.trim(),
      );

      if (recording != null) {
        // Add to saved recordings list
        ref.read(savedRecordingsProvider.notifier).addRecording(recording);
        
        // Show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Recording saved: ${recording.title}'),
              action: SnackBarAction(
                label: 'View',
                onPressed: () {
                  // TODO: Navigate to recording details
                },
              ),
            ),
          );
        }
      }

      // Clear controllers
      _titleController.clear();
      _descriptionController.clear();
    } else {
      // User cancelled, don't save
      await ref.read(recordingStateProvider.notifier).stopRecording(
        title: 'temp',
      );
    }
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const _RecordingSettingsSheet(),
    );
  }
}

/// Save recording dialog
class _SaveRecordingDialog extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const _SaveRecordingDialog({
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // unused in this widget
    
    return AlertDialog(
      title: const Text('Save Recording'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter a title for your recording',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Add a description',
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Discard'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Save'),
        ),
      ],
    );
  }
}

/// Recording settings bottom sheet
class _RecordingSettingsSheet extends StatelessWidget {
  const _RecordingSettingsSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recording Settings',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          
          // Quality settings
          ListTile(
            title: const Text('Audio Quality'),
            subtitle: const Text('High Quality (128kbps)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Show quality selection
            },
          ),
          
          // Noise cancellation
          SwitchListTile(
            title: const Text('Noise Cancellation'),
            subtitle: const Text('Reduce background noise'),
            value: true,
            onChanged: (value) {
              // TODO: Toggle noise cancellation
            },
          ),
          
          // Auto-save
          SwitchListTile(
            title: const Text('Auto-save Recordings'),
            subtitle: const Text('Automatically save completed recordings'),
            value: false,
            onChanged: (value) {
              // TODO: Toggle auto-save
            },
          ),
          
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}

/// Idle waveform painter for visual appeal
class IdleWaveformPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  IdleWaveformPainter({required this.animation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final centerY = size.height / 2;
    
    for (double x = 0; x <= size.width; x += 2) {
      final normalizedX = x / size.width;
      final wave1 = sin((normalizedX * 4 * pi) + (animation.value * 2 * pi)) * 10;
      final wave2 = sin((normalizedX * 2 * pi) + (animation.value * 3 * pi)) * 5;
      final y = centerY + wave1 + wave2;
      
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}