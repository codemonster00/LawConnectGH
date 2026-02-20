import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../core/constants/app_strings.dart';
import 'router.dart';
import 'theme.dart';

/// The root app widget
class LawConnectApp extends ConsumerWidget {
  const LawConnectApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      // App Info
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      
      // Routing
      routerConfig: router,
      
      // Theme
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      
      // Localization (ready for future expansion)
      supportedLocales: const [
        Locale('en', 'GH'), // English (Ghana)
        // Future: Add Twi, Ga, Hausa support
      ],
      
      // Platform-specific configurations
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Theme.of(context).brightness == Brightness.light 
              ? Brightness.dark 
              : Brightness.light,
          ),
          child: child!,
        );
      },
    );
  }
}

/// Initialize app dependencies
Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Register Hive adapters for custom objects
  // Hive.registerAdapter(UserAdapter());
  // Hive.registerAdapter(ConsultationAdapter());
  // Hive.registerAdapter(LawyerProfileAdapter());
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}