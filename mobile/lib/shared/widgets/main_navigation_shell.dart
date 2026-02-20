import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../app/router.dart';

/// Main navigation shell with bottom navigation bar
class MainNavigationShell extends StatelessWidget {
  final Widget child;
  
  const MainNavigationShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _BottomNavigationBar(),
    );
  }
}

/// Custom bottom navigation bar with 5 tabs
class _BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary,
            offset: Offset(0, -1),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _getCurrentIndex(currentLocation),
        onTap: (index) => _onTabTapped(context, index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: AppStrings.lawyers,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: AppStrings.consultations,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            activeIcon: Icon(Icons.description),
            label: AppStrings.documents,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
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