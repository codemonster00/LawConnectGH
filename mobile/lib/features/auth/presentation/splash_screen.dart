import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _backgroundController;

  @override
  void initState() {
    super.initState();
    
    // Set status bar to transparent with light icons
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.primary,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Start background gradient animation
    _backgroundController.forward();
    
    await Future.delayed(const Duration(milliseconds: 400));
    
    // Start logo animation
    _logoController.forward();
    
    await Future.delayed(const Duration(milliseconds: 600));
    
    // Start text animation
    _textController.forward();
    
    // Navigate to onboarding after animations complete
    await Future.delayed(const Duration(milliseconds: 2500));
    
    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.0,
                  0.5 + (_backgroundController.value * 0.3),
                  1.0,
                ],
                colors: [
                  AppColors.primary,
                  AppColors.primaryLight,
                  AppColors.primary.withOpacity(0.9),
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Container with Animation
                    AnimatedBuilder(
                      animation: _logoController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 0.5 + (_logoController.value * 0.5),
                          child: Opacity(
                            opacity: _logoController.value,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accent.withOpacity(0.3),
                                    blurRadius: 32,
                                    offset: const Offset(0, 16),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.gavel,
                                size: 64,
                                color: AppColors.textInverse,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: AppDimensions.spacing32),
                    
                    // App Name with Animation
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, 30 * (1 - _textController.value)),
                          child: Opacity(
                            opacity: _textController.value,
                            child: Column(
                              children: [
                                Text(
                                  'LawConnect',
                                  style: AppTypography.heroTitle(
                                    color: AppColors.textInverse,
                                  ),
                                ),
                                
                                const SizedBox(height: AppDimensions.spacing8),
                                
                                Text(
                                  'GH',
                                  style: AppTypography.sectionHeader(
                                    color: AppColors.accent,
                                  ),
                                ),
                                
                                const SizedBox(height: AppDimensions.spacing16),
                                
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimensions.spacing16,
                                    vertical: AppDimensions.spacing8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.accent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.chipBorderRadius,
                                    ),
                                    border: Border.all(
                                      color: AppColors.accent.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    'Legal consultation made easy',
                                    style: AppTypography.caption(
                                      color: AppColors.textInverse,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: AppDimensions.spacing64),
                    
                    // Loading Indicator
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _textController.value * 0.7,
                          child: SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.accent.withOpacity(0.8),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}