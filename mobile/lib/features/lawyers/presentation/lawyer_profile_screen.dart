import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/shimmer_loading.dart';

/// Detailed lawyer profile screen
class LawyerProfileScreen extends ConsumerStatefulWidget {
  final String lawyerId;
  
  const LawyerProfileScreen({
    super.key,
    required this.lawyerId,
  });

  @override
  ConsumerState<LawyerProfileScreen> createState() => _LawyerProfileScreenState();
}

class _LawyerProfileScreenState extends ConsumerState<LawyerProfileScreen> {
  // Mock data - TODO: Get from provider
  late final LawyerProfileData _lawyer;

  @override
  void initState() {
    super.initState();
    _lawyer = LawyerProfileData(
      id: widget.lawyerId,
      name: 'Kwame Asante',
      specialty: ['Family Law', 'Criminal Law'],
      barNumber: 'GH/1234/2012',
      yearCalledToBar: 2012,
      lawFirm: 'Asante & Associates',
      bio: 'Experienced family law attorney with over 12 years of practice. Specializing in divorce proceedings, child custody, and family mediation. Dedicated to protecting families and resolving conflicts with compassion and expertise.',
      consultationFee15Min: 120,
      consultationFee30Min: 200,
      isAvailable: true,
      rating: 4.8,
      reviewCount: 127,
      totalConsultations: 489,
      responseTime: 15,
      imageUrl: null,
      location: 'Accra, Greater Accra',
      languages: ['English', 'Twi'],
      education: ['University of Ghana School of Law', 'Ghana School of Law'],
      experience: Formatters.formatExperience(2012),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App bar with profile header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textInverse,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildProfileHeader(context),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // TODO: Add to favorites
                },
                icon: const Icon(Icons.favorite_outline),
              ),
              IconButton(
                onPressed: () {
                  // TODO: Share lawyer profile
                },
                icon: const Icon(Icons.share_outlined),
              ),
            ],
          ),
          
          // Profile content
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildStatsSection(context),
                _buildAboutSection(context),
                _buildSpecialtiesSection(context),
                _buildEducationSection(context),
                _buildReviewsSection(context),
                const SizedBox(height: 100), // Bottom padding for FAB
              ],
            ),
          ),
        ],
      ),
      
      // Book consultation FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to consultation booking
          // context.go('/consultations/book/${widget.lawyerId}');
        },
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textPrimary,
        icon: const Icon(Icons.video_call),
        label: const Text(
          'Book Consultation',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 100, 16, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Profile picture
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: _lawyer.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: _lawyer.imageUrl!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const ShimmerLoading(
                      width: 100,
                      height: 100,
                    ),
                    errorWidget: (context, url, error) => _buildLargeAvatar(),
                  )
                : _buildLargeAvatar(),
          ),
          const SizedBox(height: 16),
          
          // Name and verification
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  _lawyer.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textInverse,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.verified,
                size: 20,
                color: AppColors.accent,
              ),
            ],
          ),
          const SizedBox(height: 4),
          
          // Law firm
          if (_lawyer.lawFirm != null)
            Text(
              _lawyer.lawFirm!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textInverse.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 12),
          
          // Availability status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _lawyer.isAvailable 
                  ? AppColors.available.withOpacity(0.2)
                  : AppColors.offline.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _lawyer.isAvailable ? AppColors.available : AppColors.offline,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  _lawyer.isAvailable ? 'Available Now' : 'Currently Offline',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textInverse,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.textInverse.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.person,
        size: 50,
        color: AppColors.textInverse,
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Rating
            Expanded(
              child: _StatItem(
                icon: Icons.star,
                iconColor: AppColors.accent,
                title: _lawyer.rating.toString(),
                subtitle: '${_lawyer.reviewCount} reviews',
              ),
            ),
            VerticalDivider(color: AppColors.border),
            
            // Total consultations
            Expanded(
              child: _StatItem(
                icon: Icons.chat_bubble_outline,
                iconColor: AppColors.primary,
                title: _lawyer.totalConsultations.toString(),
                subtitle: 'consultations',
              ),
            ),
            VerticalDivider(color: AppColors.border),
            
            // Response time
            Expanded(
              child: _StatItem(
                icon: Icons.schedule,
                iconColor: AppColors.success,
                title: '${_lawyer.responseTime}m',
                subtitle: 'avg response',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _lawyer.bio,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              
              // Details
              _DetailRow(
                icon: Icons.card_membership,
                label: 'Bar Number',
                value: _lawyer.barNumber,
              ),
              const SizedBox(height: 8),
              _DetailRow(
                icon: Icons.school,
                label: 'Experience',
                value: _lawyer.experience,
              ),
              const SizedBox(height: 8),
              _DetailRow(
                icon: Icons.location_on_outlined,
                label: 'Location',
                value: _lawyer.location,
              ),
              const SizedBox(height: 8),
              _DetailRow(
                icon: Icons.language,
                label: 'Languages',
                value: _lawyer.languages.join(', '),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialtiesSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Specializations',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _lawyer.specialty.map((spec) {
                  return Chip(
                    label: Text(spec),
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Education & Credentials',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ..._lawyer.education.map((edu) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.school,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          edu,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews & Ratings',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Show all reviews
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Rating summary
              Row(
                children: [
                  // Large rating
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 24,
                            color: AppColors.accent,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _lawyer.rating.toString(),
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${_lawyer.reviewCount} reviews',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  
                  // Rating breakdown
                  Expanded(
                    child: Column(
                      children: [
                        _RatingBar(stars: 5, percentage: 0.75),
                        _RatingBar(stars: 4, percentage: 0.15),
                        _RatingBar(stars: 3, percentage: 0.08),
                        _RatingBar(stars: 2, percentage: 0.02),
                        _RatingBar(stars: 1, percentage: 0.00),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Sample reviews
              _ReviewItem(
                clientName: 'Ama Osei',
                rating: 5,
                comment: 'Excellent service! Very professional and helped me resolve my family dispute quickly.',
                date: DateTime.now().subtract(const Duration(days: 5)),
              ),
              const SizedBox(height: 12),
              _ReviewItem(
                clientName: 'Kofi Appiah',
                rating: 4,
                comment: 'Good lawyer with deep knowledge of family law. Responsive and fair pricing.',
                date: DateTime.now().subtract(const Duration(days: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Stat item widget
class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Detail row widget
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// Rating bar for review breakdown
class _RatingBar extends StatelessWidget {
  final int stars;
  final double percentage;

  const _RatingBar({
    required this.stars,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$stars',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.star,
            size: 12,
            color: AppColors.accent,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${(percentage * 100).toInt()}%',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Review item widget
class _ReviewItem extends StatelessWidget {
  final String clientName;
  final int rating;
  final String comment;
  final DateTime date;

  const _ReviewItem({
    required this.clientName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Client avatar
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(
                  Formatters.getInitials(clientName),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Name and rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clientName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_outline,
                          size: 14,
                          color: AppColors.accent,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              
              // Date
              Text(
                Formatters.formatTimeAgo(date),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Comment
          Text(
            comment,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Mock data model for lawyer profile
class LawyerProfileData {
  final String id;
  final String name;
  final List<String> specialty;
  final String barNumber;
  final int yearCalledToBar;
  final String? lawFirm;
  final String bio;
  final double consultationFee15Min;
  final double consultationFee30Min;
  final bool isAvailable;
  final double rating;
  final int reviewCount;
  final int totalConsultations;
  final int responseTime;
  final String? imageUrl;
  final String location;
  final List<String> languages;
  final List<String> education;
  final String experience;

  LawyerProfileData({
    required this.id,
    required this.name,
    required this.specialty,
    required this.barNumber,
    required this.yearCalledToBar,
    this.lawFirm,
    required this.bio,
    required this.consultationFee15Min,
    required this.consultationFee30Min,
    required this.isAvailable,
    required this.rating,
    required this.reviewCount,
    required this.totalConsultations,
    required this.responseTime,
    this.imageUrl,
    required this.location,
    required this.languages,
    required this.education,
    required this.experience,
  });
}