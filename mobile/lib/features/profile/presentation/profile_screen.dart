import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/formatters.dart';

/// User profile and settings screen
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock user data - TODO: Get from provider
    final user = UserProfileData(
      name: 'John Mensah',
      email: 'john.mensah@email.com',
      phone: '+233 24 123 4567',
      region: 'Greater Accra',
      city: 'Accra',
      memberSince: DateTime(2023, 6, 15),
      totalConsultations: 12,
      documentsGenerated: 3,
      avatarUrl: null,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Profile header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textInverse,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildProfileHeader(context, user),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // TODO: Show settings menu
                },
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          
          // Profile content
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                
                // Stats cards
                _buildStatsSection(context, user),
                
                // Menu options
                _buildMenuSection(context),
                
                // App info
                _buildAppInfoSection(context),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserProfileData user) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Profile picture
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: user.avatarUrl != null
                ? Image.network(
                    user.avatarUrl!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.textInverse.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.textInverse,
                    ),
                  ),
          ),
          const SizedBox(height: 16),
          
          // Name
          Text(
            user.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textInverse,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          
          // Location
          Text(
            '${user.city}, ${user.region}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textInverse.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
          
          // Member since
          Text(
            'Member since ${Formatters.formatDate(user.memberSince)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textInverse.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, UserProfileData user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              icon: Icons.chat_bubble_outline,
              title: 'Consultations',
              value: user.totalConsultations.toString(),
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              icon: Icons.description_outlined,
              title: 'Documents',
              value: user.documentsGenerated.toString(),
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              icon: Icons.star_outline,
              title: 'Reviews',
              value: '0', // TODO: User review count
              color: AppColors.info,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final menuItems = [
      MenuItem(
        icon: Icons.person_outline,
        title: AppStrings.editProfile,
        subtitle: 'Update your personal information',
        onTap: () => context.go(AppRoutes.editProfile),
      ),
      MenuItem(
        icon: Icons.payment_outlined,
        title: AppStrings.paymentMethods,
        subtitle: 'Manage Mobile Money and other payments',
        onTap: () => context.go(AppRoutes.paymentMethods),
      ),
      MenuItem(
        icon: Icons.notifications_outlined,
        title: AppStrings.notificationSettings,
        subtitle: 'Configure your notification preferences',
        onTap: () {
          // TODO: Navigate to notification settings
        },
      ),
      MenuItem(
        icon: Icons.security_outlined,
        title: AppStrings.privacySettings,
        subtitle: 'Manage your privacy and data settings',
        onTap: () {
          // TODO: Navigate to privacy settings
        },
      ),
      MenuItem(
        icon: Icons.help_outline,
        title: AppStrings.helpSupport,
        subtitle: 'Get help and contact support',
        onTap: () {
          // TODO: Navigate to help & support
        },
      ),
      MenuItem(
        icon: Icons.info_outline,
        title: AppStrings.about,
        subtitle: 'App version and legal information',
        onTap: () {
          _showAboutDialog(context);
        },
      ),
    ];

    return Column(
      children: [
        const SizedBox(height: 24),
        ...menuItems.map((item) => _MenuTile(item: item)),
        const SizedBox(height: 24),
        
        // Logout button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout, color: AppColors.error),
              label: const Text(
                AppStrings.logout,
                style: TextStyle(color: AppColors.error),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // App logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.balance,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              
              Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Version 1.0.0',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: 12),
              
              // Links
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: Show privacy policy
                    },
                    child: const Text(AppStrings.privacyPolicy),
                  ),
                  Container(
                    width: 1,
                    height: 16,
                    color: AppColors.border,
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Show terms of service
                    },
                    child: const Text(AppStrings.termsOfService),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Perform logout
              context.go(AppRoutes.phoneAuth);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text(AppStrings.logout),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppStrings.appName,
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.balance,
          color: AppColors.textInverse,
          size: 24,
        ),
      ),
      children: [
        const SizedBox(height: 16),
        Text(
          AppStrings.appDescription,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Built with ❤️ for Ghana 🇬🇭',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

/// Stat card widget
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Menu tile widget
class _MenuTile extends StatelessWidget {
  final MenuItem item;

  const _MenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            item.icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        title: Text(
          item.title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          item.subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textTertiary,
        ),
        onTap: item.onTap,
      ),
    );
  }
}

/// Menu item data model
class MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

/// Mock user profile data
class UserProfileData {
  final String name;
  final String email;
  final String phone;
  final String region;
  final String city;
  final DateTime memberSince;
  final int totalConsultations;
  final int documentsGenerated;
  final String? avatarUrl;

  UserProfileData({
    required this.name,
    required this.email,
    required this.phone,
    required this.region,
    required this.city,
    required this.memberSince,
    required this.totalConsultations,
    required this.documentsGenerated,
    this.avatarUrl,
  });
}