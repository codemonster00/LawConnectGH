import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Import all screen files (will be created)
import '../features/auth/presentation/splash_screen.dart';
import '../features/auth/presentation/onboarding_screen.dart';
import '../features/auth/presentation/phone_auth_screen.dart';
import '../features/auth/presentation/otp_verification_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/lawyers/presentation/lawyers_list_screen.dart';
import '../features/lawyers/presentation/lawyer_profile_screen.dart';
import '../features/consultation/presentation/consultation_booking_screen.dart';
import '../features/consultation/presentation/consultation_chat_screen.dart';
import '../features/consultation/presentation/consultations_list_screen.dart';
import '../features/documents/presentation/documents_list_screen.dart';
import '../features/documents/presentation/document_templates_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/profile/presentation/edit_profile_screen.dart';
import '../features/payments/presentation/payment_methods_screen.dart';
import '../features/voice_recording/presentation/voice_recording_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../shared/widgets/main_navigation_shell.dart';

/// Route paths
class AppRoutes {
  AppRoutes._();
  
  // Auth routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String phoneAuth = '/auth/phone';
  static const String otpVerification = '/auth/otp';
  
  // Main app routes (with bottom navigation)
  static const String home = '/home';
  static const String lawyers = '/lawyers';
  static const String consultations = '/consultations';
  static const String documents = '/documents';
  static const String profile = '/profile';
  
  // Detailed routes
  static const String lawyerProfile = '/lawyers/:id';
  static const String consultationBooking = '/consultations/book/:lawyerId';
  static const String consultationChat = '/consultations/:id/chat';
  static const String documentTemplates = '/documents/templates';
  static const String editProfile = '/profile/edit';
  static const String paymentMethods = '/profile/payment-methods';
  static const String momoPayment = '/payment/momo';
  static const String notifications = '/notifications';
  static const String knowledgeBase = '/knowledge-base';
  static const String voiceRecording = '/voice-recording';
  static const String settings = '/settings';
}

/// Router provider for the app
final routerProvider = Provider<GoRouter>((ref) {
  // Check authentication status
  final isAuthenticated = ref.watch(authStateProvider);
  final hasCompletedOnboarding = ref.watch(onboardingStateProvider);
  
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = isAuthenticated.value ?? false;
      final hasOnboarded = hasCompletedOnboarding.value ?? false;
      final location = state.uri.toString();
      
      // If not onboarded and not on onboarding screen, redirect to onboarding
      if (!hasOnboarded && location != AppRoutes.onboarding && location != AppRoutes.splash) {
        return AppRoutes.onboarding;
      }
      
      // If not authenticated and trying to access protected routes
      if (!isLoggedIn && _isProtectedRoute(location)) {
        return AppRoutes.phoneAuth;
      }
      
      // If authenticated and on auth screens, redirect to home
      if (isLoggedIn && _isAuthRoute(location)) {
        return AppRoutes.home;
      }
      
      return null; // No redirect needed
    },
    routes: [
      // Splash route
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Onboarding route
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // Authentication routes
      GoRoute(
        path: AppRoutes.phoneAuth,
        builder: (context, state) => const PhoneAuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) => OtpVerificationScreen(
          phoneNumber: state.uri.queryParameters['phone'] ?? '',
        ),
      ),
      
      // Main app routes with bottom navigation shell
      ShellRoute(
        builder: (context, state, child) => MainNavigationShell(child: child),
        routes: [
          // Home tab
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          
          // Lawyers tab
          GoRoute(
            path: AppRoutes.lawyers,
            builder: (context, state) => const LawyersListScreen(),
          ),
          
          // Consultations tab
          GoRoute(
            path: AppRoutes.consultations,
            builder: (context, state) => const ConsultationsListScreen(),
          ),
          
          // Documents tab
          GoRoute(
            path: AppRoutes.documents,
            builder: (context, state) => const DocumentsListScreen(),
          ),
          
          // Profile tab
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      
      // Detail routes (outside bottom navigation)
      GoRoute(
        path: AppRoutes.lawyerProfile,
        builder: (context, state) => LawyerProfileScreen(
          lawyerId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.consultationBooking,
        builder: (context, state) => ConsultationBookingScreen(
          lawyerId: state.pathParameters['lawyerId']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.consultationChat,
        builder: (context, state) => ConsultationChatScreen(
          consultationId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.documentTemplates,
        builder: (context, state) => const DocumentTemplatesScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.paymentMethods,
        builder: (context, state) => const PaymentMethodsScreen(),
      ),
      GoRoute(
        path: AppRoutes.voiceRecording,
        builder: (context, state) => const VoiceRecordingScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you\'re looking for doesn\'t exist.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

/// Check if route requires authentication
bool _isProtectedRoute(String location) {
  const protectedPaths = [
    AppRoutes.home,
    AppRoutes.lawyers,
    AppRoutes.consultations,
    AppRoutes.documents,
    AppRoutes.profile,
  ];
  
  return protectedPaths.any((path) => location.startsWith(path));
}

/// Check if route is an authentication route
bool _isAuthRoute(String location) {
  const authPaths = [
    AppRoutes.splash,
    AppRoutes.onboarding,
    AppRoutes.phoneAuth,
    AppRoutes.otpVerification,
  ];
  
  return authPaths.any((path) => location.startsWith(path));
}

/// Temporary providers (will be replaced with actual implementations)
final authStateProvider = StateProvider<AsyncValue<bool>>((ref) => const AsyncValue.data(false));
final onboardingStateProvider = StateProvider<AsyncValue<bool>>((ref) => const AsyncValue.data(false));