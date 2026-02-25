import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Standardized card widget with consistent styling
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final double? elevation;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isClickable;
  final Clip clipBehavior;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.boxShadow,
    this.elevation,
    this.onTap,
    this.onLongPress,
    this.isClickable = false,
    this.clipBehavior = Clip.none,
  });

  /// Elevated card with shadow
  const AppCard.elevated({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.onTap,
    this.onLongPress,
    this.clipBehavior = Clip.none,
  })  : borderColor = null,
        borderWidth = null,
        borderRadius = null,
        boxShadow = null,
        elevation = 4,
        isClickable = false;

  /// Outlined card with border
  const AppCard.outlined({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.onTap,
    this.onLongPress,
    this.clipBehavior = Clip.none,
  })  : borderWidth = 1,
        borderRadius = null,
        boxShadow = null,
        elevation = null,
        isClickable = false;

  /// Clickable card for interactive elements
  const AppCard.clickable({
    super.key,
    required this.child,
    required this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.boxShadow,
    this.elevation,
    this.onLongPress,
    this.clipBehavior = Clip.none,
  }) : isClickable = true;

  /// Simple card with minimal styling
  const AppCard.simple({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.onTap,
    this.onLongPress,
    this.clipBehavior = Clip.none,
  })  : borderColor = null,
        borderWidth = null,
        borderRadius = null,
        boxShadow = null,
        elevation = null,
        isClickable = false;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(12);
    final effectivePadding = padding ?? const EdgeInsets.all(16);
    final effectiveBackgroundColor = backgroundColor ?? AppColors.surface;

    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: effectiveBorderRadius,
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: borderWidth ?? 1,
              )
            : null,
        boxShadow: boxShadow ?? _getDefaultShadow(),
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        clipBehavior: clipBehavior,
        child: Padding(
          padding: effectivePadding,
          child: child,
        ),
      ),
    );

    if (isClickable || onTap != null || onLongPress != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: effectiveBorderRadius,
          splashColor: AppColors.primary.withValues(alpha: 0.1),
          highlightColor: AppColors.primary.withValues(alpha: 0.05),
          child: card,
        ),
      );
    }

    if (elevation != null && elevation! > 0) {
      card = Material(
        elevation: elevation!,
        borderRadius: effectiveBorderRadius,
        color: effectiveBackgroundColor,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        child: ClipRRect(
          borderRadius: effectiveBorderRadius,
          clipBehavior: clipBehavior,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: effectiveBorderRadius,
            splashColor: AppColors.primary.withValues(alpha: 0.1),
            highlightColor: AppColors.primary.withValues(alpha: 0.05),
            child: Container(
              margin: margin,
              padding: effectivePadding,
              child: child,
            ),
          ),
        ),
      );
    }

    return card;
  }

  List<BoxShadow>? _getDefaultShadow() {
    if (elevation != null && elevation! > 0) {
      return null; // Let Material widget handle shadow
    }
    
    if (borderColor != null) {
      return null; // No shadow for outlined cards
    }

    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }
}

/// Specialized card variants for common use cases

/// Card for displaying list items
class AppListCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool showBorder;

  const AppListCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.margin,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard.outlined(
      onTap: onTap,
      onLongPress: onLongPress,
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin ?? const EdgeInsets.only(bottom: 8),
      borderColor: showBorder ? AppColors.border : Colors.transparent,
      child: child,
    );
  }
}

/// Card for displaying information sections
class AppInfoCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const AppInfoCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.margin,
  });

  const AppInfoCard.info({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  })  : backgroundColor = AppColors.info,
        borderColor = null;

  const AppInfoCard.success({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  })  : backgroundColor = AppColors.success,
        borderColor = null;

  const AppInfoCard.warning({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  })  : backgroundColor = AppColors.warning,
        borderColor = null;

  const AppInfoCard.error({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  })  : backgroundColor = AppColors.error,
        borderColor = null;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: backgroundColor?.withValues(alpha: 0.1) ?? AppColors.surfaceVariant,
      borderColor: borderColor ?? backgroundColor,
      borderWidth: 1,
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      child: child,
    );
  }
}

/// Card with header and content sections
class AppHeaderCard extends StatelessWidget {
  final Widget header;
  final Widget content;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? margin;
  final bool showDivider;

  const AppHeaderCard({
    super.key,
    required this.header,
    required this.content,
    this.onTap,
    this.onLongPress,
    this.margin,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard.clickable(
      onTap: onTap ?? () {},
      onLongPress: onLongPress,
      margin: margin,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: header,
          ),
          if (showDivider)
            const Divider(
              height: 1,
              color: AppColors.border,
              indent: 16,
              endIndent: 16,
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: content,
          ),
        ],
      ),
    );
  }
}