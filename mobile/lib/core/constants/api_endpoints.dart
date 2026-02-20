/// API endpoint constants for LawConnect GH backend
class ApiEndpoints {
  ApiEndpoints._();

  // Base URLs
  static const String baseUrl = 'http://localhost:5055/api/v1';
  static const String signalRHub = 'http://localhost:5055/chatHub';
  
  // Authentication Endpoints
  static const String authBase = '/auth';
  static const String requestOtp = '$authBase/request-otp';
  static const String verifyOtp = '$authBase/verify-otp';
  static const String refreshToken = '$authBase/refresh';
  static const String registerClient = '$authBase/register/client';
  static const String registerLawyer = '$authBase/register/lawyer';
  
  // Lawyers Endpoints
  static const String lawyersBase = '/lawyers';
  static const String searchLawyers = lawyersBase;
  static String lawyerProfile(String id) => '$lawyersBase/$id';
  static const String updateLawyerProfile = '$lawyersBase/profile';
  
  // Consultations Endpoints
  static const String consultationsBase = '/consultations';
  static const String createConsultation = consultationsBase;
  static const String listConsultations = consultationsBase;
  static String consultationById(String id) => '$consultationsBase/$id';
  static String completeConsultation(String id) => '$consultationsBase/$id/complete';
  static String cancelConsultation(String id) => '$consultationsBase/$id/cancel';
  
  // Documents Endpoints
  static const String documentsBase = '/documents';
  static const String documentTemplates = '$documentsBase/templates';
  static const String generateDocument = '$documentsBase/generate';
  static const String listDocuments = documentsBase;
  static String documentById(String id) => '$documentsBase/$id';
  
  // Admin Endpoints
  static const String adminBase = '/admin';
  static const String pendingLawyers = '$adminBase/lawyers/pending';
  static String verifyLawyer(String id) => '$adminBase/lawyers/$id/verify';
  
  // Additional endpoints that might be added
  static const String paymentsBase = '/payments';
  static const String notificationsBase = '/notifications';
  static const String legalTopicsBase = '/legal-topics';
  static const String knowledgeBase = '/knowledge-base';
  
  // File Upload
  static const String uploadAvatar = '/files/avatar';
  static const String uploadDocument = '/files/document';
  
  // Real-time SignalR methods
  static const String signalRJoinConsultation = 'JoinConsultation';
  static const String signalRLeaveConsultation = 'LeaveConsultation';
  static const String signalRSendMessage = 'SendMessage';
  static const String signalRReceiveMessage = 'ReceiveMessage';
  static const String signalRTyping = 'Typing';
  static const String signalRStopTyping = 'StopTyping';
  static const String signalRConsultationUpdated = 'ConsultationUpdated';
}