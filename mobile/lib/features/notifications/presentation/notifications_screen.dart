import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/shimmer_loading.dart';

/// Notifications screen showing consultation reminders, lawyer responses, system alerts
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  final _scrollController = ScrollController();
  bool _isLoading = false;

  // Mock data - TODO: Replace with real data from provider
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      type: NotificationType.consultationReminder,
      title: 'Upcoming Consultation',
      message: 'Your consultation with Kwame Asante starts in 30 minutes',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
      actionData: {'consultationId': 'cons_001'},
    ),
    NotificationItem(
      id: '2',
      type: NotificationType.lawyerResponse,
      title: 'New Message from Lawyer',
      message: 'Akosua Boateng has responded to your consultation request',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      actionData: {'lawyerId': 'lawyer_002', 'chatId': 'chat_123'},
    ),
    NotificationItem(
      id: '3',
      type: NotificationType.paymentSuccess,
      title: 'Payment Successful',
      message: 'Your payment of ₵120 for consultation has been processed',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
      actionData: {'paymentId': 'pay_456'},
    ),
    NotificationItem(
      id: '4',
      type: NotificationType.documentReady,
      title: 'Document Ready',
      message: 'Your Will document has been generated and is ready for download',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      actionData: {'documentId': 'doc_789'},
    ),
    NotificationItem(
      id: '5',
      type: NotificationType.systemAlert,
      title: 'App Update Available',
      message: 'A new version of LawConnect GH is available with improved features',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
      actionData: {},
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    // TODO: Refresh notifications data
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  void _markAsRead(String notificationId) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
      }
    });
    // TODO: Mark as read in backend
  }

  void _markAllAsRead() {
    setState(() {
      for (int i = 0; i < _notifications.length; i++) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
    });
    // TODO: Mark all as read in backend
  }

  void _handleNotificationTap(NotificationItem notification) {
    if (!notification.isRead) {
      _markAsRead(notification.id);
    }

    // Navigate based on notification type
    switch (notification.type) {
      case NotificationType.consultationReminder:
        final consultationId = notification.actionData['consultationId'];
        if (consultationId != null) {
          // TODO: Navigate to consultation details
          context.go('/consultations/$consultationId');
        }
        break;
      case NotificationType.lawyerResponse:
        final chatId = notification.actionData['chatId'];
        if (chatId != null) {
          // TODO: Navigate to chat
          context.go('/chat/$chatId');
        }
        break;
      case NotificationType.documentReady:
        final documentId = notification.actionData['documentId'];
        if (documentId != null) {
          // TODO: Navigate to document details
          context.go('/documents/$documentId');
        }
        break;
      case NotificationType.paymentSuccess:
        // TODO: Show payment receipt
        break;
      case NotificationType.systemAlert:
        // No action needed for system alerts
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          '${'Notifications'} ${unreadCount > 0 ? '($unreadCount)' : ''}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text('Mark All Read'),
            ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'settings',
                child: Text('Notification Settings'),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Text('Clear All'),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'settings':
                  // TODO: Navigate to notification settings
                  break;
                case 'clear':
                  // TODO: Clear all notifications
                  break;
              }
            },
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : RefreshIndicator(
              onRefresh: _onRefresh,
              color: AppColors.primary,
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _notifications.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  color: AppColors.border,
                  indent: 72,
                ),
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return _NotificationCard(
                    notification: notification,
                    onTap: () => _handleNotificationTap(notification),
                    onMarkAsRead: () => _markAsRead(notification.id),
                  );
                },
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 24),
          Text(
            'No Notifications',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'You\'re all caught up! Notifications about consultations,\nmessages, and updates will appear here.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Notification card widget
class _NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;
  final VoidCallback onMarkAsRead;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: notification.isRead 
            ? AppColors.surface 
            : AppColors.primary.withOpacity(0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getNotificationColor().withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getNotificationIcon(),
                color: _getNotificationColor(),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: notification.isRead 
                                ? FontWeight.w500 
                                : FontWeight.w600,
                            color: notification.isRead 
                                ? AppColors.textSecondary 
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Formatters.formatRelativeTime(notification.timestamp),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            
            // Actions
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: AppColors.textTertiary,
                size: 20,
              ),
              itemBuilder: (context) => [
                if (!notification.isRead)
                  const PopupMenuItem(
                    value: 'read',
                    child: Text('Mark as Read'),
                  ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 'read':
                    onMarkAsRead();
                    break;
                  case 'delete':
                    // TODO: Delete notification
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getNotificationColor() {
    switch (notification.type) {
      case NotificationType.consultationReminder:
        return AppColors.primary;
      case NotificationType.lawyerResponse:
        return AppColors.info;
      case NotificationType.paymentSuccess:
        return AppColors.success;
      case NotificationType.documentReady:
        return AppColors.accent;
      case NotificationType.systemAlert:
        return AppColors.warning;
    }
  }

  IconData _getNotificationIcon() {
    switch (notification.type) {
      case NotificationType.consultationReminder:
        return Icons.schedule;
      case NotificationType.lawyerResponse:
        return Icons.chat_bubble;
      case NotificationType.paymentSuccess:
        return Icons.check_circle;
      case NotificationType.documentReady:
        return Icons.description;
      case NotificationType.systemAlert:
        return Icons.info;
    }
  }
}

/// Notification types
enum NotificationType {
  consultationReminder,
  lawyerResponse,
  paymentSuccess,
  documentReady,
  systemAlert,
}

/// Notification item data model
class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final Map<String, String> actionData;

  const NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
    required this.actionData,
  });

  NotificationItem copyWith({
    String? id,
    NotificationType? type,
    String? title,
    String? message,
    DateTime? timestamp,
    bool? isRead,
    Map<String, String>? actionData,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      actionData: actionData ?? this.actionData,
    );
  }
}