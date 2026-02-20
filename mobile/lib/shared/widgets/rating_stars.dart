import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Reusable star rating widget for displaying and inputting ratings
class RatingStars extends StatefulWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool allowHalfRating;
  final bool isInteractive;
  final Function(double)? onRatingChanged;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final bool showRatingText;
  final TextStyle? ratingTextStyle;

  const RatingStars({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24,
    this.activeColor,
    this.inactiveColor,
    this.allowHalfRating = true,
    this.isInteractive = false,
    this.onRatingChanged,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.showRatingText = false,
    this.ratingTextStyle,
  });

  /// Display-only rating stars constructor
  const RatingStars.display({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 20,
    this.activeColor,
    this.inactiveColor,
    this.allowHalfRating = true,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.showRatingText = false,
    this.ratingTextStyle,
  })  : isInteractive = false,
        onRatingChanged = null;

  /// Interactive rating stars constructor for user input
  const RatingStars.input({
    super.key,
    required this.onRatingChanged,
    this.rating = 0,
    this.maxRating = 5,
    this.size = 32,
    this.activeColor,
    this.inactiveColor,
    this.allowHalfRating = false,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.showRatingText = true,
    this.ratingTextStyle,
  }) : isInteractive = true;

  /// Small rating stars for compact displays
  const RatingStars.small({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.activeColor,
    this.inactiveColor,
    this.allowHalfRating = true,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.showRatingText = false,
  })  : size = 16,
        isInteractive = false,
        onRatingChanged = null,
        ratingTextStyle = null;

  /// Large rating stars for emphasis
  const RatingStars.large({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.activeColor,
    this.inactiveColor,
    this.allowHalfRating = true,
    this.isInteractive = false,
    this.onRatingChanged,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.showRatingText = true,
    this.ratingTextStyle,
  }) : size = 40;

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  @override
  void didUpdateWidget(RatingStars oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rating != widget.rating) {
      _currentRating = widget.rating;
    }
  }

  void _handleRatingChanged(double newRating) {
    if (!widget.isInteractive) return;

    setState(() {
      _currentRating = newRating;
    });
    widget.onRatingChanged?.call(newRating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: widget.mainAxisSize,
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        ...List.generate(widget.maxRating, (index) {
          return _buildStar(index);
        }),
        if (widget.showRatingText) ...[
          const SizedBox(width: 8),
          Text(
            _formatRating(_currentRating),
            style: widget.ratingTextStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildStar(int index) {
    final starPosition = index + 1;
    final difference = _currentRating - index;
    
    IconData iconData;
    Color color;

    if (difference >= 1) {
      // Full star
      iconData = Icons.star;
      color = widget.activeColor ?? AppColors.accent;
    } else if (difference > 0 && difference < 1 && widget.allowHalfRating) {
      // Half star
      iconData = Icons.star_half;
      color = widget.activeColor ?? AppColors.accent;
    } else {
      // Empty star
      iconData = Icons.star_outline;
      color = widget.inactiveColor ?? AppColors.textTertiary;
    }

    Widget star = Icon(
      iconData,
      size: widget.size,
      color: color,
    );

    if (widget.isInteractive) {
      return GestureDetector(
        onTap: () {
          double newRating = starPosition.toDouble();
          _handleRatingChanged(newRating);
        },
        onPanUpdate: (details) {
          // Calculate rating based on pan position
          final RenderBox box = context.findRenderObject() as RenderBox;
          final localPosition = box.globalToLocal(details.globalPosition);
          final starWidth = widget.size + 4; // Add some padding
          final starIndex = (localPosition.dx / starWidth).floor();
          
          if (starIndex >= 0 && starIndex < widget.maxRating) {
            double newRating;
            if (widget.allowHalfRating) {
              final withinStarPosition = (localPosition.dx % starWidth) / starWidth;
              newRating = starIndex + (withinStarPosition > 0.5 ? 1.0 : 0.5);
            } else {
              newRating = (starIndex + 1).toDouble();
            }
            
            if (newRating != _currentRating) {
              _handleRatingChanged(newRating.clamp(0, widget.maxRating.toDouble()));
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: star,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: star,
    );
  }

  String _formatRating(double rating) {
    if (rating == rating.toInt()) {
      return rating.toInt().toString();
    } else {
      return rating.toStringAsFixed(1);
    }
  }
}

/// Rating display widget with additional info
class RatingDisplay extends StatelessWidget {
  final double rating;
  final int? reviewCount;
  final double starSize;
  final Color? starColor;
  final TextStyle? ratingTextStyle;
  final TextStyle? reviewTextStyle;
  final bool showReviewCount;
  final String? reviewLabel;
  final MainAxisAlignment alignment;

  const RatingDisplay({
    super.key,
    required this.rating,
    this.reviewCount,
    this.starSize = 16,
    this.starColor,
    this.ratingTextStyle,
    this.reviewTextStyle,
    this.showReviewCount = true,
    this.reviewLabel,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: [
        RatingStars.display(
          rating: rating,
          size: starSize,
          activeColor: starColor,
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: ratingTextStyle ??
              Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
        ),
        if (showReviewCount && reviewCount != null) ...[
          const SizedBox(width: 4),
          Text(
            '(${_formatReviewCount(reviewCount!)})',
            style: reviewTextStyle ??
                Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
          ),
        ],
      ],
    );
  }

  String _formatReviewCount(int count) {
    final label = reviewLabel ?? 'review';
    final pluralLabel = reviewLabel != null ? '${reviewLabel}s' : 'reviews';
    
    if (count == 1) {
      return '1 $label';
    } else if (count < 1000) {
      return '$count $pluralLabel';
    } else if (count < 1000000) {
      final k = count / 1000;
      return '${k.toStringAsFixed(k == k.toInt() ? 0 : 1)}k $pluralLabel';
    } else {
      final m = count / 1000000;
      return '${m.toStringAsFixed(m == m.toInt() ? 0 : 1)}m $pluralLabel';
    }
  }
}

/// Compact rating badge
class RatingBadge extends StatelessWidget {
  final double rating;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const RatingBadge({
    super.key,
    required this.rating,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor ?? _getRatingColor(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: (fontSize ?? 12) + 2,
            color: textColor ?? Colors.white,
          ),
          const SizedBox(width: 2),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: fontSize ?? 12,
              fontWeight: FontWeight.w600,
              color: textColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor() {
    if (rating >= 4.5) {
      return AppColors.success;
    } else if (rating >= 4.0) {
      return AppColors.accent;
    } else if (rating >= 3.0) {
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }
}