import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Colored badge widget for consultation states
class ConsultationStatusBadge extends StatelessWidget {
  final ConsultationStatus status;
  final ConsultationStatusBadgeSize size;
  final bool showIcon;
  final EdgeInsetsGeometry? padding;

  const ConsultationStatusBadge({
    super.key,
    required this.status,
    this.size = ConsultationStatusBadgeSize.medium,
    this.showIcon = true,
    this.padding,
  });

  /// Small badge constructor
  const ConsultationStatusBadge.small({
    super.key,
    required this.status,
    this.showIcon = false,
    this.padding,
  }) : size = ConsultationStatusBadgeSize.small;

  /// Large badge constructor
  const ConsultationStatusBadge.large({
    super.key,
    required this.status,
    this.showIcon = true,
    this.padding,
  }) : size = ConsultationStatusBadgeSize.large;

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status);
    final sizeConfig = _getSizeConfig(size);

    return Container(
      padding: padding ?? sizeConfig.padding,
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(sizeConfig.borderRadius),
        border: Border.all(
          color: config.borderColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              config.icon,
              size: sizeConfig.iconSize,
              color: config.iconColor,
            ),
            SizedBox(width: sizeConfig.spacing),
          ],
          Text(
            config.label,
            style: TextStyle(
              fontSize: sizeConfig.fontSize,
              fontWeight: FontWeight.w600,
              color: config.textColor,
            ),
          ),
        ],
      ),
    );
  }

  _StatusConfig _getStatusConfig(ConsultationStatus status) {
    switch (status) {
      case ConsultationStatus.pending:
        return _StatusConfig(
          label: 'Pending',
          icon: Icons.schedule,
          backgroundColor: AppColors.warning.withValues(alpha: 0.1),
          borderColor: AppColors.warning.withValues(alpha: 0.3),
          textColor: AppColors.warning,
          iconColor: AppColors.warning,
        );
      
      case ConsultationStatus.accepted:
        return _StatusConfig(
          label: 'Accepted',
          icon: Icons.check_circle_outline,
          backgroundColor: AppColors.info.withValues(alpha: 0.1),
          borderColor: AppColors.info.withValues(alpha: 0.3),
          textColor: AppColors.info,
          iconColor: AppColors.info,
        );
      
      case ConsultationStatus.inProgress:
        return _StatusConfig(
          label: 'In Progress',
          icon: Icons.chat_bubble_outline,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          borderColor: AppColors.primary.withValues(alpha: 0.3),
          textColor: AppColors.primary,
          iconColor: AppColors.primary,
        );
      
      case ConsultationStatus.completed:
        return _StatusConfig(
          label: 'Completed',
          icon: Icons.check_circle,
          backgroundColor: AppColors.success.withValues(alpha: 0.1),
          borderColor: AppColors.success.withValues(alpha: 0.3),
          textColor: AppColors.success,
          iconColor: AppColors.success,
        );
      
      case ConsultationStatus.cancelled:
        return _StatusConfig(
          label: 'Cancelled',
          icon: Icons.cancel_outlined,
          backgroundColor: AppColors.error.withValues(alpha: 0.1),
          borderColor: AppColors.error.withValues(alpha: 0.3),
          textColor: AppColors.error,
          iconColor: AppColors.error,
        );
      
      case ConsultationStatus.declined:
        return _StatusConfig(
          label: 'Declined',
          icon: Icons.close_outlined,
          backgroundColor: AppColors.error.withValues(alpha: 0.1),
          borderColor: AppColors.error.withValues(alpha: 0.3),
          textColor: AppColors.error,
          iconColor: AppColors.error,
        );
      
      case ConsultationStatus.rescheduled:
        return _StatusConfig(
          label: 'Rescheduled',
          icon: Icons.update,
          backgroundColor: AppColors.accent.withValues(alpha: 0.1),
          borderColor: AppColors.accent.withValues(alpha: 0.3),
          textColor: AppColors.accent,
          iconColor: AppColors.accent,
        );
      
      case ConsultationStatus.paid:
        return _StatusConfig(
          label: 'Paid',
          icon: Icons.payment,
          backgroundColor: AppColors.success.withValues(alpha: 0.1),
          borderColor: AppColors.success.withValues(alpha: 0.3),
          textColor: AppColors.success,
          iconColor: AppColors.success,
        );
      
      case ConsultationStatus.unpaid:
        return _StatusConfig(
          label: 'Payment Due',
          icon: Icons.payments_outlined,
          backgroundColor: AppColors.warning.withValues(alpha: 0.1),
          borderColor: AppColors.warning.withValues(alpha: 0.3),
          textColor: AppColors.warning,
          iconColor: AppColors.warning,
        );
      
      case ConsultationStatus.refunded:
        return _StatusConfig(
          label: 'Refunded',
          icon: Icons.money_off,
          backgroundColor: AppColors.info.withValues(alpha: 0.1),
          borderColor: AppColors.info.withValues(alpha: 0.3),
          textColor: AppColors.info,
          iconColor: AppColors.info,
        );
    }
  }

  _SizeConfig _getSizeConfig(ConsultationStatusBadgeSize size) {
    switch (size) {
      case ConsultationStatusBadgeSize.small:
        return _SizeConfig(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          fontSize: 11,
          iconSize: 12,
          spacing: 3,
          borderRadius: 4,
        );
      
      case ConsultationStatusBadgeSize.medium:
        return _SizeConfig(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          fontSize: 12,
          iconSize: 14,
          spacing: 4,
          borderRadius: 6,
        );
      
      case ConsultationStatusBadgeSize.large:
        return _SizeConfig(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          fontSize: 14,
          iconSize: 16,
          spacing: 6,
          borderRadius: 8,
        );
    }
  }
}

