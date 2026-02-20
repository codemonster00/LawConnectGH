import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/rating_stars.dart';
import '../../../shared/widgets/shimmer_loading.dart';
import '../../../shared/widgets/empty_state.dart';

/// Reviews screen for a specific lawyer
class LawyerReviewsScreen extends ConsumerStatefulWidget {
  final String lawyerId;
  final String lawyerName;
  final double currentRating;
  final int totalReviews;

  const LawyerReviewsScreen({
    super.key,
    required this.lawyerId,
    required this.lawyerName,
    required this.currentRating,
    required this.totalReviews,
  });

  @override
  ConsumerState<LawyerReviewsScreen> createState() => _LawyerReviewsScreenState();
}

class _LawyerReviewsScreenState extends ConsumerState<LawyerReviewsScreen> {
  final _scrollController = ScrollController();
  bool _isLoading = false;
  String _sortBy = 'recent'; // recent, rating_high, rating_low

  // Mock data - TODO: Replace with real data from provider
  final List<ReviewItem> _reviews = [
    ReviewItem(
      id: '1',
      clientName: 'Sarah A.',
      rating: 5,
      comment: 'Excellent legal advice! Very professional and knowledgeable. Helped me with my property dispute quickly.',
      date: DateTime.now().subtract(const Duration(days: 2)),
      isVerified: true,
    ),
    ReviewItem(
      id: '2',
      clientName: 'Michael K.',
      rating: 4,
      comment: 'Good experience overall. Responsive and clear communication. Would recommend for family law matters.',
      date: DateTime.now().subtract(const Duration(days: 5)),
      isVerified: true,
    ),
    ReviewItem(
      id: '3',
      clientName: 'Grace O.',
      rating: 5,
      comment: 'Outstanding service! Guided me through the entire process with patience and expertise.',
      date: DateTime.now().subtract(const Duration(days: 8)),
      isVerified: false,
    ),
    ReviewItem(
      id: '4',
      clientName: 'John D.',
      rating: 3,
      comment: 'Decent service but response time could be better. Knowledge is good though.',
      date: DateTime.now().subtract(const Duration(days: 12)),
      isVerified: true,
    ),
    ReviewItem(
      id: '5',
      clientName: 'Emma T.',
      rating: 5,
      comment: 'Fantastic lawyer! Very thorough and explains things clearly. Highly recommended!',
      date: DateTime.now().subtract(const Duration(days: 15)),
      isVerified: true,
    ),
  ];

  Map<int, int> get _ratingDistribution {
    final distribution = <int, int>{5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (final review in _reviews) {
      distribution[review.rating] = (distribution[review.rating] ?? 0) + 1;
    }
    return distribution;
  }

  List<ReviewItem> get _sortedReviews {
    final sorted = List<ReviewItem>.from(_reviews);
    switch (_sortBy) {
      case 'rating_high':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'rating_low':
        sorted.sort((a, b) => a.rating.compareTo(b.rating));
        break;
      case 'recent':
      default:
        sorted.sort((a, b) => b.date.compareTo(a.date));
        break;
    }
    return sorted;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    // TODO: Refresh reviews data
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  void _showAddReviewDialog() {
    showDialog(
      context: context,
      builder: (context) => _AddReviewDialog(
        lawyerName: widget.lawyerName,
        onSubmit: (rating, comment) {
          // TODO: Submit review
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          '${widget.lawyerName} - Reviews',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.primary,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Rating summary
            SliverToBoxAdapter(
              child: _buildRatingSummary(),
            ),
            
            // Filters and sorting
            SliverToBoxAdapter(
              child: _buildFilters(),
            ),
            
            // Reviews list
            if (_isLoading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: ShimmerLoading(
                      width: double.infinity,
                      height: 120,
                    ),
                  ),
                  childCount: 5,
                ),
              )
            else if (_sortedReviews.isEmpty)
              const SliverFillRemaining(
                child: EmptyState.noData(
                  subtitle: 'No reviews yet. Be the first to leave a review!',
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final review = _sortedReviews[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: _ReviewCard(review: review),
                    );
                  },
                  childCount: _sortedReviews.length,
                ),
              ),
            
            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddReviewDialog,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.rate_review),
        label: const Text('Write Review'),
      ),
    );
  }

  Widget _buildRatingSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: AppCard(
        child: Column(
          children: [
            Row(
              children: [
                // Overall rating
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.currentRating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RatingStars.display(
                        rating: widget.currentRating,
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.totalReviews} reviews',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Rating distribution
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      for (int rating = 5; rating >= 1; rating--)
                        _buildRatingBar(rating, _ratingDistribution[rating]!),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar(int rating, int count) {
    final percentage = _reviews.isEmpty ? 0.0 : count / _reviews.length;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            '$rating',
            style: Theme.of(context).textTheme.bodySmall,
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
              backgroundColor: AppColors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          Text(
            'Sort by:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Recent', 'recent'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Highest Rating', 'rating_high'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Lowest Rating', 'rating_low'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _sortBy == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() => _sortBy = value);
        }
      },
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
    );
  }
}

/// Review card widget
class _ReviewCard extends StatelessWidget {
  final ReviewItem review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(
                  review.clientName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Name and verification
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.clientName,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (review.isVerified) ...[
                          const SizedBox(width: 4),
                          Icon(
                            Icons.verified,
                            size: 16,
                            color: AppColors.success,
                          ),
                        ],
                      ],
                    ),
                    Text(
                      Formatters.formatRelativeTime(review.date),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Rating
              RatingStars.display(
                rating: review.rating.toDouble(),
                size: 16,
                showRatingText: false,
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Comment
          Text(
            review.comment,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// Add review dialog
class _AddReviewDialog extends StatefulWidget {
  final String lawyerName;
  final Function(int rating, String comment) onSubmit;

  const _AddReviewDialog({
    required this.lawyerName,
    required this.onSubmit,
  });

  @override
  State<_AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<_AddReviewDialog> {
  final _commentController = TextEditingController();
  double _rating = 5.0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a comment')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    
    try {
      // TODO: Submit to API
      await Future.delayed(const Duration(seconds: 1));
      widget.onSubmit(_rating.toInt(), _commentController.text.trim());
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Review ${widget.lawyerName}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rating',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            RatingStars.input(
              rating: _rating,
              onRatingChanged: (rating) => setState(() => _rating = rating),
            ),
            const SizedBox(height: 24),
            Text(
              'Comment',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: 'Share your experience...',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              maxLength: 500,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        AppButton.primary(
          text: 'Submit Review',
          onPressed: _submit,
          isLoading: _isSubmitting,
        ),
      ],
    );
  }
}

/// Review item data model
class ReviewItem {
  final String id;
  final String clientName;
  final int rating;
  final String comment;
  final DateTime date;
  final bool isVerified;

  const ReviewItem({
    required this.id,
    required this.clientName,
    required this.rating,
    required this.comment,
    required this.date,
    required this.isVerified,
  });
}