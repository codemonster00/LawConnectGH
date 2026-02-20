/// Local storage keys for LawConnect GH
class StorageKeys {
  StorageKeys._();
  
  // Authentication
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userRole = 'user_role';
  static const String isLoggedIn = 'is_logged_in';
  static const String lastLoginPhone = 'last_login_phone';
  
  // User Profile
  static const String userProfile = 'user_profile';
  static const String userPreferences = 'user_preferences';
  static const String preferredLanguage = 'preferred_language';
  static const String selectedRegion = 'selected_region';
  
  // App State
  static const String hasCompletedOnboarding = 'has_completed_onboarding';
  static const String appVersion = 'app_version';
  static const String lastAppUpdate = 'last_app_update';
  
  // Cache
  static const String lawyerListCache = 'lawyer_list_cache';
  static const String consultationsCache = 'consultations_cache';
  static const String documentsCache = 'documents_cache';
  static const String legalTopicsCache = 'legal_topics_cache';
  static const String lastCacheUpdate = 'last_cache_update';
  
  // Notifications
  static const String fcmToken = 'fcm_token';
  static const String notificationSettings = 'notification_settings';
  static const String pushNotificationsEnabled = 'push_notifications_enabled';
  
  // Search & Filters
  static const String recentSearches = 'recent_searches';
  static const String savedFilters = 'saved_filters';
  static const String favoriteLawyers = 'favorite_lawyers';
  
  // Payment
  static const String paymentMethods = 'payment_methods';
  static const String defaultPaymentMethod = 'default_payment_method';
  static const String paymentHistory = 'payment_history';
  
  // Chat
  static const String chatMessages = 'chat_messages';
  static const String unreadMessageCount = 'unread_message_count';
  
  // Development
  static const String isDeveloperMode = 'is_developer_mode';
  static const String apiBaseUrl = 'api_base_url';
}