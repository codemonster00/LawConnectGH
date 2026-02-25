import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/user.dart';

/// Live chat screen for consultation
class ConsultationChatScreen extends ConsumerStatefulWidget {
  final String consultationId;
  
  const ConsultationChatScreen({
    super.key,
    required this.consultationId,
  });

  @override
  ConsumerState<ConsultationChatScreen> createState() => _ConsultationChatScreenState();
}

class _ConsultationChatScreenState extends ConsumerState<ConsultationChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isTyping = false;
  bool _lawyerTyping = false;
  
  // Mock data - TODO: Get from provider
  final _consultation = ConsultationData(
    id: '1',
    lawyerName: 'Kwame Asante',
    status: ConsultationStatus.active,
    startedAt: DateTime.now().subtract(const Duration(minutes: 15)),
    duration: 30,
  );

  final List<ChatMessageData> _messages = [
    ChatMessageData(
      id: '1',
      content: 'Hello! I\'ve reviewed your case details. How can I help you with your family law matter?',
      isFromLawyer: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 14)),
      isRead: true,
    ),
    ChatMessageData(
      id: '2',
      content: 'Hi, thank you for taking my case. I need help with child custody arrangements after divorce.',
      isFromLawyer: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 13)),
      isRead: true,
    ),
    ChatMessageData(
      id: '3',
      content: 'I understand. Let\'s start with the basics. How many children are involved and what are their ages?',
      isFromLawyer: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
      isRead: true,
    ),
    ChatMessageData(
      id: '4',
      content: 'We have two children - 8 years old and 5 years old. Both are currently living with me.',
      isFromLawyer: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 11)),
      isRead: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Auto-scroll to bottom when new messages arrive
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _messages.add(ChatMessageData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: message,
        isFromLawyer: false,
        timestamp: DateTime.now(),
        isRead: false,
      ));
      _messageController.clear();
    });

    // Auto-scroll to new message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    // TODO: Send message via SignalR
  }

  void _endConsultation() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Consultation'),
        content: const Text('Are you sure you want to end this consultation? You will be asked to rate your experience.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('End Consultation'),
          ),
        ],
      ),
    );

    if (result == true) {
      // TODO: End consultation and show rating dialog
      _showRatingDialog();
    }
  }

  void _showRatingDialog() {
    int rating = 5;
    final feedbackController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.rateExperience),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Star rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => rating = index + 1),
                    child: Icon(
                      index < rating ? Icons.star : Icons.star_outline,
                      size: 32,
                      color: AppColors.accent,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              
              // Feedback text field
              TextField(
                controller: feedbackController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: AppStrings.additionalFeedback,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop(); // Return to previous screen
            },
            child: const Text('Skip'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Submit rating
              Navigator.of(context).pop();
              context.pop(); // Return to previous screen
            },
            child: const Text(AppStrings.submitRating),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _consultation.lawyerName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              _consultation.status == ConsultationStatus.active
                  ? AppStrings.consultationActive
                  : AppStrings.consultationEnded,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          // Consultation timer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              _getElapsedTime(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textInverse,
              ),
            ),
          ),
          
          // More options
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'end',
                child: Row(
                  children: [
                    Icon(Icons.call_end, color: AppColors.error),
                    SizedBox(width: 8),
                    Text('End Consultation'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'video',
                child: Row(
                  children: [
                    Icon(Icons.videocam, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text('Start Video Call'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'end':
                  _endConsultation();
                  break;
                case 'video':
                  // TODO: Start video call
                  break;
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Consultation info banner (if active)
          if (_consultation.status == ConsultationStatus.active)
            _buildConsultationBanner(),
          
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _ChatBubble(
                  message: message,
                  isLast: index == _messages.length - 1,
                );
              },
            ),
          ),
          
          // Typing indicator
          if (_lawyerTyping)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Text(
                    AppStrings.lawyerTyping,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.textTertiary),
                      strokeWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
          
          // Message input
          if (_consultation.status == ConsultationStatus.active)
            _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildConsultationBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.accent.withValues(alpha: 0.1),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.accent,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Consultation is active. You have ${_getRemainingTime()} remaining.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Extend consultation
            },
            child: const Text('Extend'),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Message input field
          Expanded(
            child: TextField(
              controller: _messageController,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: AppStrings.typeMessage,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    // TODO: Attach file
                  },
                  icon: Icon(
                    Icons.attach_file,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              onChanged: (text) {
                // TODO: Send typing indicator
                setState(() {
                  _isTyping = text.isNotEmpty;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          
          // Send button
          Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: _sendMessage,
              child: Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                child: Icon(
                  _isTyping ? Icons.send : Icons.mic,
                  color: AppColors.textInverse,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getElapsedTime() {
    final elapsed = DateTime.now().difference(_consultation.startedAt);
    final minutes = elapsed.inMinutes;
    final seconds = elapsed.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String _getRemainingTime() {
    final elapsed = DateTime.now().difference(_consultation.startedAt);
    final remaining = Duration(minutes: _consultation.duration) - elapsed;
    if (remaining.isNegative) return '00:00';
    
    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

/// Chat message bubble widget
class _ChatBubble extends StatelessWidget {
  final ChatMessageData message;
  final bool isLast;

  const _ChatBubble({
    required this.message,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isFromLawyer = message.isFromLawyer;
    
    return Container(
      margin: EdgeInsets.only(
        bottom: isLast ? 8 : 4,
        left: isFromLawyer ? 0 : 48,
        right: isFromLawyer ? 48 : 0,
      ),
      child: Column(
        crossAxisAlignment: isFromLawyer 
            ? CrossAxisAlignment.start 
            : CrossAxisAlignment.end,
        children: [
          // Message bubble
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isFromLawyer ? AppColors.surface : AppColors.primary,
              borderRadius: BorderRadius.circular(18).copyWith(
                bottomLeft: isFromLawyer ? const Radius.circular(4) : null,
                bottomRight: isFromLawyer ? null : const Radius.circular(4),
              ),
              border: isFromLawyer 
                  ? Border.all(color: AppColors.border)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message.content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isFromLawyer ? AppColors.textPrimary : AppColors.textInverse,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 4),
          
          // Timestamp and read status
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Formatters.formatTime(message.timestamp),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              if (!isFromLawyer) ...[
                const SizedBox(width: 4),
                Icon(
                  message.isRead ? Icons.done_all : Icons.done,
                  size: 14,
                  color: message.isRead ? AppColors.primary : AppColors.textTertiary,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Consultation info widget
class _ConsultationInfo extends StatelessWidget {
  final ConsultationData consultation;

  const _ConsultationInfo({required this.consultation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Started: ${Formatters.formatTime(consultation.startedAt)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(consultation.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getStatusText(consultation.status),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(consultation.status),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _getProgress(),
            backgroundColor: AppColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getProgress() > 0.8 ? AppColors.warning : AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Duration: ${consultation.duration} minutes',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(ConsultationStatus status) {
    switch (status) {
      case ConsultationStatus.active:
        return AppColors.success;
      case ConsultationStatus.completed:
        return AppColors.primary;
      case ConsultationStatus.cancelled:
        return AppColors.error;
      default:
        return AppColors.textTertiary;
    }
  }

  String _getStatusText(ConsultationStatus status) {
    switch (status) {
      case ConsultationStatus.active:
        return 'Active';
      case ConsultationStatus.completed:
        return 'Completed';
      case ConsultationStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  double _getProgress() {
    final elapsed = DateTime.now().difference(consultation.startedAt);
    final totalDuration = Duration(minutes: consultation.duration);
    return elapsed.inMilliseconds / totalDuration.inMilliseconds;
  }
}

/// Quick actions for chat (video call, end consultation, etc.)
class _ChatActions extends StatelessWidget {
  final VoidCallback onVideoCall;
  final VoidCallback onEndConsultation;

  const _ChatActions({
    required this.onVideoCall,
    required this.onEndConsultation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ActionButton(
            icon: Icons.videocam,
            label: 'Video Call',
            color: AppColors.primary,
            onPressed: onVideoCall,
          ),
          _ActionButton(
            icon: Icons.phone,
            label: 'Voice Call',
            color: AppColors.success,
            onPressed: () {
              // TODO: Start voice call
            },
          ),
          _ActionButton(
            icon: Icons.call_end,
            label: 'End',
            color: AppColors.error,
            onPressed: onEndConsultation,
          ),
        ],
      ),
    );
  }
}

/// Action button for chat actions
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onPressed,
            child: Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Mock data models
class ConsultationData {
  final String id;
  final String lawyerName;
  final ConsultationStatus status;
  final DateTime startedAt;
  final int duration;

  ConsultationData({
    required this.id,
    required this.lawyerName,
    required this.status,
    required this.startedAt,
    required this.duration,
  });
}

class ChatMessageData {
  final String id;
  final String content;
  final bool isFromLawyer;
  final DateTime timestamp;
  final bool isRead;

  ChatMessageData({
    required this.id,
    required this.content,
    required this.isFromLawyer,
    required this.timestamp,
    required this.isRead,
  });
}