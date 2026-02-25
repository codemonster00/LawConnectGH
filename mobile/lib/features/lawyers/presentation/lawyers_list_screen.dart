import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';

class LawyersListScreen extends StatefulWidget {
  const LawyersListScreen({super.key});

  @override
  State<LawyersListScreen> createState() => _LawyersListScreenState();
}

class _LawyersListScreenState extends State<LawyersListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  String _selectedSpecialty = 'All';
  String _selectedRating = 'All';
  String _selectedAvailability = 'All';
  bool _isLoading = true;
  
  final List<String> _specialties = [
    'All', 'Family Law', 'Corporate Law', 'Criminal Law', 
    'Property Law', 'Immigration', 'Labor Law'
  ];
  
  final List<String> _ratings = ['All', '4.5+', '4.0+', '3.5+'];
  final List<String> _availability = ['All', 'Available Now', 'Today', 'This Week'];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.navBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    
    _simulateLoading();
  }

  void _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Search and Filter Section
          _buildSearchSection(),
          
          // Filter Chips
          _buildFilterChips(),
          
          // Lawyers List
          Expanded(
            child: _isLoading 
              ? _buildShimmerLoading() 
              : _buildLawyersList(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Find Lawyers',
        style: AppTypography.pageTitle(),
      ),
      backgroundColor: AppColors.surface,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.tune),
          onPressed: _showFilters,
          color: AppColors.textPrimary,
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.contentPaddingHorizontalLarge),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppDimensions.inputBorderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search lawyers by name or specialty...',
            hintStyle: AppTypography.body(color: AppColors.textTertiary),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.textSecondary,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.inputPaddingHorizontal,
              vertical: AppDimensions.inputPaddingVertical,
            ),
          ),
          style: AppTypography.body(),
          onChanged: (value) {
            // Implement search logic
          },
        ),
      ),
    )
    .animate()
    .slideY(begin: -0.2, duration: const Duration(milliseconds: 400))
    .fadeIn(duration: const Duration(milliseconds: 300));
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.contentPaddingHorizontalLarge,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('Specialty', _selectedSpecialty),
          const SizedBox(width: AppDimensions.spacing8),
          _buildFilterChip('Rating', _selectedRating),
          const SizedBox(width: AppDimensions.spacing8),
          _buildFilterChip('Availability', _selectedAvailability),
        ],
      ),
    )
    .animate()
    .slideX(begin: -0.1, duration: const Duration(milliseconds: 400))
    .fadeIn(duration: const Duration(milliseconds: 300), delay: const Duration(milliseconds: 100));
  }

  Widget _buildFilterChip(String label, String value) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: $value',
            style: AppTypography.captionMedium(
              color: value != 'All' ? AppColors.accent : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: AppDimensions.spacing4),
          Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: value != 'All' ? AppColors.accent : AppColors.textSecondary,
          ),
        ],
      ),
      selected: value != 'All',
      onSelected: (selected) {
        _showFilters();
      },
      backgroundColor: AppColors.card,
      selectedColor: AppColors.accent.withOpacity(0.1),
      side: BorderSide(
        color: value != 'All' 
          ? AppColors.accent.withOpacity(0.3)
          : AppColors.border,
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.separated(
      padding: const EdgeInsets.all(AppDimensions.contentPaddingHorizontalLarge),
      itemCount: 8,
      separatorBuilder: (context, index) => 
        const SizedBox(height: AppDimensions.spacing16),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: _buildLawyerCardSkeleton(),
      ),
    );
  }

  Widget _buildLawyerCardSkeleton() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: AppColors.divider,
              shape: BoxShape.circle,
            ),
          ),
          
          const SizedBox(width: AppDimensions.spacing16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacing8),
                Container(
                  height: 14,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacing8),
                Container(
                  height: 12,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            height: 36,
            width: 80,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLawyersList() {
    final lawyers = _generateMockLawyers();
    
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppDimensions.contentPaddingHorizontalLarge),
      itemCount: lawyers.length,
      separatorBuilder: (context, index) => 
        const SizedBox(height: AppDimensions.spacing16),
      itemBuilder: (context, index) {
        final lawyer = lawyers[index];
        
        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            context.go('/lawyer/${lawyer.id}');
          },
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.cardPaddingLarge),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Avatar
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.primary,
                          child: Text(
                            lawyer.initials,
                            style: AppTypography.bodyMedium(
                              color: AppColors.textInverse,
                            ),
                          ),
                        ),
                        
                        if (lawyer.isVerified)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.card,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 12,
                                color: AppColors.textInverse,
                              ),
                            ),
                          ),
                      ],
                    ),
                    
                    const SizedBox(width: AppDimensions.spacing16),
                    
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  lawyer.name,
                                  style: AppTypography.cardTitle(),
                                ),
                              ),
                              
                              if (lawyer.isAvailable)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimensions.spacing8,
                                    vertical: AppDimensions.spacing2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.badgeBorderRadius,
                                    ),
                                  ),
                                  child: Text(
                                    'Available',
                                    style: AppTypography.micro(
                                      color: AppColors.success,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          
                          const SizedBox(height: AppDimensions.spacing4),
                          
                          Text(
                            lawyer.specialty,
                            style: AppTypography.body(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          
                          const SizedBox(height: AppDimensions.spacing8),
                          
                          Row(
                            children: [
                              // Rating
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: AppColors.warning,
                                  ),
                                  const SizedBox(width: AppDimensions.spacing4),
                                  Text(
                                    lawyer.rating.toStringAsFixed(1),
                                    style: AppTypography.captionMedium(),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(width: AppDimensions.spacing16),
                              
                              // Experience
                              Text(
                                '${lawyer.yearsExperience}+ years',
                                style: AppTypography.caption(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              
                              const Spacer(),
                              
                              // Price
                              Text(
                                'GHS ${lawyer.consultationFee}',
                                style: AppTypography.price(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppDimensions.spacing16),
                
                // Book Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      context.go('/consultation/book?lawyerId=${lawyer.id}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.textInverse,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.buttonBorderRadius,
                        ),
                      ),
                    ),
                    child: Text(
                      'Book Consultation',
                      style: AppTypography.button(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .slideY(
          begin: 0.1,
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 400),
        )
        .fadeIn(
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }

  Widget _buildFilterBottomSheet() {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.spacing16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.bottomSheetBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: AppDimensions.bottomSheetHandleWidth,
            height: AppDimensions.bottomSheetHandleHeight,
            margin: const EdgeInsets.only(top: AppDimensions.spacing12),
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          const SizedBox(height: AppDimensions.spacing24),
          
          // Title
          Text(
            'Filter Lawyers',
            style: AppTypography.sectionHeader(),
          ),
          
          const SizedBox(height: AppDimensions.spacing24),
          
          // Filter sections would go here
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.contentPaddingHorizontalLarge,
            ),
            child: Column(
              children: [
                Text(
                  'Filter options would be implemented here',
                  style: AppTypography.body(color: AppColors.textSecondary),
                ),
                
                const SizedBox(height: AppDimensions.spacing32),
                
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Reset',
                          style: AppTypography.button(color: AppColors.textPrimary),
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: AppDimensions.spacing16),
                    
                    Expanded(
                      child: FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Apply',
                          style: AppTypography.button(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppDimensions.spacing32),
        ],
      ),
    );
  }

  List<_MockLawyer> _generateMockLawyers() {
    return [
      _MockLawyer(
        id: '1',
        name: 'Sarah Mensah',
        specialty: 'Corporate Law',
        rating: 4.9,
        yearsExperience: 12,
        consultationFee: 200,
        isVerified: true,
        isAvailable: true,
      ),
      _MockLawyer(
        id: '2',
        name: 'John Osei',
        specialty: 'Family Law',
        rating: 4.8,
        yearsExperience: 8,
        consultationFee: 150,
        isVerified: true,
        isAvailable: false,
      ),
      _MockLawyer(
        id: '3',
        name: 'Grace Adjei',
        specialty: 'Property Law',
        rating: 4.9,
        yearsExperience: 15,
        consultationFee: 250,
        isVerified: true,
        isAvailable: true,
      ),
      _MockLawyer(
        id: '4',
        name: 'Daniel Kwaku',
        specialty: 'Criminal Law',
        rating: 4.7,
        yearsExperience: 10,
        consultationFee: 180,
        isVerified: true,
        isAvailable: true,
      ),
      _MockLawyer(
        id: '5',
        name: 'Ama Boateng',
        specialty: 'Immigration Law',
        rating: 4.8,
        yearsExperience: 6,
        consultationFee: 120,
        isVerified: false,
        isAvailable: false,
      ),
    ];
  }
}

class _MockLawyer {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int yearsExperience;
  final int consultationFee;
  final bool isVerified;
  final bool isAvailable;

  _MockLawyer({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.yearsExperience,
    required this.consultationFee,
    required this.isVerified,
    required this.isAvailable,
  });

  String get initials => name.split(' ').map((n) => n[0]).join().toUpperCase();
}