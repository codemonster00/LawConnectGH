import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/errors/exceptions.dart';
import 'app_button.dart';

/// Reusable error state widget with retry functionality
class ErrorState extends StatelessWidget {
  final String? title;
  final String? message;
  final IconData? icon;
  final String? iconAsset;
  final String? retryText;
  final VoidCallback? onRetry;
  final String? secondaryActionText;
  final VoidCallback? onSecondaryAction;
  final Color? iconColor;
  final double? iconSize;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry? padding;
  final bool showIcon;

  const ErrorState({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.iconAsset,
    this.retryText = 'Try Again',
    this.onRetry,
    this.secondaryActionText,
    this.onSecondaryAction,
    this.iconColor,
    this.iconSize,
    this.titleStyle,
    this.messageStyle,
    this.padding,
    this.showIcon = true,
  });

  /// Network error state
  const ErrorState.network({
    super.key,
    this.onRetry,
    this.padding,
    this.secondaryActionText,
    this.onSecondaryAction,
  })  : title = 'Connection Error',
        message = 'Please check your internet connection and try again.',
        icon = Icons.wifi_off,
        iconAsset = null,
        retryText = 'Retry',
        iconColor = AppColors.error,
        iconSize = null,
        titleStyle = null,
        messageStyle = null,
        showIcon = true;

  /// Server error state
  const ErrorState.server({
    super.key,
    this.onRetry,
    this.padding,
    this.secondaryActionText,
    this.onSecondaryAction,
  })  : title = 'Server Error',
        message = 'Something went wrong on our end. Please try again later.',
        icon = Icons.cloud_off_outlined,
        iconAsset = null,
        retryText = 'Retry',
        iconColor = AppColors.error,
        iconSize = null,
        titleStyle = null,
        messageStyle = null,
        showIcon = true;

  /// Not found error state
  const ErrorState.notFound({
    super.key,
    this.title = 'Not Found',
    this.message = 'The content you\'re looking for doesn\'t exist.',
    this.onRetry,
    this.retryText = 'Go Back',
    this.padding,
    this.secondaryActionText,
    this.onSecondaryAction,
  })  : icon = Icons.search_off,
        iconAsset = null,
        iconColor = AppColors.textTertiary,
        iconSize = null,
        titleStyle = null,
        messageStyle = null,
        showIcon = true;

  /// Unauthorized error state
  const ErrorState.unauthorized({
    super.key,
    this.onRetry,
    this.padding,
    this.secondaryActionText,
    this.onSecondaryAction,
  })  : title = 'Authentication Required',
        message = 'Please sign in to access this content.',
        icon = Icons.lock_outline,
        iconAsset = null,
        retryText = 'Sign In',
        iconColor = AppColors.warning,
        iconSize = null,
        titleStyle = null,
        messageStyle = null,
        showIcon = true;

  /// Forbidden error state
  const ErrorState.forbidden({
    super.key,
    this.onRetry,
    this.padding,
    this.secondaryActionText,
    this.onSecondaryAction,
  })  : title = 'Access Denied',
        message = 'You don\'t have permission to access this content.',
        icon = Icons.block,
        iconAsset = null,
        retryText = 'Go Back',
        iconColor = AppColors.error,
        iconSize = null,
        titleStyle = null,
        messageStyle = null,
        showIcon = true;

  /// Payment error state
  const ErrorState.payment({
    super.key,
    this.onRetry,
    this.padding,
    this.secondaryActionText,
    this.onSecondaryAction,
  })  : title = 'Payment Failed',
        message = 'There was an issue processing your payment. Please try again.',
        icon = Icons.payment,
        iconAsset = null,
        retryText = 'Retry Payment',
        iconColor = AppColors.error,
        iconSize = null,
        titleStyle = null,
        messageStyle = null,
        showIcon = true;

  /// Generic error state from exception
  ErrorState.fromException(
    Exception exception, {
    super.key,
    this.onRetry,
    this.padding,
    this.secondaryActionText,
    this.onSecondaryAction,
  })  : title = _getTitleFromException(exception),
        message = _getMessageFromException(exception),
        icon = _getIconFromException(exception),
        iconAsset = null,
        retryText = 'Try Again',
        iconColor = AppColors.error,
        iconSize = null,
        titleStyle = null,
        messageStyle = null,
        showIcon = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            if (showIcon) ...[
              _buildIcon(),
              const SizedBox(height: 24),
            ],
            
