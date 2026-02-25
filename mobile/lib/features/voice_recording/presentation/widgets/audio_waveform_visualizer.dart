import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/voice_recording.dart';

/// Real-time audio waveform visualizer with Material Design 3 styling
class AudioWaveformVisualizer extends StatefulWidget {
  final List<AudioAmplitude> amplitudes;
  final bool isRecording;
  final Color color;
  final double barWidth;
  final double barSpacing;
  final double maxBarHeight;

  const AudioWaveformVisualizer({
    super.key,
    required this.amplitudes,
    this.isRecording = false,
    required this.color,
    this.barWidth = 3.0,
    this.barSpacing = 1.0,
    this.maxBarHeight = 80.0,
  });

  @override
  State<AudioWaveformVisualizer> createState() => _AudioWaveformVisualizerState();
}

class _AudioWaveformVisualizerState extends State<AudioWaveformVisualizer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AudioWaveformVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Trigger animation when new amplitude data arrives
    if (widget.amplitudes.length > oldWidget.amplitudes.length) {
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.maxBarHeight + 20, // Add padding
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomPaint(
        painter: WaveformPainter(
          amplitudes: widget.amplitudes,
          isRecording: widget.isRecording,
          color: widget.color,
          barWidth: widget.barWidth,
          barSpacing: widget.barSpacing,
          maxBarHeight: widget.maxBarHeight,
          animation: _animationController,
        ),
        size: Size.infinite,
      ),
    ).animate(
      effects: widget.isRecording
          ? [
              const ScaleEffect(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              ),
            ]
          : [],
    );
  }
}

/// Custom painter for the waveform visualization
class WaveformPainter extends CustomPainter {
  final List<AudioAmplitude> amplitudes;
  final bool isRecording;
  final Color color;
  final double barWidth;
  final double barSpacing;
  final double maxBarHeight;
  final Animation<double> animation;

  WaveformPainter({
    required this.amplitudes,
    required this.isRecording,
    required this.color,
    required this.barWidth,
    required this.barSpacing,
    required this.maxBarHeight,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    if (amplitudes.isEmpty) {
      _paintIdleWaveform(canvas, size);
      return;
    }

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final centerY = size.height / 2;
    final totalWidth = size.width;
    final totalBars = (totalWidth / (barWidth + barSpacing)).floor();
    
    // Calculate how many amplitudes to show
    final startIndex = math.max(0, amplitudes.length - totalBars);
    final visibleAmplitudes = amplitudes.sublist(startIndex);

    for (int i = 0; i < visibleAmplitudes.length; i++) {
      final amplitude = visibleAmplitudes[i];
      final x = i * (barWidth + barSpacing);
      
      // Calculate bar height based on amplitude (0.0 to 1.0)
      final normalizedAmplitude = amplitude.amplitude.clamp(0.0, 1.0);
      var barHeight = normalizedAmplitude * maxBarHeight;
      
      // Minimum bar height for visual appeal
      barHeight = math.max(barHeight, 4.0);
      
      // Apply animation to the most recent bars
      if (isRecording && i >= visibleAmplitudes.length - 3) {
        barHeight *= animation.value;
      }

      // Color intensity based on amplitude and recency
      final isRecent = i >= visibleAmplitudes.length - 5;
      final opacity = isRecent && isRecording ? 1.0 : 0.7;
      
      paint.color = color.withValues(alpha: opacity);
      
      // Create gradient effect for recent bars
      if (isRecent && isRecording) {
        paint.shader = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            color.withValues(alpha: 0.8),
            color,
            color.withValues(alpha: 0.6),
          ],
        ).createShader(Rect.fromLTWH(
          x,
          centerY - barHeight / 2,
          barWidth,
          barHeight,
        ));
      } else {
        paint.shader = null;
      }

      // Draw the bar
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          x,
          centerY - barHeight / 2,
          barWidth,
          barHeight,
        ),
        Radius.circular(barWidth / 2),
      );
      
      canvas.drawRRect(rect, paint);
    }
  }

  void _paintIdleWaveform(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final centerY = size.height / 2;
    final totalBars = (size.width / (barWidth + barSpacing)).floor();
    
    // Create a subtle animated baseline waveform
    for (int i = 0; i < totalBars; i++) {
      final x = i * (barWidth + barSpacing);
      
      // Generate pseudo-random heights for visual appeal
      final random = math.Random(i);
      final baseHeight = 4.0 + (random.nextDouble() * 8.0);
      
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          x,
          centerY - baseHeight / 2,
          barWidth,
          baseHeight,
        ),
        Radius.circular(barWidth / 2),
      );
      
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(WaveformPainter oldDelegate) {
    return oldDelegate.amplitudes.length != amplitudes.length ||
           oldDelegate.isRecording != isRecording ||
           oldDelegate.animation != animation;
  }
}

/// Playback waveform visualizer for saved recordings
class PlaybackWaveformVisualizer extends StatelessWidget {
  final Duration duration;
  final Duration position;
  final Color color;
  final Color playedColor;
  final double height;
  final VoidCallback? onSeek;

  const PlaybackWaveformVisualizer({
    super.key,
    required this.duration,
    required this.position,
    required this.color,
    required this.playedColor,
    this.height = 60.0,
    this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onSeek != null ? _handleTap : null,
      child: Container(
        width: double.infinity,
        height: height + 20,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomPaint(
          painter: PlaybackWaveformPainter(
            duration: duration,
            position: position,
            color: color,
            playedColor: playedColor,
            height: height,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }

  void _handleTap(TapDownDetails details) {
    if (onSeek == null || duration.inMilliseconds == 0) return;
    
    final renderBox = details.globalPosition;
    // This would need the actual render box to calculate position correctly
    // For now, this is a placeholder
  }
}

/// Custom painter for playback waveform
class PlaybackWaveformPainter extends CustomPainter {
  final Duration duration;
  final Duration position;
  final Color color;
  final Color playedColor;
  final double height;

  PlaybackWaveformPainter({
    required this.duration,
    required this.position,
    required this.color,
    required this.playedColor,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final centerY = size.height / 2;
    const barWidth = 2.0;
    const barSpacing = 1.0;
    final totalBars = (size.width / (barWidth + barSpacing)).floor();
    
    // Calculate progress
    final progress = duration.inMilliseconds > 0 
        ? position.inMilliseconds / duration.inMilliseconds 
        : 0.0;
    final progressBarIndex = (totalBars * progress).floor();

    // Generate consistent waveform pattern
    for (int i = 0; i < totalBars; i++) {
      final x = i * (barWidth + barSpacing);
      
      // Generate pseudo-random heights based on index for consistency
      final random = math.Random(i * 17); // Multiply for more variation
      final barHeight = 8.0 + (random.nextDouble() * (height - 16));
      
      // Color based on playback position
      paint.color = i <= progressBarIndex ? playedColor : color;
      
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          x,
          centerY - barHeight / 2,
          barWidth,
          barHeight,
        ),
        const Radius.circular(1.0),
      );
      
      canvas.drawRRect(rect, paint);
    }

    // Draw progress indicator
    if (progress > 0) {
      final indicatorX = size.width * progress;
      paint.color = playedColor;
      paint.strokeWidth = 2.0;
      paint.style = PaintingStyle.stroke;
      
      canvas.drawLine(
        Offset(indicatorX, centerY - height / 2),
        Offset(indicatorX, centerY + height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(PlaybackWaveformPainter oldDelegate) {
    return oldDelegate.position != position ||
           oldDelegate.duration != duration;
  }
}