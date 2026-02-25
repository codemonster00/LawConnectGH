import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';

class LawyerProfileScreen extends StatelessWidget {
  final String lawyerId;
  
  const LawyerProfileScreen({
    super.key,
    required this.lawyerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Lawyer Profile', style: AppTypography.pageTitle()),
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
          color: AppColors.textPrimary,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.contentPaddingHorizontalLarge),
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
                  Icons.person,
                  size: 60,
                  color: AppColors.accent,
                ),
              ),
              
              const SizedBox(height: AppDimensions.spacing24),
              
              Text(
                'Lawyer Profile',
                style: AppTypography.sectionHeader(),
              ),
              
              const SizedBox(height: AppDimensions.spacing8),
              
              Text(
                'Lawyer ID: $lawyerId',
                style: AppTypography.body(color: AppColors.textSecondary),
              ),
              
              const SizedBox(height: AppDimensions.spacing8),
              
              Text(
                'Profile details will be implemented here',
                style: AppTypography.body(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: AppDimensions.spacing32),
              
              FilledButton(
                onPressed: () => context.go('/consultation/book'),
                child: Text('Book Consultation', style: AppTypography.button()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}