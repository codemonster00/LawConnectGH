import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Import all screen files
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
import '../features/payments/presentation/momo_payment_screen.dart';
import '../features/voice_recording/presentation/voice_recording_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/notifications/presentation/notifications_screen.dart';
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
  static const String lawyerProfile = '/lawyer/:id';
  static const String consultationBook = '/consultation/book';
  static const String consultationActive = '/consultation/active';
  static const String consultationChat = '/consultation/:id/chat';
  static const String documentTemplates = '/documents/templates';
  static const String editProfile = '/profile/edit';
  static const String paymentMethods = '/payments';
  static const String momoPayment = '/payment/momo';
  static const String notifications = '/notifications';
  static const String voiceRecording = '/voice-recording';
  static const String settings = '/settings';
}

/// Router provider for the app
final routerProvider = Provider<GoRouter>((ref) {
  // For demo purposes, we'll assume user is authenticated after OTP
  // In a real app, this would check actual auth state
  
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    routes: [
      // Splash route
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Onboarding route
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // Authentication routes
      GoRoute(
        path: AppRoutes.phoneAuth,
        name: 'phone-auth',
        builder: (context, state) => const PhoneAuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        name: 'otp-verification',
        builder: (context, state) {
          final phoneNumber = (state.extra as Map<String, dynamic>?)?['phoneNumber'] as String? ?? '';
          return OtpVerificationScreen(phoneNumber: phoneNumber);
        },
      ),
      
      // Main app routes with bottom navigation shell
      ShellRoute(
        builder: (context, state, child) => MainNavigationShell(child: child),
        routes: [
          // Home tab
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          
          // Lawyers tab
          GoRoute(
            path: AppRoutes.lawyers,
            name: 'lawyers',
            builder: (context, state) => const LawyersListScreen(),
          ),
          
          // Consultations tab
          GoRoute(
            path: AppRoutes.consultations,
            name: 'consultations',
            builder: (context, state) => const ConsultationsListScreen(),
          ),
          
          // Documents tab
          GoRoute(
            path: AppRoutes.documents,
            name: 'documents',
            builder: (context, state) => const DocumentsListScreen(),
          ),
          
          // Profile tab
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      
      // Detail routes (outside bottom navigation)
      GoRoute(
        path: AppRoutes.lawyerProfile,
        name: 'lawyer-profile',
        builder: (context, state) => LawyerProfileScreen(
          lawyerId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.consultationBook,
        name: 'consultation-book',
        builder: (context, state) => const ConsultationBookingScreen(),
      ),
      GoRoute(
        path: AppRoutes.consultationActive,
        name: 'consultation-active',
        builder: (context, state) => const ConsultationChatScreen(
          consultationId: 'active',
        ),
      ),
      GoRoute(
        path: AppRoutes.consultationChat,
        name: 'consultation-chat',
        builder: (context, state) => ConsultationChatScreen(
          consultationId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.documentTemplates,
        name: 'document-templates',
        builder: (context, state) => const DocumentTemplatesScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        name: 'edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.paymentMethods,
        name: 'payments',
        builder: (context, state) => const PaymentMethodsScreen(),
      ),
      GoRoute(
        path: AppRoutes.momoPayment,
        name: 'momo-payment',
        builder: (context, state) => const MomoPaymentScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        name: 'notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.voiceRecording,
        name: 'voice-recording',
        builder: (context, state) => const VoiceRecordingScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F1B2D), Color(0xFF1B2A42)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Page Not Found',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'The page you\'re looking for doesn\'t exist or has been moved.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => context.go(AppRoutes.home),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC6952B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Go Home',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
});

/// Temporary auth state providers
final authStateProvider = StateProvider<bool>((ref) => false);
final onboardingStateProvider = StateProvider<bool>((ref) => false);