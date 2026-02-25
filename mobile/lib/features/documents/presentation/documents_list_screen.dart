import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';

class DocumentsListScreen extends StatefulWidget {
  const DocumentsListScreen({super.key});

  @override
  State<DocumentsListScreen> createState() => _DocumentsListScreenState();
}

class _DocumentsListScreenState extends State<DocumentsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.navBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          'Documents',
          style: AppTypography.pageTitle(),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search
            },
            color: AppColors.textPrimary,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.accent,
          labelColor: AppColors.accent,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: AppTypography.bodyMedium(),
          unselectedLabelStyle: AppTypography.body(),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Contracts'),
            Tab(text: 'Court Docs'),
            Tab(text: 'Receipts'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDocumentsList('all'),
          _buildDocumentsList('contracts'),
          _buildDocumentsList('court'),
          _buildDocumentsList('receipts'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUploadOptions(),
        backgroundColor: AppColors.accent,
        child: const Icon(
          Icons.add,
          color: AppColors.textInverse,
        ),
      ),
    );
  }

  Widget _buildDocumentsList(String category) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.contentPaddingHorizontalLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(
                Icons.folder_outlined,
                size: 60,
                color: AppColors.info,
              ),
            )
            .animate()
            .scale(duration: const Duration(milliseconds: 600)),
            
            const SizedBox(height: AppDimensions.spacing24),
            
            Text(
              'No Documents Yet',
              style: AppTypography.sectionHeader(),
            )
            .animate()
            .fadeIn(delay: const Duration(milliseconds: 300)),
            
            const SizedBox(height: AppDimensions.spacing8),
            
            Text(
              'Upload your legal documents to access them anytime',
              style: AppTypography.body(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(delay: const Duration(milliseconds: 400)),
            
            const SizedBox(height: AppDimensions.spacing32),
            
            FilledButton.icon(
              onPressed: _showUploadOptions,
              icon: const Icon(Icons.upload),
              label: Text(
                'Upload Document',
                style: AppTypography.button(),
              ),
            )
            .animate()
            .fadeIn(delay: const Duration(milliseconds: 500))
            .slideY(begin: 0.2),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            TextButton.icon(
              onPressed: () => context.go('/documents/templates'),
              icon: const Icon(Icons.description),
              label: Text(
                'Browse Templates',
                style: AppTypography.bodyMedium(color: AppColors.accent),
              ),
            )
            .animate()
            .fadeIn(delay: const Duration(milliseconds: 600))
            .slideY(begin: 0.2),
          ],
        ),
      ),
    );
  }

  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(AppDimensions.spacing16),
        padding: const EdgeInsets.all(AppDimensions.contentPaddingHorizontalLarge),
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
              margin: const EdgeInsets.only(bottom: AppDimensions.spacing24),
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            Text(
              'Upload Document',
              style: AppTypography.sectionHeader(),
            ),
            
            const SizedBox(height: AppDimensions.spacing24),
            
            _buildUploadOption(
              icon: Icons.camera_alt,
              title: 'Take Photo',
              subtitle: 'Capture with camera',
              onTap: () {
                Navigator.pop(context);
                // Implement camera capture
              },
            ),
            
            const SizedBox(height: AppDimensions.spacing12),
            
            _buildUploadOption(
              icon: Icons.photo_library,
              title: 'Choose from Gallery',
              subtitle: 'Select from photos',
              onTap: () {
                Navigator.pop(context);
                // Implement gallery picker
              },
            ),
            
            const SizedBox(height: AppDimensions.spacing12),
            
            _buildUploadOption(
              icon: Icons.insert_drive_file,
              title: 'Choose File',
              subtitle: 'PDF, DOC, DOCX',
              onTap: () {
                Navigator.pop(context);
                // Implement file picker
              },
            ),
            
            const SizedBox(height: AppDimensions.spacing24),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Icon(
          icon,
          color: AppColors.accent,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: AppTypography.bodyMedium(),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.caption(color: AppColors.textSecondary),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.textTertiary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
      ),
      tileColor: AppColors.surface,
    );
  }
}