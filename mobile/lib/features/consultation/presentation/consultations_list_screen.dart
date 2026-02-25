import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';

class ConsultationsListScreen extends StatefulWidget {
  const ConsultationsListScreen({super.key});

  @override
  State<ConsultationsListScreen> createState() => _ConsultationsListScreenState();
}

class _ConsultationsListScreenState extends State<ConsultationsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
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
          'Consultations',
          style: AppTypography.pageTitle(),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.accent,
          labelColor: AppColors.accent,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: AppTypography.bodyMedium(),
          unselectedLabelStyle: AppTypography.body(),
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Scheduled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActiveConsultations(),
          _buildCompletedConsultations(),
          _buildScheduledConsultations(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/consultation/book'),
        backgroundColor: AppColors.accent,
        child: const Icon(
          Icons.add,
          color: AppColors.textInverse,
        ),
      ),
    );
  }

  Widget _buildActiveConsultations() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.chat_outlined,
              size: 60,
              color: AppColors.accent,
            ),
          )
          .animate()
          .scale(duration: const Duration(milliseconds: 600)),
          
          const SizedBox(height: AppDimensions.spacing24),
          
          Text(
            'No Active Consultations',
            style: AppTypography.sectionHeader(),
          )
          .animate()
          .fadeIn(delay: const Duration(milliseconds: 300)),
          
          const SizedBox(height: AppDimensions.spacing8),
          
          Text(
            'Start a consultation with a lawyer to see it here',
            style: AppTypography.body(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          )
          .animate()
          .fadeIn(delay: const Duration(milliseconds: 400)),
          
          const SizedBox(height: AppDimensions.spacing32),
          
          FilledButton(
            onPressed: () => context.go('/consultation/book'),
            child: Text(
              'Book Consultation',
              style: AppTypography.button(),
            ),
          )
          .animate()
          .fadeIn(delay: const Duration(milliseconds: 500))
          .slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildCompletedConsultations() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              size: 60,
              color: AppColors.success,
            ),
          )
          .animate()
          .scale(duration: const Duration(milliseconds: 600)),
          
          const SizedBox(height: AppDimensions.spacing24),
          
          Text(
            'No Completed Consultations',
            style: AppTypography.sectionHeader(),
          )
          .animate()
          .fadeIn(delay: const Duration(milliseconds: 300)),
          
          const SizedBox(height: AppDimensions.spacing8),
          
          Text(
            'Your consultation history will appear here',
            style: AppTypography.body(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          )
          .animate()
          .fadeIn(delay: const Duration(milliseconds: 400)),
        ],
      ),
    );
  }

  Widget _buildScheduledConsultations() {
    return Center(
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
              Icons.schedule,
              size: 60,
              color: AppColors.info,
            ),
          )
          .animate()
          .scale(duration: const Duration(milliseconds: 600)),
          
          const SizedBox(height: AppDimensions.spacing24),
          
          Text(
            'No Scheduled Consultations',
            style: AppTypography.sectionHeader(),
          )
          .animate()
          .fadeIn(delay: const Duration(milliseconds: 300)),
          
          const SizedBox(height: AppDimensions.spacing8),
          
          Text(
            'Schedule a consultation to see it here',
            style: AppTypography.body(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          )
          .animate()
          .fadeIn(delay: const Duration(milliseconds: 400)),
        ],
      ),
    );
  }
}