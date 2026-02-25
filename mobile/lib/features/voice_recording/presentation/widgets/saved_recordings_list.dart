import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/shimmer_loading.dart';
import '../../domain/voice_recording.dart';
import '../providers/voice_recording_provider.dart';
import 'audio_waveform_visualizer.dart';

/// Saved recordings list with playback controls and swipe actions
class SavedRecordingsList extends ConsumerStatefulWidget {
  final AsyncValue<List<VoiceRecording>> savedRecordings;

  const SavedRecordingsList({
    super.key,
    required this.savedRecordings,
  });

  @override
  ConsumerState<SavedRecordingsList> createState() => _SavedRecordingsListState();
}

class _SavedRecordingsListState extends ConsumerState<SavedRecordingsList> {
  String? _currentlyPlayingId;
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return widget.savedRecordings.when(
      loading: () => _buildLoadingState(),
      error: (error, stack) => ErrorState(
        message: 'Failed to load recordings',
        onRetry: () => ref.read(savedRecordingsProvider.notifier).loadRecordings(),
      ),
      data: (recordings) {
        if (recordings.isEmpty) {
          return const EmptyState(
            icon: Icons.mic_none_rounded,
            title: 'No recordings yet',
            subtitle: 'Your voice recordings will appear here',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(top: 8),
          itemCount: recordings.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final recording = recordings[index];
            final isPlaying = _currentlyPlayingId == recording.id && _isPlaying;
            
            return _RecordingCard(
              recording: recording,
              isPlaying: isPlaying,
              onPlayToggle: () => _togglePlayback(recording),
              onDelete: () => _deleteRecording(recording),
              onShare: () => _shareRecording(recording),
            ).animate(
              delay: Duration(milliseconds: index * 100),
              effects: [
                const SlideEffect(
                  duration: Duration(milliseconds: 400),
                  begin: Offset(1, 0),
                  curve: Curves.easeOut,
                ),
                const FadeEffect(
                  duration: Duration(milliseconds: 300),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 8),
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => const _RecordingCardSkeleton(),
    );
  }

  void _togglePlayback(VoiceRecording recording) async {
    if (_currentlyPlayingId == recording.id && _isPlaying) {
      // Pause current playback
      setState(() {
        _isPlaying = false;
      });
      // TODO: Pause audio playback
    } else {
      // Start/resume playback
      setState(() {
        _currentlyPlayingId = recording.id;
        _isPlaying = true;
      });
      
      // TODO: Start audio playback
      final service = ref.read(voiceRecordingServiceProvider);
      await service.playRecording(
        filePath: recording.filePath,
        onPositionUpdate: (position) {
          ref.read(playbackPositionProvider.notifier).state = position;
        },
      );
    }
  }

  void _deleteRecording(VoiceRecording recording) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Recording'),
        content: Text('Are you sure you want to delete "${recording.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(savedRecordingsProvider.notifier).deleteRecording(
                recording.id,
                recording.filePath,
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Deleted "${recording.title}"'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // TODO: Implement undo functionality
                    },
                  ),
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _shareRecording(VoiceRecording recording) {
    // TODO: Implement sharing functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing "${recording.title}"...'),
      ),
    );
  }
}

/// Individual recording card with playback controls
class _RecordingCard extends StatelessWidget {
  final VoiceRecording recording;
  final bool isPlaying;
  final VoidCallback onPlayToggle;
  final VoidCallback onDelete;
  final VoidCallback onShare;

  const _RecordingCard({
    required this.recording,
    required this.isPlaying,
    required this.onPlayToggle,
    required this.onDelete,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dismissible(
      key: Key(recording.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.delete_rounded,
          color: colorScheme.onErrorContainer,
          size: 28,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Recording'),
            content: Text('Delete "${recording.title}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) => onDelete(),
      child: Card(
        elevation: 2,
        shadowColor: colorScheme.shadow.withValues(alpha: 0.1),
        surfaceTintColor: isPlaying ? colorScheme.primaryContainer : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and actions
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recording.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatRecordingInfo(recording),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Action buttons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: onShare,
                        icon: const Icon(Icons.share_rounded),
                        iconSize: 20,
                        tooltip: 'Share',
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete_outline_rounded),
                        iconSize: 20,
                        tooltip: 'Delete',
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Waveform and playback controls
              Row(
                children: [
                  // Play/Pause button
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isPlaying 
                          ? colorScheme.primary 
                          : colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: onPlayToggle,
                      icon: Icon(
                        isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: isPlaying 
                            ? colorScheme.onPrimary 
                            : colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Waveform visualization
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: PlaybackWaveformVisualizer(
                        duration: recording.duration,
                        position: Duration.zero, // TODO: Get actual position
                        color: colorScheme.outline.withValues(alpha: 0.3),
                        playedColor: colorScheme.primary,
                        height: 30,
                        onSeek: () {
                          // TODO: Implement seeking
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Duration
                  Text(
                    Formatters.formatDurationFromDuration(recording.duration),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontFeatures: [const FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              
              // Description (if available)
              if (recording.description != null && recording.description!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  recording.description!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              
              // Tags (if available)
              if (recording.tags != null && recording.tags!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  children: recording.tags!.take(3).map((tag) {
                    return Chip(
                      label: Text(tag),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatRecordingInfo(VoiceRecording recording) {
    final date = Formatters.formatRelativeDate(recording.createdAt);
    final size = recording.fileSize != null 
        ? '${recording.fileSize!.toStringAsFixed(1)} MB' 
        : '';
    
    return '$date${size.isNotEmpty ? ' • $size' : ''}';
  }
}

/// Skeleton loader for recording cards
class _RecordingCardSkeleton extends StatelessWidget {
  const _RecordingCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerLoading(width: 150, height: 16),
                      SizedBox(height: 4),
                      ShimmerLoading(width: 100, height: 12),
                    ],
                  ),
                ),
                const ShimmerLoading(width: 24, height: 24),
                const SizedBox(width: 12),
                const ShimmerLoading(width: 24, height: 24),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                ShimmerLoading(width: 48, height: 48, borderRadius: BorderRadius.all(Radius.circular(24))),
                SizedBox(width: 12),
                Expanded(
                  child: ShimmerLoading(width: double.infinity, height: 30),
                ),
                SizedBox(width: 12),
                ShimmerLoading(width: 40, height: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}