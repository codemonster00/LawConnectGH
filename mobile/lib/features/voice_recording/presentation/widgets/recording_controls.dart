import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/voice_recording.dart';

/// Material Design 3 recording controls with smooth animations
class RecordingControls extends StatelessWidget {
  final RecordingState recordingState;
  final VoidCallback onStartRecording;
  final VoidCallback onPauseRecording;
  final VoidCallback onResumeRecording;
  final VoidCallback onStopRecording;

  const RecordingControls({
    super.key,
    required this.recordingState,
    required this.onStartRecording,
    required this.onPauseRecording,
    required this.onResumeRecording,
    required this.onStopRecording,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Secondary action button (left)
        _buildSecondaryButton(context, colorScheme),
        
        // Main record button (center)
        _buildMainRecordButton(context, colorScheme),
        
        // Stop button (right) - only show when recording/paused
        _buildStopButton(context, colorScheme),
      ],
    );
  }

  Widget _buildSecondaryButton(BuildContext context, ColorScheme colorScheme) {
    if (recordingState == RecordingState.recording || recordingState == RecordingState.paused) {
      // Show pause/resume button
      return _AnimatedButton(
        onPressed: recordingState == RecordingState.recording 
            ? onPauseRecording 
            : onResumeRecording,
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,
        icon: recordingState == RecordingState.recording 
            ? Icons.pause_rounded 
            : Icons.play_arrow_rounded,
        size: 64.0,
      );
    }
    
    // Show settings button when idle
    return _AnimatedButton(
      onPressed: () => _showQuickSettings(context),
      backgroundColor: colorScheme.surfaceContainerHighest,
      foregroundColor: colorScheme.onSurfaceVariant,
      icon: Icons.settings_rounded,
      size: 56.0,
    );
  }

  Widget _buildMainRecordButton(BuildContext context, ColorScheme colorScheme) {
    final isIdle = recordingState == RecordingState.idle;
    final isLoading = recordingState == RecordingState.loading;
    
    return _AnimatedButton(
      onPressed: isIdle ? onStartRecording : null,
      backgroundColor: isIdle 
          ? const Color(0xFFFF4444) 
          : colorScheme.surfaceContainerHighest,
      foregroundColor: isIdle 
          ? Colors.white 
          : colorScheme.onSurfaceVariant,
      icon: _getMainButtonIcon(),
      size: 80.0,
      isLoading: isLoading,
      elevation: isIdle ? 8.0 : 2.0,
      pulseEffect: recordingState == RecordingState.recording,
    );
  }

  Widget _buildStopButton(BuildContext context, ColorScheme colorScheme) {
    final showStop = recordingState == RecordingState.recording || 
                     recordingState == RecordingState.paused;
    
    if (!showStop) {
      // Show file manager button when idle
      return _AnimatedButton(
        onPressed: () => _showRecordingsList(context),
        backgroundColor: colorScheme.tertiaryContainer,
        foregroundColor: colorScheme.onTertiaryContainer,
        icon: Icons.folder_rounded,
        size: 56.0,
      );
    }

    return _AnimatedButton(
      onPressed: onStopRecording,
      backgroundColor: colorScheme.errorContainer,
      foregroundColor: colorScheme.onErrorContainer,
      icon: Icons.stop_rounded,
      size: 64.0,
    );
  }

  IconData _getMainButtonIcon() {
    switch (recordingState) {
      case RecordingState.recording:
        return Icons.mic_rounded;
      case RecordingState.paused:
        return Icons.pause_rounded;
      case RecordingState.loading:
        return Icons.hourglass_empty_rounded;
      case RecordingState.error:
        return Icons.error_outline_rounded;
      default:
        return Icons.mic_none_rounded;
    }
  }

  void _showQuickSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const _QuickSettingsSheet(),
    );
  }

  void _showRecordingsList(BuildContext context) {
    // This would navigate to a full recordings list screen
    // For now, we'll show a simple dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recordings'),
        content: const Text('View all saved recordings'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

/// Animated button widget with Material Design 3 styling
class _AnimatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final double size;
  final bool isLoading;
  final double elevation;
  final bool pulseEffect;

  const _AnimatedButton({
    this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.size,
    this.isLoading = false,
    this.elevation = 4.0,
    this.pulseEffect = false,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    // Start pulse animation if needed
    if (widget.pulseEffect) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_AnimatedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle pulse effect changes
    if (widget.pulseEffect && !oldWidget.pulseEffect) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.pulseEffect && oldWidget.pulseEffect) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null ? _handleTapDown : null,
      onTapUp: widget.onPressed != null ? _handleTapUp : null,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: Listenable.merge([_scaleAnimation, _pulseController]),
        builder: (context, child) {
          final scale = _scaleAnimation.value;
          final pulseScale = widget.pulseEffect 
              ? 1.0 + (_pulseController.value * 0.05)
              : 1.0;
          
          return Transform.scale(
            scale: scale * pulseScale,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.backgroundColor.withValues(alpha: 0.3),
                    blurRadius: widget.elevation * 2,
                    offset: Offset(0, widget.elevation),
                  ),
                ],
              ),
              child: widget.isLoading
                  ? _buildLoadingIndicator()
                  : Icon(
                      widget.icon,
                      color: widget.foregroundColor,
                      size: widget.size * 0.4,
                    ),
            ),
          );
        },
      ),
    ).animate(
      effects: [
        const ScaleEffect(
          duration: Duration(milliseconds: 200),
          curve: Curves.elasticOut,
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: SizedBox(
        width: widget.size * 0.3,
        height: widget.size * 0.3,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(widget.foregroundColor),
        ),
      ),
    );
  }

  void _handleTapDown(TapDownDetails details) {
    _scaleController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _scaleController.reverse();
  }

  void _handleTapCancel() {
    _scaleController.reverse();
  }
}

/// Quick settings bottom sheet
class _QuickSettingsSheet extends StatelessWidget {
  const _QuickSettingsSheet();

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
            'Quick Settings',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          // Audio quality
          ListTile(
            leading: const Icon(Icons.high_quality_rounded),
            title: const Text('Audio Quality'),
            subtitle: const Text('High (128 kbps)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Show quality picker
            },
          ),
          
          // Auto-save toggle
          SwitchListTile(
            secondary: const Icon(Icons.save_rounded),
            title: const Text('Auto-save'),
            subtitle: const Text('Automatically save recordings'),
            value: true,
            onChanged: (value) {
              // TODO: Toggle auto-save
            },
          ),
          
          const SizedBox(height: 16),
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