/// Multi-status badge for displaying multiple statuses
class MultiStatusBadge extends StatelessWidget {
  final List<ConsultationStatus> statuses;
  final ConsultationStatusBadgeSize size;
  final int maxVisible;
  final bool showIcon;

  const MultiStatusBadge({
    super.key,
    required this.statuses,
    this.size = ConsultationStatusBadgeSize.small,
    this.maxVisible = 2,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    if (statuses.isEmpty) return const SizedBox.shrink();

    final visibleStatuses = statuses.take(maxVisible).toList();
    final remainingCount = statuses.length - maxVisible;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...visibleStatuses.asMap().entries.map((entry) {
          final index = entry.key;
          final status = entry.value;
          return Padding(
            padding: EdgeInsets.only(right: index < visibleStatuses.length - 1 ? 4 : 0),
            child: ConsultationStatusBadge(
              status: status,
              size: size,
              showIcon: showIcon,
            ),
          );
        }),
        if (remainingCount > 0) ...[
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.textTertiary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '+$remainingCount',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Status progress indicator
class ConsultationStatusProgress extends StatelessWidget {
  final ConsultationStatus currentStatus;
  final double progress;
  final bool showLabels;
  final Axis direction;

  const ConsultationStatusProgress({
    super.key,
    required this.currentStatus,
    this.progress = 0.0,
    this.showLabels = true,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      ConsultationStatus.pending,
      ConsultationStatus.accepted,
      ConsultationStatus.inProgress,
      ConsultationStatus.completed,
    ];

    final currentIndex = steps.indexOf(currentStatus);
    final isCompleted = currentStatus == ConsultationStatus.completed;

    if (direction == Axis.horizontal) {
      return _buildHorizontalProgress(context, steps, currentIndex, isCompleted);
    } else {
      return _buildVerticalProgress(context, steps, currentIndex, isCompleted);
    }
  }

  Widget _buildHorizontalProgress(BuildContext context, List<ConsultationStatus> steps, int currentIndex, bool isCompleted) {
    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: isCompleted ? 1.0 : (currentIndex + progress) / (steps.length - 1),
          backgroundColor: AppColors.surfaceVariant,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
        if (showLabels) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: steps.map((status) {
              final index = steps.indexOf(status);
              final isActive = index <= currentIndex;
              return ConsultationStatusBadge.small(
                status: status,
                showIcon: false,
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildVerticalProgress(BuildContext context, List<ConsultationStatus> steps, int currentIndex, bool isCompleted) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final status = entry.value;
        final isActive = index <= currentIndex;
        final isLast = index == steps.length - 1;

        return Row(
          children: [
            Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : AppColors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: isActive
                      ? Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.white,
                        )
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 30,
                    color: isActive ? AppColors.primary : AppColors.surfaceVariant,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ConsultationStatusBadge.small(
                status: status,
                showIcon: false,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

/// Badge size variants
enum ConsultationStatusBadgeSize {
  small,
  medium,
  large,
}

/// Consultation status types
enum ConsultationStatus {
  pending,
  accepted,
  inProgress,
  completed,
  cancelled,
  declined,
  rescheduled,
  paid,
  unpaid,
  refunded,
}

/// Status configuration
class _StatusConfig {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;

  _StatusConfig({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
  });
}

/// Size configuration
class _SizeConfig {
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final double iconSize;
  final double spacing;
  final double borderRadius;

  _SizeConfig({
    required this.padding,
    required this.fontSize,
    required this.iconSize,
    required this.spacing,
    required this.borderRadius,
  });
}