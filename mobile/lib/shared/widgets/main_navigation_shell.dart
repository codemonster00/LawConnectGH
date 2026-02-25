import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../app/router.dart';

/// Main navigation shell with bottom navigation bar and FAB
class MainNavigationShell extends StatelessWidget {
  final Widget child;
  
  const MainNavigationShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    final showFAB = _shouldShowFAB(currentLocation);
    
    return Scaffold(
      body: child,
      bottomNavigationBar: _BottomNavigationBar(),
      floatingActionButton: showFAB ? _buildFloatingActionButton(context) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  
  bool _shouldShowFAB(String location) {
    // Show FAB on main tabs, hide on detail screens
    return location == AppRoutes.home || 
           location == AppRoutes.lawyers ||
           location == AppRoutes.consultations;
  }
  
  Widget _buildFloatingActionButton(BuildContext context) {
    final theme = Theme.of(context);
    
    return FloatingActionButton.large(
      onPressed: () => context.go(AppRoutes.voiceRecording),
      tooltip: 'Voice Recording',
      elevation: 8,
      child: Icon(
        Icons.mic_rounded,
        size: 32,
        color: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }
}

/// Material Design 3 NavigationBar with 5 tabs
class _BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            offset: const Offset(0, -2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: NavigationBar(
        selectedIndex: _getCurrentIndex(currentLocation),
        onDestinationSelected: (index) => _onTabTapped(context, index),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        animationDuration: const Duration(milliseconds: 300),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: AppStrings.home,
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline_rounded),
            selectedIcon: Icon(Icons.people_rounded),
            label: AppStrings.lawyers,
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            selectedIcon: Icon(Icons.chat_bubble_rounded),
            label: AppStrings.consultations,
          ),
          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            selectedIcon: Icon(Icons.description_rounded),
            label: AppStrings.documents,
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: AppStrings.profile,
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(String location) {
    if (location.startsWith(AppRoutes.home)) return 0;
    if (location.startsWith(AppRoutes.lawyers)) return 1;
    if (location.startsWith(AppRoutes.consultations)) return 2;
    if (location.startsWith(AppRoutes.documents)) return 3;
    if (location.startsWith(AppRoutes.profile)) return 4;
    return 0; // Default to home
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.lawyers);
        break;
      case 2:
        context.go(AppRoutes.consultations);
        break;
      case 3:
        context.go(AppRoutes.documents);
        break;
      case 4:
        context.go(AppRoutes.profile);
        break;
    }
  }
}

/// Custom floating action button for quick actions
class MainFAB extends StatelessWidget {
  const MainFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        // Quick action: Find a lawyer instantly
        context.go(AppRoutes.lawyers);
      },
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.textPrimary,
      elevation: 8,
      icon: const Icon(Icons.flash_on),
      label: const Text(
        'Quick Help',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}