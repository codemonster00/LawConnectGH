import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/shimmer_loading.dart';

/// Legal Knowledge Base screen with FAQs and articles
class KnowledgeBaseScreen extends ConsumerStatefulWidget {
  const KnowledgeBaseScreen({super.key});

  @override
  ConsumerState<KnowledgeBaseScreen> createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends ConsumerState<KnowledgeBaseScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  
  String _searchQuery = '';
  String? _selectedCategory;
  bool _isLoading = false;

  // Mock data - TODO: Replace with real data from provider
  final List<KnowledgeCategory> _categories = [
    KnowledgeCategory(
      id: 'family',
      name: 'Family Law',
      icon: Icons.family_restroom,
      color: AppColors.primary,
      articleCount: 15,
    ),
    KnowledgeCategory(
      id: 'property',
      name: 'Property & Land',
      icon: Icons.home,
      color: AppColors.accent,
      articleCount: 23,
    ),
    KnowledgeCategory(
      id: 'business',
      name: 'Business Law',
      icon: Icons.business,
      color: AppColors.info,
      articleCount: 18,
    ),
    KnowledgeCategory(
      id: 'criminal',
      name: 'Criminal Law',
      icon: Icons.security,
      color: AppColors.error,
      articleCount: 12,
    ),
    KnowledgeCategory(
      id: 'employment',
      name: 'Employment',
      icon: Icons.work,
      color: AppColors.success,
      articleCount: 20,
    ),
    KnowledgeCategory(
      id: 'immigration',
      name: 'Immigration',
      icon: Icons.travel_explore,
      color: AppColors.warning,
      articleCount: 10,
    ),
  ];

  final List<KnowledgeArticle> _articles = [
    KnowledgeArticle(
      id: '1',
      title: 'How to File for Divorce in Ghana',
      summary: 'Complete guide on the legal requirements and process for filing divorce in Ghana.',
      category: 'Family Law',
      readTime: 5,
      isPopular: true,
      tags: ['Divorce', 'Marriage', 'Court'],
    ),
    KnowledgeArticle(
      id: '2',
      title: 'Understanding Property Rights',
      summary: 'Learn about your rights when buying, selling, or inheriting property in Ghana.',
      category: 'Property & Land',
      readTime: 8,
      isPopular: true,
      tags: ['Property', 'Land', 'Inheritance'],
    ),
    KnowledgeArticle(
      id: '3',
      title: 'Starting a Business: Legal Requirements',
      summary: 'Essential legal steps to register and operate a business in Ghana.',
      category: 'Business Law',
      readTime: 6,
      isPopular: false,
      tags: ['Business', 'Registration', 'Licenses'],
    ),
    KnowledgeArticle(
      id: '4',
      title: 'Your Rights During Police Arrest',
      summary: 'Know your constitutional rights when dealing with law enforcement.',
      category: 'Criminal Law',
      readTime: 4,
      isPopular: true,
      tags: ['Rights', 'Police', 'Constitution'],
    ),
    KnowledgeArticle(
      id: '5',
      title: 'Workplace Discrimination: What to Do',
      summary: 'Steps to take when facing discrimination at work and your legal options.',
      category: 'Employment',
      readTime: 7,
      isPopular: false,
      tags: ['Discrimination', 'Employment', 'Rights'],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<KnowledgeArticle> get _filteredArticles {
    var filtered = _articles.where((article) {
      final matchesSearch = _searchQuery.isEmpty ||
          article.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          article.summary.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          article.tags.any((tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase()));
      
      final matchesCategory = _selectedCategory == null ||
          article.category.toLowerCase() == _selectedCategory!.toLowerCase();
      
      return matchesSearch && matchesCategory;
    }).toList();

    // Sort popular articles first
    filtered.sort((a, b) {
      if (a.isPopular && !b.isPopular) return -1;
      if (!a.isPopular && b.isPopular) return 1;
      return 0;
    });

    return filtered;
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    // TODO: Refresh knowledge base data
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onCategorySelected(String? categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
  }

  void _onArticleTap(KnowledgeArticle article) {
    // TODO: Navigate to article details
    context.push('/knowledge-base/article/${article.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: const Text(
          'Legal Knowledge Base',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Navigate to bookmarked articles
            },
            icon: const Icon(Icons.bookmark_outline),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.primary,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AppTextField.search(
                  controller: _searchController,
                  hint: 'Search legal topics...',
                  onChanged: _onSearchChanged,
                  onSubmitted: _onSearchChanged,
                ),
              ),
            ),

            // Categories
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      'Categories',
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
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = _selectedCategory == category.name;
                        return Container(
                          width: 100,
                          margin: EdgeInsets.only(
                            right: index < _categories.length - 1 ? 12 : 0,
                          ),
                          child: _CategoryCard(
                            category: category,
                            isSelected: isSelected,
                            onTap: () => _onCategorySelected(
                              isSelected ? null : category.name,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Articles section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Row(
                  children: [
                    Text(
                      _selectedCategory != null
                          ? '$_selectedCategory Articles'
                          : 'All Articles',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    if (_selectedCategory != null)
                      TextButton(
                        onPressed: () => _onCategorySelected(null),
                        child: const Text('Clear Filter'),
                      ),
                  ],
                ),
              ),
            ),

            // Articles list
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
            else if (_filteredArticles.isEmpty)
              const SliverFillRemaining(
                child: EmptyState.search(
                  subtitle: 'No articles found. Try adjusting your search or category filter.',
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final article = _filteredArticles[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: _ArticleCard(
                        article: article,
                        onTap: () => _onArticleTap(article),
                      ),
                    );
                  },
                  childCount: _filteredArticles.length,
                ),
              ),

            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}

/// Category card widget
class _CategoryCard extends StatelessWidget {
  final KnowledgeCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard.clickable(
      onTap: onTap,
      backgroundColor: isSelected 
          ? category.color.withValues(alpha: 0.1) 
          : AppColors.surface,
      borderColor: isSelected 
          ? category.color 
          : AppColors.border,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: category.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              category.icon,
              color: category.color,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? category.color : AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${category.articleCount} articles',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Article card widget
class _ArticleCard extends StatelessWidget {
  final KnowledgeArticle article;
  final VoidCallback onTap;

  const _ArticleCard({
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard.clickable(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (article.isPopular) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Popular',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Expanded(
                          child: Text(
                            article.category,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article.summary,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textTertiary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: 4),
              Text(
                '${article.readTime} min read',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const Spacer(),
              Wrap(
                spacing: 6,
                children: article.tags.take(2).map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Knowledge category data model
class KnowledgeCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final int articleCount;

  const KnowledgeCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.articleCount,
  });
}

/// Knowledge article data model
class KnowledgeArticle {
  final String id;
  final String title;
  final String summary;
  final String category;
  final int readTime;
  final bool isPopular;
  final List<String> tags;

  const KnowledgeArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.readTime,
    required this.isPopular,
    required this.tags,
  });
}