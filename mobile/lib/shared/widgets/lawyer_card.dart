import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/formatters.dart';
import 'app_card.dart';
import 'rating_stars.dart';
import 'shimmer_loading.dart';

/// Reusable lawyer card widget for lists and search results
class LawyerCard extends StatelessWidget {
  final String id;
  final String name;
  final String specialty;
  final String? lawFirm;
  final double rating;
  final int reviewCount;
  final double consultationFee;
  final bool isAvailable;
  final int? responseTime;
  final String? imageUrl;
  final int? experience;
  final String? location;
  final List<String>? badges;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;
  final bool isFavorite;
  final LawyerCardVariant variant;

  const LawyerCard({
    super.key,
    required this.id,
    required this.name,
    required this.specialty,
    this.lawFirm,
    required this.rating,
    required this.reviewCount,
    required this.consultationFee,
    required this.isAvailable,
    this.responseTime,
    this.imageUrl,
    this.experience,
    this.location,
    this.badges,
    this.onTap,
    this.onFavoritePressed,
    this.isFavorite = false,
    this.variant = LawyerCardVariant.standard,
  });

  /// Compact variant constructor
  const LawyerCard.compact({
    super.key,
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.consultationFee,
    required this.isAvailable,
    this.lawFirm,
    this.responseTime,
    this.imageUrl,
    this.location,
    this.onTap,
    this.onFavoritePressed,
    this.isFavorite = false,
  })  : experience = null,
        badges = null,
        variant = LawyerCardVariant.compact;

  /// Featured variant constructor
  const LawyerCard.featured({
    super.key,
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.consultationFee,
    required this.isAvailable,
    this.lawFirm,
    this.responseTime,
    this.imageUrl,
    this.experience,
    this.location,
    this.badges,
    this.onTap,
    this.onFavoritePressed,
    this.isFavorite = false,
  }) : variant = LawyerCardVariant.featured;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case LawyerCardVariant.compact:
        return _buildCompactCard(context);
      case LawyerCardVariant.featured:
        return _buildFeaturedCard(context);
      case LawyerCardVariant.standard:
      default:
        return _buildStandardCard(context);
    }
  }

  Widget _buildStandardCard(BuildContext context) {
    return AppCard.clickable(
      onTap: onTap ?? () {},
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image
              _buildProfileImage(60),
              const SizedBox(width: 12),
              
              // Lawyer info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (onFavoritePressed != null) _buildFavoriteButton(),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      specialty,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (lawFirm != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        lawFirm!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    RatingDisplay(
                      rating: rating,
                      reviewCount: reviewCount,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Additional info
          Row(
            children: [
              _buildInfoChip(
                icon: Icons.attach_money,
                text: '${Formatters.formatCurrency(consultationFee)}/15min',
                color: AppColors.success,
              ),
              const SizedBox(width: 8),
              if (experience != null)
                _buildInfoChip(
                  icon: Icons.work_outline,
                  text: '${experience}y exp',
                  color: AppColors.info,
                ),
              if (location != null) ...[
                const SizedBox(width: 8),
                _buildInfoChip(
                  icon: Icons.location_on_outlined,
                  text: location!,
                  color: AppColors.textTertiary,
                ),
              ],
            ],
          ),
          
          if (responseTime != null || !isAvailable) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                _buildAvailabilityIndicator(),
                if (responseTime != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    'Usually responds in ${responseTime}min',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ],
            ),
          ],
          
          if (badges != null && badges!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: badges!.take(3).map((badge) => _buildBadge(badge)).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCompactCard(BuildContext context) {
    return AppCard.clickable(
      onTap: onTap ?? () {},
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Profile image
          _buildProfileImage(48),
          const SizedBox(width: 12),
          
          // Lawyer info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (onFavoritePressed != null) _buildFavoriteButton(size: 20),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  specialty,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    RatingDisplay(
                      rating: rating,
                      reviewCount: reviewCount,
                      starSize: 14,
                      showReviewCount: false,
                    ),
                    const Spacer(),
                    Text(
                      Formatters.formatCurrency(consultationFee),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: AppCard.elevated(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile image with overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: _buildProfileImage(120, width: double.infinity, fit: BoxFit.cover),
                ),
                if (onFavoritePressed != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _buildFavoriteButton(filled: true),
                  ),
                if (!isAvailable)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Busy',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            
            // Lawyer info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  RatingDisplay(
                    rating: rating,
                    reviewCount: reviewCount,
                    starSize: 14,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${Formatters.formatCurrency(consultationFee)}/15min',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(double size, {double? width, BoxFit? fit}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageUrl != null
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              height: size,
              width: width ?? size,
              fit: fit ?? BoxFit.cover,
              placeholder: (context, url) => ShimmerLoading(
                width: width ?? size,
                height: size,
              ),
              errorWidget: (context, url, error) => _buildAvatarPlaceholder(size, width: width),
            )
          : _buildAvatarPlaceholder(size, width: width),
    );
  }

  Widget _buildAvatarPlaceholder(double size, {double? width}) {
    return Container(
      height: size,
      width: width ?? size,
      color: AppColors.surfaceVariant,
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: AppColors.textTertiary,
      ),
    );
  }

  Widget _buildFavoriteButton({double size = 24, bool filled = false}) {
    return GestureDetector(
      onTap: onFavoritePressed,
      child: Container(
        width: size + 8,
        height: size + 8,
        decoration: filled
            ? BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          size: size,
          color: isFavorite ? AppColors.error : AppColors.textTertiary,
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isAvailable ? AppColors.success : AppColors.error,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          isAvailable ? 'Available' : 'Busy',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isAvailable ? AppColors.success : AppColors.error,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: AppColors.accent,
        ),
      ),
    );
  }
}

/// Lawyer card variants
enum LawyerCardVariant {
  standard,
  compact,
  featured,
}