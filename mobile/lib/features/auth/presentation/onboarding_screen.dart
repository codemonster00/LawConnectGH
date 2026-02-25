import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.verified_user,
      title: 'Find Trusted Lawyers',
      subtitle: 'Access verified legal professionals with proven track records and excellent client reviews.',
      color: AppColors.success,
    ),
    OnboardingPage(
      icon: Icons.video_call,
      title: 'Instant Consultations',
      subtitle: 'Chat, call, or video call your lawyer instantly. Get legal advice when you need it most.',
      color: AppColors.info,
    ),
    OnboardingPage(
      icon: Icons.mobile_friendly,
      title: 'Pay Securely',
      subtitle: 'Use Mobile Money payments you trust. MTN MoMo, Vodafone Cash, and AirtelTigo supported.',
      color: AppColors.accent,
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.surface,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/auth/phone');
    }
  }

  void _skipOnboarding() {
    context.go('/auth/phone');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spacing20),
                child: TextButton(
                  onPressed: _skipOnboarding,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacing16,
                      vertical: AppDimensions.spacing8,
                    ),
                  ),
                  child: Text(
                    'Skip',
                    style: AppTypography.bodyMedium(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            
            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPageContent(_pages[index], index);
                },
              ),
            ),
            
            // Page Indicator and Navigation
            Padding(
              padding: const EdgeInsets.all(AppDimensions.contentPaddingHorizontalLarge),
              child: Column(
                children: [
                  // Custom Dot Indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.accent,
                      dotColor: AppColors.divider,
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                      spacing: 8,
                    ),
                  ),
                  
                  const SizedBox(height: AppDimensions.spacing32),
                  
                  // Get Started / Next Button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _nextPage,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.textInverse,
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 
                          ? 'Get Started' 
                          : 'Next',
                        style: AppTypography.button(),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppDimensions.spacing8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent(OnboardingPage page, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.contentPaddingHorizontalLarge,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Container
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  page.color.withOpacity(0.1),
                  page.color.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(140),
            ),
            child: Icon(
              page.icon,
              size: 120,
              color: page.color,
            ),
          )
          .animate(delay: Duration(milliseconds: 200 * index))
          .scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
          )
          .fadeIn(
            duration: const Duration(milliseconds: 400),
          ),
          
          const SizedBox(height: AppDimensions.spacing48),
          
          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: AppTypography.heroTitleMedium(),
          )
          .animate(delay: Duration(milliseconds: 400 + (100 * index)))
          .slideY(
            begin: 0.3,
            end: 0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          )
          .fadeIn(
            duration: const Duration(milliseconds: 400),
          ),
          
          const SizedBox(height: AppDimensions.spacing20),
          
          // Subtitle
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: AppTypography.body(color: AppColors.textSecondary),
          )
          .animate(delay: Duration(milliseconds: 600 + (100 * index)))
          .slideY(
            begin: 0.2,
            end: 0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          )
          .fadeIn(
            duration: const Duration(milliseconds: 400),
          ),
          
          const SizedBox(height: AppDimensions.spacing64),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}