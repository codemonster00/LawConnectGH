import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Standardized button widget with different variants and loading state
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final Widget? prefix;
  final Widget? suffix;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.prefix,
    this.suffix,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  });

  /// Primary button constructor
  const AppButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.prefix,
    this.suffix,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  }) : variant = AppButtonVariant.primary;

  /// Secondary button constructor
  const AppButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.prefix,
    this.suffix,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  }) : variant = AppButtonVariant.secondary;

  /// Outline button constructor
  const AppButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.prefix,
    this.suffix,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  }) : variant = AppButtonVariant.outline;

  /// Ghost button constructor
  const AppButton.ghost({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.prefix,
    this.suffix,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  }) : variant = AppButtonVariant.ghost;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle();
    final isDisabled = onPressed == null || isLoading;

    Widget child = _buildButtonContent();

    if (isFullWidth) {
      child = SizedBox(
        width: double.infinity,
        child: child,
      );
    }

    return child;
  }

  Widget _buildButtonContent() {
    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: _getElevatedButtonStyle(),
          child: _buildContent(),
        );
      case AppButtonVariant.secondary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: _getSecondaryButtonStyle(),
          child: _buildContent(),
        );
      case AppButtonVariant.outline:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: _getOutlinedButtonStyle(),
          child: _buildContent(),
        );
      case AppButtonVariant.ghost:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: _getTextButtonStyle(),
          child: _buildContent(),
        );
    }
  }

  Widget _buildContent() {
    final children = <Widget>[];

    if (prefix != null) {
      children.add(prefix!);
      children.add(const SizedBox(width: 8));
    }

    if (icon != null && !isLoading) {
      children.add(Icon(icon, size: _getIconSize()));
      children.add(const SizedBox(width: 8));
    }

    if (isLoading) {
      children.add(
        SizedBox(
          width: _getIconSize(),
          height: _getIconSize(),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getLoadingColor(),
            ),
          ),
        ),
      );
      children.add(const SizedBox(width: 8));
    }

    children.add(
      Text(
        text,
        style: TextStyle(
          fontSize: _getFontSize(),
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (suffix != null) {
      children.add(const SizedBox(width: 8));
      children.add(suffix!);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  ButtonStyle _getElevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? AppColors.primary,
      foregroundColor: textColor ?? AppColors.textInverse,
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(_getBorderRadius()),
      ),
      elevation: 2,
      shadowColor: AppColors.primary.withOpacity(0.3),
      disabledBackgroundColor: AppColors.surfaceVariant,
      disabledForegroundColor: AppColors.textTertiary,
    );
  }

  ButtonStyle _getSecondaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? AppColors.surfaceVariant,
      foregroundColor: textColor ?? AppColors.textPrimary,
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(_getBorderRadius()),
      ),
      elevation: 0,
      disabledBackgroundColor: AppColors.surfaceVariant.withOpacity(0.5),
      disabledForegroundColor: AppColors.textTertiary,
    );
  }

  ButtonStyle _getOutlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: textColor ?? AppColors.primary,
      padding: _getPadding(),
      side: BorderSide(
        color: textColor ?? AppColors.primary,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(_getBorderRadius()),
      ),
      disabledForegroundColor: AppColors.textTertiary,
    );
  }

  ButtonStyle _getTextButtonStyle() {
    return TextButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: textColor ?? AppColors.primary,
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(_getBorderRadius()),
      ),
      disabledForegroundColor: AppColors.textTertiary,
    );
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  double _getFontSize() {
    switch (size) {
      case AppButtonSize.small:
        return 14;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 18;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case AppButtonSize.small:
        return 8;
      case AppButtonSize.medium:
        return 12;
      case AppButtonSize.large:
        return 16;
    }
  }

  Color _getLoadingColor() {
    switch (variant) {
      case AppButtonVariant.primary:
        return textColor ?? AppColors.textInverse;
      case AppButtonVariant.secondary:
        return textColor ?? AppColors.textPrimary;
      case AppButtonVariant.outline:
      case AppButtonVariant.ghost:
        return textColor ?? AppColors.primary;
    }
  }

  ButtonStyle _getButtonStyle() {
    // This method is kept for backward compatibility
    switch (variant) {
      case AppButtonVariant.primary:
        return _getElevatedButtonStyle();
      case AppButtonVariant.secondary:
        return _getSecondaryButtonStyle();
      case AppButtonVariant.outline:
        return _getOutlinedButtonStyle();
      case AppButtonVariant.ghost:
        return _getTextButtonStyle();
    }
  }
}

/// Button variants
enum AppButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
}

/// Button sizes
enum AppButtonSize {
  small,
  medium,
  large,
}