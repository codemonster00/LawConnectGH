import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/widgets/shimmer_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> 
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fabAnimationController;
  
  bool _showFab = false;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.navBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
        _showFab = _scrollOffset > 200;
      });
      
      if (_showFab) {
        _fabAnimationController.forward();
      } else {
        _fabAnimationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    // Refresh data here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      floatingActionButton: ScaleTransition(
        scale: _fabAnimationController,
        child: FloatingActionButton(
          onPressed: () => context.go('/consultation/book'),
          backgroundColor: AppColors.accent,
          child: const Icon(Icons.add, color: AppColors.textInverse),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.accent,
        backgroundColor: AppColors.card,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Custom App Bar with Parallax
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primary,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary,
                        AppColors.primaryLight,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.contentPaddingHorizontalLarge,
                        vertical: AppDimensions.spacing16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_getGreeting()}, Kobby 👋',
                                      style: AppTypography.sectionHeader(
                                        color: AppColors.textInverse,
                                      ),
                                    ),
                                    
                                    const SizedBox(height: AppDimensions.spacing4),
                                    
                                    Text(
                                      'How can we help you today?',
                                      style: AppTypography.body(
                                        color: AppColors.textInverse.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Notification Icon
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.textInverse.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.notifications_outlined,
                                    color: AppColors.textInverse,
                                    size: AppDimensions.iconLarge,
                                  ),
                                  onPressed: () => context.go('/notifications'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Main Content
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: AppDimensions.spacing24),
                  
                  // Quick Actions
                  _buildQuickActions(),
                  
                  const SizedBox(height: AppDimensions.sectionGap),
                  
                  // Active Consultation Card (if any)
                  _buildActiveConsultationCard(),
                  
                  const SizedBox(height: AppDimensions.sectionGap),
                  
                  // Featured Lawyers
                  _buildFeaturedLawyers(),
                  
                  const SizedBox(height: AppDimensions.sectionGap),
                  
                  // Legal Topics Grid
                  _buildLegalTopicsGrid(),
                  
                  const SizedBox(height: AppDimensions.sectionGap),
                  
                  // Recent Activity
                  _buildRecentActivity(),
                  
                  const SizedBox(height: AppDimensions.spacing32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      _QuickAction(
        icon: Icons.search,
        label: 'Find Lawyer',
        color: AppColors.info,
        onTap: () => context.go('/lawyers'),
      ),
      _QuickAction(
        icon: Icons.folder_outlined,
        label: 'My Cases',
        color: AppColors.accent,
        onTap: () => context.go('/consultations'),
      ),
      _QuickAction(
        icon: Icons.description_outlined,
        label: 'Documents',
        color: AppColors.success,
        onTap: () => context.go('/documents'),
      ),
      _QuickAction(
        icon: Icons.payment,
        label: 'Payments',
        color: AppColors.warning,
        onTap: () => context.go('/payments'),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.contentPaddingHorizontalLarge,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: actions.asMap().entries.map((entry) {
          final index = entry.key;
          final action = entry.value;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                action.onTap();
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: index == 0 || index == actions.length - 1 
                    ? 0 
                    : AppDimensions.spacing8,
                ),
                child: Column(
                  children: [
                    Container(
                      width: AppDimensions.quickActionIconSize,
                      height: AppDimensions.quickActionIconSize,
                      decoration: BoxDecoration(
                        color: action.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.quickActionIconRadius,
                        ),
                        border: Border.all(
                          color: action.color.withOpacity(0.2),
                        ),
                      ),
                      child: Icon(
                        action.icon,
                        color: action.color,
                        size: AppDimensions.iconXLarge,
                      ),
                    ),
                    
                    const SizedBox(height: AppDimensions.spacing8),
                    
                    Text(
                      action.label,
                      style: AppTypography.caption(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
            .animate()
            .scale(
              delay: Duration(milliseconds: 100 * index),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            )
            .fadeIn(
              delay: Duration(milliseconds: 100 * index),
              duration: const Duration(milliseconds: 300),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActiveConsultationCard() {
    // This would be conditional based on actual consultation state
    // For now, showing a demo active consultation
    final hasActiveConsultation = true;
    
    if (!hasActiveConsultation) {
      return const SizedBox.shrink();
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.contentPaddingHorizontalLarge,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.cardPaddingLarge),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.accent.withOpacity(0.1),
              AppColors.accent.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
          border: Border.all(
            color: AppColors.accent.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                
                const SizedBox(width: AppDimensions.spacing8),
                
                Text(
                  'ACTIVE CONSULTATION',
                  style: AppTypography.badge(color: AppColors.success),
                ),
                
                const Spacer(),
                
                Text(
                  '12:34 PM',
                  style: AppTypography.caption(color: AppColors.textSecondary),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    'KA',
                    style: AppTypography.bodyMedium(color: AppColors.textInverse),
                  ),
                ),
                
                const SizedBox(width: AppDimensions.spacing12),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kwame Asante',
                        style: AppTypography.cardTitle(),
                      ),
                      
                      const SizedBox(height: AppDimensions.spacing2),
                      
                      Text(
                        'Family Law Specialist',
                        style: AppTypography.caption(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                ElevatedButton(
                  onPressed: () => context.go('/consultation/active'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.textInverse,
                    elevation: 0,
                    minimumSize: const Size(80, 36),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacing16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: AppTypography.buttonSmall(),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
      .animate()
      .slideY(begin: 0.2, duration: const Duration(milliseconds: 600))
      .fadeIn(duration: const Duration(milliseconds: 400)),
    );
  }

  Widget _buildFeaturedLawyers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.contentPaddingHorizontalLarge,
          ),
          child: Row(
            children: [
              Text(
                'Featured Lawyers',
                style: AppTypography.sectionHeader(),
              ),
              
              const Spacer(),
              
              TextButton(
                onPressed: () => context.go('/lawyers'),
                child: Text(
                  'View All',
                  style: AppTypography.bodyMedium(color: AppColors.accent),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: AppDimensions.spacing16),
        
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.contentPaddingHorizontalLarge,
            ),
            itemCount: 5,
            separatorBuilder: (context, index) => 
              const SizedBox(width: AppDimensions.spacing16),
            itemBuilder: (context, index) => _buildLawyerCard(index),
          ),
        ),
      ],
    );
  }

  Widget _buildLawyerCard(int index) {
    final lawyers = [
      {'name': 'Sarah Mensah', 'specialty': 'Corporate Law', 'rating': 4.9},
      {'name': 'John Osei', 'specialty': 'Family Law', 'rating': 4.8},
      {'name': 'Grace Adjei', 'specialty': 'Property Law', 'rating': 4.9},
      {'name': 'Daniel Kwaku', 'specialty': 'Criminal Law', 'rating': 4.7},
      {'name': 'Ama Boateng', 'specialty': 'Immigration', 'rating': 4.8},
    ];
    
    final lawyer = lawyers[index % lawyers.length];
    
    return Container(
      width: 160,
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primary,
            child: Text(
              lawyer['name'].toString().substring(0, 2).toUpperCase(),
              style: AppTypography.bodyMedium(color: AppColors.textInverse),
            ),
          ),
          
          const SizedBox(height: AppDimensions.spacing12),
          
          Text(
            lawyer['name'].toString(),
            style: AppTypography.cardTitle(),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: AppDimensions.spacing4),
          
          Text(
            lawyer['specialty'].toString(),
            style: AppTypography.caption(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: AppDimensions.spacing8),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 16,
                color: AppColors.warning,
              ),
              
              const SizedBox(width: AppDimensions.spacing4),
              
              Text(
                lawyer['rating'].toString(),
                style: AppTypography.captionMedium(),
              ),
            ],
          ),
          
          const SizedBox(height: AppDimensions.spacing12),
          
          SizedBox(
            width: double.infinity,
            height: 32,
            child: ElevatedButton(
              onPressed: () => context.go('/lawyer/${index + 1}'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent.withOpacity(0.1),
                foregroundColor: AppColors.accent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                'Book',
                style: AppTypography.captionMedium(color: AppColors.accent),
              ),
            ),
          ),
        ],
      ),
    )
    .animate()
    .slideX(
      begin: 0.2,
      delay: Duration(milliseconds: 100 * index),
      duration: const Duration(milliseconds: 400),
    )
    .fadeIn(
      delay: Duration(milliseconds: 100 * index),
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildLegalTopicsGrid() {
    final topics = [
      _LegalTopic(
        title: 'Family Law',
        icon: Icons.family_restroom,
        color: AppColors.familyLaw,
        route: '/lawyers?specialty=family',
      ),
      _LegalTopic(
        title: 'Property Law',
        icon: Icons.home,
        color: AppColors.propertyLaw,
        route: '/lawyers?specialty=property',
      ),
      _LegalTopic(
        title: 'Business Law',
        icon: Icons.business,
        color: AppColors.businessLaw,
        route: '/lawyers?specialty=business',
      ),
      _LegalTopic(
        title: 'Criminal Law',
        icon: Icons.security,
        color: AppColors.criminalLaw,
        route: '/lawyers?specialty=criminal',
      ),
      _LegalTopic(
        title: 'Immigration',
        icon: Icons.flight,
        color: AppColors.immigrationLaw,
        route: '/lawyers?specialty=immigration',
      ),
      _LegalTopic(
        title: 'Labor Law',
        icon: Icons.work,
        color: AppColors.laborLaw,
        route: '/lawyers?specialty=labor',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.contentPaddingHorizontalLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Legal Topics',
            style: AppTypography.sectionHeader(),
          ),
          
          const SizedBox(height: AppDimensions.spacing16),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: AppDimensions.spacing16,
              mainAxisSpacing: AppDimensions.spacing16,
            ),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              
              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.go(topic.route);
                },
                child: Container(
                  padding: const EdgeInsets.all(AppDimensions.cardPadding),
                  decoration: BoxDecoration(
                    color: topic.color,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.cardBorderRadius,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        topic.icon,
                        size: AppDimensions.iconXXLarge,
                        color: AppColors.textPrimary.withOpacity(0.8),
                      ),
                      
                      const SizedBox(height: AppDimensions.spacing8),
                      
                      Text(
                        topic.title,
                        style: AppTypography.bodyMedium(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
              .animate()
              .scale(
                delay: Duration(milliseconds: 150 * index),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
              )
              .fadeIn(
                delay: Duration(milliseconds: 150 * index),
                duration: const Duration(milliseconds: 300),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    final activities = [
      'Consultation with Sarah Mensah completed',
      'Document "Property Agreement" uploaded',
      'Payment of GHS 150 processed',
      'New message from John Osei',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.contentPaddingHorizontalLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: AppTypography.sectionHeader(),
          ),
          
          const SizedBox(height: AppDimensions.spacing16),
          
          ...activities.asMap().entries.map((entry) {
            final index = entry.key;
            final activity = entry.value;
            
            return Container(
              margin: EdgeInsets.only(
                bottom: index != activities.length - 1 
                  ? AppDimensions.spacing12 
                  : 0,
              ),
              padding: const EdgeInsets.all(AppDimensions.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(
                  AppDimensions.cardBorderRadius,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  
                  const SizedBox(width: AppDimensions.spacing12),
                  
                  Expanded(
                    child: Text(
                      activity,
                      style: AppTypography.body(),
                    ),
                  ),
                  
                  Text(
                    '2h ago',
                    style: AppTypography.caption(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .slideX(
              begin: 0.2,
              delay: Duration(milliseconds: 100 * index),
              duration: const Duration(milliseconds: 400),
            )
            .fadeIn(
              delay: Duration(milliseconds: 100 * index),
              duration: const Duration(milliseconds: 300),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

class _LegalTopic {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  _LegalTopic({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}