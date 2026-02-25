import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/shimmer_loading.dart';

/// Lawyers browsing and search screen
class LawyersListScreen extends ConsumerStatefulWidget {
  const LawyersListScreen({super.key});

  @override
  ConsumerState<LawyersListScreen> createState() => _LawyersListScreenState();
}

class _LawyersListScreenState extends ConsumerState<LawyersListScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  String _searchQuery = '';
  String? _selectedSpecialty;
  String? _selectedRegion;
  bool _showFilters = false;

  // Mock data - TODO: Replace with real data from provider
  final List<LawyerItem> _lawyers = [
    LawyerItem(
      id: '1',
      name: 'Kwame Asante',
      specialty: 'Family Law',
      lawFirm: 'Asante & Associates',
      rating: 4.8,
      reviewCount: 127,
      consultationFee: 120,
      isAvailable: true,
      responseTime: 15,
      imageUrl: null,
      experience: 12,
      location: 'Accra',
    ),
    LawyerItem(
      id: '2',
      name: 'Akosua Boateng',
      specialty: 'Corporate Law',
      lawFirm: 'Boateng Legal Chambers',
      rating: 4.9,
      reviewCount: 89,
      consultationFee: 200,
      isAvailable: true,
      responseTime: 5,
      imageUrl: null,
      experience: 15,
      location: 'Kumasi',
    ),
    LawyerItem(
      id: '3',
      name: 'Kofi Mensah',
      specialty: 'Criminal Law',
      lawFirm: 'Mensah Law Firm',
      rating: 4.7,
      reviewCount: 203,
      consultationFee: 150,
      isAvailable: false,
      responseTime: 30,
      imageUrl: null,
      experience: 8,
      location: 'Takoradi',
    ),
  ];

  List<LawyerItem> get _filteredLawyers {
    return _lawyers.where((lawyer) {
      final matchesSearch = _searchQuery.isEmpty ||
          lawyer.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (lawyer.lawFirm?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      
      final matchesSpecialty = _selectedSpecialty == null ||
          lawyer.specialty == _selectedSpecialty;
      
      final matchesRegion = _selectedRegion == null ||
          lawyer.location == _selectedRegion;

      return matchesSearch && matchesSpecialty && matchesRegion;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _clearFilters() {
    setState(() {
      _selectedSpecialty = null;
      _selectedRegion = null;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredLawyers = _filteredLawyers;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.browseeLawyers),
        actions: [
          // Filter toggle button
          IconButton(
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            icon: Icon(
              _showFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
              color: (_selectedSpecialty != null || _selectedRegion != null)
                  ? AppColors.accent
                  : AppColors.textInverse,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          _buildSearchBar(),
          
          // Filters section
          if (_showFilters) _buildFiltersSection(),
          
          // Results count
          _buildResultsHeader(filteredLawyers.length),
          
          // Lawyers list
          Expanded(
            child: filteredLawyers.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filteredLawyers.length,
                    itemBuilder: (context, index) {
                      final lawyer = filteredLawyers[index];
                      return _LawyerCard(
                        lawyer: lawyer,
                        onTap: () {
                          // TODO: Navigate to lawyer profile
                          // context.go('/lawyers/${lawyer.id}');
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.primary,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: AppStrings.searchLawyers,
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  icon: const Icon(Icons.clear, color: AppColors.textSecondary),
                )
              : null,
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildFiltersSection() {
    final specialties = [
      'All Specialties',
      AppStrings.familyLaw,
      AppStrings.corporateLaw,
      AppStrings.criminalLaw,
      AppStrings.landLaw,
      AppStrings.labourLaw,
    ];
    
    final regions = [
      'All Regions',
      AppStrings.greaterAccra,
      AppStrings.ashanti,
      AppStrings.western,
      AppStrings.central,
      AppStrings.eastern,
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_selectedSpecialty != null || _selectedRegion != null)
                TextButton(
                  onPressed: _clearFilters,
                  child: const Text('Clear All'),
                ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Specialty filter
          Text(
            AppStrings.filterBySpecialty,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: specialties.map((specialty) {
              final isSelected = specialty == 'All Specialties' 
                  ? _selectedSpecialty == null 
                  : _selectedSpecialty == specialty;
              
              return FilterChip(
                label: Text(specialty),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedSpecialty = specialty == 'All Specialties' ? null : specialty;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          
          // Region filter
          Text(
            AppStrings.filterByLocation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: regions.map((region) {
              final isSelected = region == 'All Regions' 
                  ? _selectedRegion == null 
                  : _selectedRegion == region;
              
              return FilterChip(
                label: Text(region),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedRegion = region == 'All Regions' ? null : region;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsHeader(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count lawyer${count == 1 ? '' : 's'} found',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          if (count > 1)
            TextButton.icon(
              onPressed: () {
                // TODO: Show sort options
              },
              icon: const Icon(Icons.sort, size: 18),
              label: const Text('Sort'),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.noLawyers,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: _clearFilters,
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Lawyer card widget
class _LawyerCard extends StatelessWidget {
  final LawyerItem lawyer;
  final VoidCallback onTap;

  const _LawyerCard({
    required this.lawyer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Profile picture
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: lawyer.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: lawyer.imageUrl!,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const ShimmerLoading(
                          width: 56,
                          height: 56,
                        ),
                        errorWidget: (context, url, error) => _buildAvatar(),
                      )
                    : _buildAvatar(),
              ),
              const SizedBox(width: 16),
              
              // Lawyer info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and verification badge
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lawyer.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.verified.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified,
                                size: 12,
                                color: AppColors.verified,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                AppStrings.verified,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.verified,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    // Specialty and firm
                    Text(
                      lawyer.specialty,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (lawyer.lawFirm != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        lawyer.lawFirm!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    
                    // Rating and stats
                    Row(
                      children: [
                        // Rating
                        Icon(
                          Icons.star,
                          size: 14,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          lawyer.rating.toString(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' (${lawyer.reviewCount})',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Experience
                        Text(
                          '${lawyer.experience} yrs',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Location
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          lawyer.location,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Right side: fee and status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Consultation fee
                  Text(
                    Formatters.formatCurrency(lawyer.consultationFee),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    AppStrings.per15Min,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Availability status
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: lawyer.isAvailable 
                          ? AppColors.available.withValues(alpha: 0.1)
                          : AppColors.offline.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: lawyer.isAvailable ? AppColors.available : AppColors.offline,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          lawyer.isAvailable ? AppStrings.available : AppStrings.offline,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: lawyer.isAvailable ? AppColors.available : AppColors.offline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  // Response time
                  Text(
                    '~${lawyer.responseTime}m response',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Icon(
        Icons.person,
        size: 28,
        color: AppColors.primary,
      ),
    );
  }

}

/// Mock data model for lawyers
class LawyerItem {
  final String id;
  final String name;
  final String specialty;
  final String? lawFirm;
  final double rating;
  final int reviewCount;
  final double consultationFee;
  final bool isAvailable;
  final int responseTime;
  final String? imageUrl;
  final int experience;
  final String location;

  LawyerItem({
    required this.id,
    required this.name,
    required this.specialty,
    this.lawFirm,
    required this.rating,
    required this.reviewCount,
    required this.consultationFee,
    required this.isAvailable,
    required this.responseTime,
    this.imageUrl,
    required this.experience,
    required this.location,
  });
}