            // Title
            if (title != null) ...[
              Text(
                title!,
                style: titleStyle ??
                    Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
            
            // Message
            if (message != null) ...[
              Text(
                message!,
                style: messageStyle ??
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
            ],
            
            // Action buttons
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (iconAsset != null) {
      return Image.asset(
        iconAsset!,
        width: iconSize ?? 80,
        height: iconSize ?? 80,
        color: iconColor ?? AppColors.error,
      );
    }

    return Icon(
      icon ?? Icons.error_outline,
      size: iconSize ?? 80,
      color: iconColor ?? AppColors.error,
    );
  }

  Widget _buildActions() {
    final hasRetry = onRetry != null;
    final hasSecondaryAction = onSecondaryAction != null && secondaryActionText != null;

    if (!hasRetry && !hasSecondaryAction) {
      return const SizedBox.shrink();
    }

    if (hasRetry && hasSecondaryAction) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AppButton.outline(
              text: secondaryActionText!,
              onPressed: onSecondaryAction,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppButton.primary(
              text: retryText!,
              onPressed: onRetry,
            ),
          ),
        ],
      );
    }

    if (hasRetry) {
      return AppButton.primary(
        text: retryText!,
        onPressed: onRetry,
      );
    }

    return AppButton.outline(
      text: secondaryActionText!,
      onPressed: onSecondaryAction,
    );
  }

  static String _getTitleFromException(Exception exception) {
    if (exception is NetworkException) {
      return 'Connection Error';
    } else if (exception is ServerException) {
      return 'Server Error';
    } else if (exception is UnauthorizedException) {
      return 'Authentication Required';
    } else if (exception is ForbiddenException) {
      return 'Access Denied';
    } else if (exception is NotFoundException) {
      return 'Not Found';
    } else if (exception is ValidationException) {
      return 'Invalid Data';
    } else if (exception is PaymentException) {
      return 'Payment Error';
    } else {
      return 'Something Went Wrong';
    }
  }

  static String _getMessageFromException(Exception exception) {
    if (exception is AppException) {
      return exception.message;
    }
    return 'An unexpected error occurred. Please try again.';
  }

  static IconData _getIconFromException(Exception exception) {
    if (exception is NetworkException) {
      return Icons.wifi_off;
    } else if (exception is ServerException) {
      return Icons.cloud_off_outlined;
    } else if (exception is UnauthorizedException) {
      return Icons.lock_outline;
    } else if (exception is ForbiddenException) {
      return Icons.block;
    } else if (exception is NotFoundException) {
      return Icons.search_off;
    } else if (exception is ValidationException) {
      return Icons.warning_outlined;
    } else if (exception is PaymentException) {
      return Icons.payment;
    } else {
      return Icons.error_outline;
    }
  }
}

/// Compact error state for smaller spaces
class CompactErrorState extends StatelessWidget {
  final String message;
  final String? retryText;
  final VoidCallback? onRetry;
  final IconData? icon;
  final Color? iconColor;

  const CompactErrorState({
    super.key,
    required this.message,
    this.retryText = 'Retry',
    this.onRetry,
    this.icon,
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
            icon ?? Icons.error_outline,
            size: 40,
            color: iconColor ?? AppColors.error,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            AppButton.outline(
              text: retryText!,
              onPressed: onRetry,
              size: AppButtonSize.small,
            ),
          ],
        ],
      ),
    );
  }
}

/// Inline error state for forms and inputs
class InlineErrorState extends StatelessWidget {
  final String message;
  final String? retryText;
  final VoidCallback? onRetry;
  final IconData? icon;

  const InlineErrorState({
    super.key,
    required this.message,
    this.retryText,
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.error.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon ?? Icons.error_outline,
            size: 20,
            color: AppColors.error,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onRetry,
              child: Text(
                retryText ?? 'Retry',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Error snackbar helper
class ErrorSnackBar {
  static void show(
    BuildContext context,
    String message, {
    String? actionText,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.error,
        duration: duration,
        action: actionText != null && onAction != null
            ? SnackBarAction(
                label: actionText,
                textColor: Colors.white,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }

  static void showFromException(
    BuildContext context,
    Exception exception, {
    String? actionText,
    VoidCallback? onAction,
  }) {
    final message = exception is AppException 
        ? exception.message 
        : 'An error occurred';
    
    show(
      context,
      message,
      actionText: actionText,
      onAction: onAction,
    );
  }
}