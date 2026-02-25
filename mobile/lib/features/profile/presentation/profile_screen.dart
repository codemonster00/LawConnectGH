import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          // Profile Header
          SliverAppBar(
            expandedHeight: 200,
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
                    padding: const EdgeInsets.all(AppDimensions.contentPaddingHorizontalLarge),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Avatar
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.accent,
                              child: Text(
                                'KB',
                                style: AppTypography.pageTitle(
                                  color: AppColors.textInverse,
                                ),
                              ),
                            ),
                            
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.textInverse,
                                    width: 2,
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: AppColors.textInverse,
                                  ),
                                  onPressed: () => context.go('/profile/edit'),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        )
                        .animate()
                        .scale(duration: const Duration(milliseconds: 600)),
                        
                        const SizedBox(height: AppDimensions.spacing16),
                        
                        // Name
                        Text(
                          'Kobby Asante',
                          style: AppTypography.sectionHeader(
                            color: AppColors.textInverse,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 200)),
                        
                        const SizedBox(height: AppDimensions.spacing4),
                        
                        // Phone
                        Text(
                          '+233 24 123 4567',
                          style: AppTypography.body(
                            color: AppColors.textInverse.withOpacity(0.8),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 300)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.contentPaddingHorizontalLarge),
              child: Column(
                children: [
                  const SizedBox(height: AppDimensions.spacing24),
                  
                  // Personal Information Section
                  _buildSection(
                    title: 'Personal Information',
                    children: [
                      _buildMenuItem(
                        icon: Icons.person_outline,
                        title: 'Edit Profile',
                        subtitle: 'Update your personal details',
                        onTap: () => context.go('/profile/edit'),
                      ),
                      _buildMenuItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        subtitle: 'Manage notification preferences',
                        onTap: () => context.go('/notifications'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppDimensions.sectionGap),
                  
                  // App Settings Section
                  _buildSection(
                    title: 'App Settings',
                    children: [
                      _buildSwitchMenuItem(
                        icon: Icons.dark_mode_outlined,
                        title: 'Dark Mode',
                        subtitle: 'Switch between light and dark theme',
                        value: _isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            _isDarkMode = value;
                          });
                          // TODO: Implement theme switching
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.language,
                        title: 'Language',
                        subtitle: 'English',
                        onTap: () {
                          // Show language picker
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.security,
                        title: 'Privacy & Security',
                        subtitle: 'Manage your privacy settings',
                        onTap: () {
                          // Navigate to privacy settings
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppDimensions.sectionGap),
                  
                  // Payment & Billing Section
                  _buildSection(
                    title: 'Payment & Billing',
                    children: [
                      _buildMenuItem(
                        icon: Icons.payment,
                        title: 'Payment Methods',
                        subtitle: 'Manage Mobile Money accounts',
                        onTap: () => context.go('/payments'),
                      ),
                      _buildMenuItem(
                        icon: Icons.receipt_long,
                        title: 'Transaction History',
                        subtitle: 'View all your payments',
                        onTap: () {
                          // Navigate to transaction history
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppDimensions.sectionGap),
                  
                  // Support Section
                  _buildSection(
                    title: 'Support',
                    children: [
                      _buildMenuItem(
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        subtitle: 'Get help or contact support',
                        onTap: () {
                          // Navigate to help
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.star_outline,
                        title: 'Rate App',
                        subtitle: 'Rate us on the App Store',
                        onTap: () {
                          // Launch app store rating
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.share_outlined,
                        title: 'Share App',
                        subtitle: 'Tell your friends about LawConnect',
                        onTap: () {
                          // Share app
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppDimensions.sectionGap),
                  
                  // Logout Section
                  _buildSection(
                    title: 'Account',
                    children: [
                      _buildMenuItem(
                        icon: Icons.logout,
                        title: 'Logout',
                        subtitle: 'Sign out of your account',
                        onTap: () => _showLogoutConfirmation(),
                        iconColor: AppColors.error,
                        titleColor: AppColors.error,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppDimensions.spacing32),
                  
                  // App Version
                  Text(
                    'LawConnect GH v1.0.0',
                    style: AppTypography.caption(color: AppColors.textTertiary),
                  )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 1000)),
                  
                  const SizedBox(height: AppDimensions.spacing16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.spacing4,
            bottom: AppDimensions.spacing12,
          ),
          child: Text(
            title,
            style: AppTypography.bodyMedium(color: AppColors.textSecondary),
          ),
        ),
        
        Container(
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
            children: children,
          ),
        ),
      ],
    )
    .animate()
    .slideY(begin: 0.1, duration: const Duration(milliseconds: 400))
    .fadeIn(duration: const Duration(milliseconds: 300));
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    return ListTile(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.accent).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: iconColor ?? AppColors.accent,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: AppTypography.bodyMedium(
          color: titleColor ?? AppColors.textPrimary,
        ),
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
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.cardPaddingLarge,
        vertical: AppDimensions.spacing4,
      ),
    );
  }

  Widget _buildSwitchMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: AppColors.accent,
          size: 20,
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
      trailing: Switch(
        value: value,
        onChanged: (newValue) {
          HapticFeedback.lightImpact();
          onChanged(newValue);
        },
        activeColor: AppColors.accent,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.cardPaddingLarge,
        vertical: AppDimensions.spacing4,
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.dialogBorderRadius),
        ),
        title: Text(
          'Logout',
          style: AppTypography.sectionHeader(),
        ),
        content: Text(
          'Are you sure you want to logout from your account?',
          style: AppTypography.body(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTypography.bodyMedium(color: AppColors.textSecondary),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement logout logic
              context.go('/');
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text(
              'Logout',
              style: AppTypography.button(),
            ),
          ),
        ],
      ),
    );
  }
}