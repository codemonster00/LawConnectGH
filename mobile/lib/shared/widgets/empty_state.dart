import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'app_button.dart';

/// Reusable empty state widget with icon, text, and optional action
class EmptyState extends StatelessWidget {
  final IconData? icon;
  final String? iconAsset;
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onAction;
  final Color? iconColor;
  final double? iconSize;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsetsGeometry? padding;
  final Widget? customIcon;

  const EmptyState({
    super.key,
    this.icon,
    this.iconAsset,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onAction,
    this.iconColor,
    this.iconSize,
    this.titleStyle,
    this.subtitleStyle,
    this.padding,
    this.customIcon,
  });

  /// Empty state for no search results
  const EmptyState.search({
    super.key,
    this.subtitle = 'Try adjusting your search or filters to find what you\'re looking for.',
    this.actionText = 'Clear Filters',
    this.onAction,
    this.padding,
  })  : icon = Icons.search_off,
        iconAsset = null,
        title = 'No results found',
        iconColor = null,
        iconSize = null,
        titleStyle = null,
        subtitleStyle = null,
        customIcon = null;

  /// Empty state for no lawyers
  const EmptyState.noLawyers({
    super.key,
    this.subtitle = 'We couldn\'t find any lawyers matching your criteria. Try adjusting your filters.',
    this.actionText = 'Browse All Lawyers',
    this.onAction,
    this.padding,
  })  : icon = Icons.people_outline,
        iconAsset = null,
        title = 'No lawyers found',
        iconColor = null,
        iconSize = null,
        titleStyle = null,
        subtitleStyle = null,
        customIcon = null;

  /// Empty state for no consultations
  const EmptyState.noConsultations({
    super.key,
    this.subtitle = 'Start your first consultation with a verified lawyer.',
    this.actionText = 'Find a Lawyer',
    this.onAction,
    this.padding,
  })  : icon = Icons.chat_bubble_outline,
        iconAsset = null,
        title = 'No consultations yet',
        iconColor = null,
        iconSize = null,
        titleStyle = null,
        subtitleStyle = null,
        customIcon = null;

  /// Empty state for no notifications
  const EmptyState.noNotifications({
    super.key,
    this.subtitle = 'You\'re all caught up! Notifications about consultations, messages, and updates will appear here.',
    this.actionText,
    this.onAction,
    this.padding,
  })  : icon = Icons.notifications_none,
        iconAsset = null,
        title = 'No notifications',
        iconColor = null,
        iconSize = null,
        titleStyle = null,
        subtitleStyle = null,
        customIcon = null;

  /// Empty state for no documents
  const EmptyState.noDocuments({
    super.key,
    this.subtitle = 'Generate legal documents using our templates.',
    this.actionText = 'Browse Templates',
    this.onAction,
    this.padding,
  })  : icon = Icons.description_outlined,
        iconAsset = null,
        title = 'No documents',
        iconColor = null,
        iconSize = null,
        titleStyle = null,
        subtitleStyle = null,
        customIcon = null;

  /// Empty state for no favorites
  const EmptyState.noFavorites({
    super.key,
    this.subtitle = 'Save lawyers you like to easily find them later.',
    this.actionText = 'Explore Lawyers',
    this.onAction,
    this.padding,
  })  : icon = Icons.favorite_border,
        iconAsset = null,
        title = 'No favorites yet',
        iconColor = null,
        iconSize = null,
        titleStyle = null,
        subtitleStyle = null,
        customIcon = null;

  /// Empty state for network error
  const EmptyState.networkError({
    super.key,
    this.subtitle = 'Please check your internet connection and try again.',
    this.actionText = 'Retry',
    this.onAction,
    this.padding,
  })  : icon = Icons.wifi_off,
        iconAsset = null,
        title = 'No internet connection',
        iconColor = AppColors.error,
        iconSize = null,
        titleStyle = null,
        subtitleStyle = null,
        customIcon = null;

  /// Empty state for no data
  const EmptyState.noData({
    super.key,
    this.subtitle = 'There\'s nothing to show right now.',
    this.actionText = 'Refresh',
    this.onAction,
    this.padding,
  })  : icon = Icons.inbox_outlined,
        iconAsset = null,
        title = 'Nothing here',
        iconColor = null,
        iconSize = null,
        titleStyle = null,
        subtitleStyle = null,
        customIcon = null;

  /// Empty state for maintenance
  const EmptyState.maintenance({
    super.key,
    this.subtitle = 'We\'re working to improve your experience. Please try again later.',
    this.actionText,
    this.onAction,
    this.padding,
  })  : icon = Icons.build_outlined,
        iconAsset = null,
        title = 'Under maintenance',
        iconColor = AppColors.warning,
        iconSize = null,
        titleStyle = null,
        subtitleStyle = null,
        customIcon = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            _buildIcon(),
            const SizedBox(height: 24),
            
            // Title
            Text(
              title,
              style: titleStyle ??
                  Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            
            // Subtitle
            if (subtitle != null) ...[
              const SizedBox(height: 16),
              Text(
                subtitle!,
                style: subtitleStyle ??
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textTertiary,
                      height: 1.5,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            
            // Action button
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 32),
              AppButton.primary(
                text: actionText!,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (customIcon != null) {
      return customIcon!;
    }

    if (iconAsset != null) {
      return Image.asset(
        iconAsset!,
        width: iconSize ?? 80,
        height: iconSize ?? 80,
        color: iconColor ?? AppColors.textTertiary,
      );
    }

    return Icon(
      icon ?? Icons.inbox_outlined,
      size: iconSize ?? 80,
      color: iconColor ?? AppColors.textTertiary,
    );
  }
}

/// Compact empty state for smaller spaces
class CompactEmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? actionText;
  final VoidCallback? onAction;
  final Color? iconColor;

  const CompactEmptyState({
    super.key,
    required this.icon,
    required this.message,
    this.actionText,
    this.onAction,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: iconColor ?? AppColors.textTertiary,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          if (actionText != null && onAction != null) ...[
            const SizedBox(height: 16),
            AppButton.outline(
              text: actionText!,
              onPressed: onAction,
              size: AppButtonSize.small,
            ),
          ],
        ],
      ),
    );
  }
}

/// Horizontal empty state for wide layouts
class HorizontalEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onAction;

  const HorizontalEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Icon(
            icon,
            size: 60,
            color: AppColors.textTertiary,
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                if (actionText != null && onAction != null) ...[
                  const SizedBox(height: 16),
                  AppButton.primary(
                    text: actionText!,
                    onPressed: onAction,
                    size: AppButtonSize.small,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Empty state with custom illustration
class IllustratedEmptyState extends StatelessWidget {
  final String illustrationPath;
  final String title;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onAction;
  final double? illustrationHeight;

  const IllustratedEmptyState({
    super.key,
    required this.illustrationPath,
    required this.title,
    required this.subtitle,
    this.actionText,
    this.onAction,
    this.illustrationHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              illustrationPath,
              height: illustrationHeight ?? 120,
            ),
            const SizedBox(height: 32),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textTertiary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 32),
              AppButton.primary(
                text: actionText!,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}