import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String phoneNumber,
    required String fullName,
    String? email,
    String? avatarUrl,
    String? region,
    String? city,
    String? preferredLanguage,
    required UserRole role,
    DateTime? lastLoginAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class LawyerProfile with _$LawyerProfile {
  const factory LawyerProfile({
    required String id,
    required String userId,
    required String fullName,
    String? avatarUrl,
    required String barNumber,
    required int yearCalledToBar,
    String? bio,
    String? lawFirm,
    required double consultationFee15Min,
    required double consultationFee30Min,
    @Default(false) bool isAvailable,
    @Default('Pending') String verificationStatus,
    @Default(0.0) double ratingAvg,
    @Default(0) int ratingCount,
    @Default(0) int totalConsultations,
    int? responseTimeAvgMin,
    @Default([]) List<String> specializations,
  }) = _LawyerProfile;

  factory LawyerProfile.fromJson(Map<String, dynamic> json) => _$LawyerProfileFromJson(json);
}

@freezed
class Consultation with _$Consultation {
  const factory Consultation({
    required String id,
    required String clientId,
    required String clientName,
    String? lawyerId,
    String? lawyerName,
    String? legalTopicName,
    required String status,
    required String type,
    int? durationMinutes,
    required String problemDescription,
    DateTime? startedAt,
    DateTime? endedAt,
    int? clientRating,
    double? totalFee,
    required DateTime createdAt,
  }) = _Consultation;

  factory Consultation.fromJson(Map<String, dynamic> json) => _$ConsultationFromJson(json);
}

@freezed
class LegalTopic with _$LegalTopic {
  const factory LegalTopic({
    required String id,
    required String name,
    String? description,
    String? iconUrl,
    @Default(0) int consultationCount,
  }) = _LegalTopic;

  factory LegalTopic.fromJson(Map<String, dynamic> json) => _$LegalTopicFromJson(json);
}

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String consultationId,
    required String senderId,
    required String senderName,
    required String content,
    @Default('Text') String messageType,
    String? attachmentUrl,
    @Default(false) bool isRead,
    required DateTime sentAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}

@freezed
class DocumentTemplate with _$DocumentTemplate {
  const factory DocumentTemplate({
    required String id,
    required String name,
    String? description,
    required String category,
    required double fee,
    @Default([]) List<String> requiredFields,
    String? previewUrl,
  }) = _DocumentTemplate;

  factory DocumentTemplate.fromJson(Map<String, dynamic> json) => _$DocumentTemplateFromJson(json);
}

@freezed
class GeneratedDocument with _$GeneratedDocument {
  const factory GeneratedDocument({
    required String id,
    required String templateId,
    required String templateName,
    required String userId,
    required String status,
    String? documentUrl,
    double? fee,
    required DateTime createdAt,
    DateTime? completedAt,
  }) = _GeneratedDocument;

  factory GeneratedDocument.fromJson(Map<String, dynamic> json) => _$GeneratedDocumentFromJson(json);
}

@freezed
class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required String id,
    required String type,
    required String provider,
    required String number,
    required String name,
    @Default(false) bool isDefault,
    required DateTime createdAt,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);
}

enum UserRole {
  @JsonValue('Client')
  client,
  @JsonValue('Lawyer')
  lawyer,
  @JsonValue('Admin')
  admin,
}

enum ConsultationType {
  @JsonValue('Instant')
  instant,
  @JsonValue('Scheduled')
  scheduled,
}

enum ConsultationStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('Active')
  active,
  @JsonValue('Completed')
  completed,
  @JsonValue('Cancelled')
  cancelled,
}

enum VerificationStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('Verified')
  verified,
  @JsonValue('Rejected')
  rejected,
}

enum MessageType {
  @JsonValue('Text')
  text,
  @JsonValue('Image')
  image,
  @JsonValue('Document')
  document,
  @JsonValue('System')
  system,
}

enum DocumentStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('InProgress')
  inProgress,
  @JsonValue('Completed')
  completed,
  @JsonValue('Rejected')
  rejected,
}

enum PaymentProvider {
  @JsonValue('MTN')
  mtn,
  @JsonValue('Vodafone')
  vodafone,
  @JsonValue('AirtelTigo')
  airtelTigo,
  @JsonValue('Bank')
  bank,
}