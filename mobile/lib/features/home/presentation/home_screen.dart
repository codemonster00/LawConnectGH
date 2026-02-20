import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../app/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/shimmer_loading.dart';

/// Home screen with dashboard, quick actions, and featured content
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // TODO: Refresh home data
    await Future.delayed(const Duration(seconds: 2));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        header: Container(), // Placeholder header (not used by current implementation)
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textInverse,
              elevation: 0,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getGreeting(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textInverse.withOpacity(0.8),
                    ),
                  ),
                  // TODO: Get from user provider
                  const Text(
                    'John Mensah', // Placeholder user name
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              actions: [
                // Notification bell
                IconButton(
                  onPressed: () {
                    // TODO: Navigate to notifications
                  },
                  icon: Stack(
                    children: [
                      const Icon(Icons.notifications_outlined),
                      // Notification badge
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Main content
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero section
                  _buildHeroSection(context),
                  
                  // Quick actions
                  _buildQuickActions(context),
                  
                  // Recent activity
                  _buildRecentActivity(context),
                  
                  // Featured lawyers
                  _buildFeaturedLawyers(context),
                  
                  // Legal topics
                  _buildLegalTopics(context),
                  
                  const SizedBox(height: 100), // Bottom padding for FAB
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(AppRoutes.lawyers),
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textPrimary,
        icon: const Icon(Icons.search),
        label: const Text(
          'Find Lawyer',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.howCanWeHelp,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textInverse,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Instant Chat',
                  onPressed: () => context.go(AppRoutes.lawyers),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.calendar_today_outlined,
                  label: 'Schedule',
                  onPressed: () => context.go(AppRoutes.lawyers),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      QuickAction(
        icon: Icons.people_outline,
        label: AppStrings.findLawyer,
        color: AppColors.primary,
        onPressed: () => context.go(AppRoutes.lawyers),
      ),
      QuickAction(
        icon: Icons.description_outlined,
        label: AppStrings.generateDocument,
        color: AppColors.accent,
        onPressed: () => context.go(AppRoutes.documents),
      ),
      QuickAction(
        icon: Icons.help_outline,
        label: AppStrings.legalGuide,
        color: AppColors.info,
        onPressed: () {
          // TODO: Navigate to knowledge base
        },
      ),
      QuickAction(
        icon: Icons.support_agent_outlined,
        label: 'Emergency',
        color: AppColors.error,
        onPressed: () {
          // TODO: Emergency legal help
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Text(
            AppStrings.quickActions,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return Container(
                width: 100,
                margin: EdgeInsets.only(right: index < actions.length - 1 ? 16 : 0),
                child: _QuickActionCard(action: action),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    // TODO: Get real data from provider
    final hasRecentActivity = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.recentActivity,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => context.go(AppRoutes.consultations),
                child: const Text(AppStrings.seeAll),
              ),
            ],
          ),
        ),
        if (!hasRecentActivity)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.history,
                  size: 48,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(height: 16),
                Text(
                  'No recent consultations',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start your first consultation with a verified lawyer',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        else
          // TODO: Show actual recent consultations
          const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildFeaturedLawyers(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.featuredLawyers,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => context.go(AppRoutes.lawyers),
                child: const Text(AppStrings.seeAll),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 3, // TODO: Get from provider
            itemBuilder: (context, index) {
              // TODO: Use real lawyer data
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: index < 2 ? 16 : 0),
                child: _FeaturedLawyerCard(
                  name: 'Lawyer ${index + 1}',
                  specialty: 'Family Law',
                  rating: 4.8,
                  fee: 80 + (index * 20),
                  imageUrl: null,
                  onTap: () {
                    // TODO: Navigate to lawyer profile
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLegalTopics(BuildContext context) {
    final topics = [
      'Family Law',
      'Corporate Law',
      'Criminal Law',
      'Land & Property',
      'Labour Law',
      'Tax Law',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Text(
            'Popular Legal Topics',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: topics.map((topic) {
              return ActionChip(
                label: Text(topic),
                onPressed: () {
                  // TODO: Filter lawyers by topic
                  context.go(AppRoutes.lawyers);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }
}

/// Quick action button for hero section
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textInverse,
        side: BorderSide(color: AppColors.textInverse.withOpacity(0.3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}

/// Quick action card for the grid
class _QuickActionCard extends StatelessWidget {
  final QuickAction action;

  const _QuickActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action.onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: action.color.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: action.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                action.icon,
                color: action.color,
                size: 20,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              action.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Featured lawyer card
class _FeaturedLawyerCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final double fee;
  final String? imageUrl;
  final VoidCallback onTap;

  const _FeaturedLawyerCard({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.fee,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile picture
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ShimmerLoading(
                        width: double.infinity,
                        height: 80,
                      ),
                      errorWidget: (context, url, error) => _buildAvatarPlaceholder(),
                    )
                  : _buildAvatarPlaceholder(),
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
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${Formatters.formatCurrency(fee)}/15min',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
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

  Widget _buildAvatarPlaceholder() {
    return Container(
      height: 80,
      width: double.infinity,
      color: AppColors.surfaceVariant,
      child: Icon(
        Icons.person,
        size: 40,
        color: AppColors.textTertiary,
      ),
    );
  }
}

/// Quick action data model
class QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });
}

/// Refresh controller (placeholder - replace with proper implementation)
class RefreshController {
  void refreshCompleted() {}
  void dispose() {}
}

/// Smart refresher widget (placeholder - replace with proper implementation)
class SmartRefresher extends StatelessWidget {
  final RefreshController controller;
  final Future<void> Function() onRefresh;
  final Widget header;
  final Widget child;

  const SmartRefresher({
    super.key,
    required this.controller,
    required this.onRefresh,
    required this.header,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primary,
      child: child,
    );
  }
}