// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      region: json['region'] as String?,
      city: json['city'] as String?,
      preferredLanguage: json['preferredLanguage'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'fullName': instance.fullName,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'region': instance.region,
      'city': instance.city,
      'preferredLanguage': instance.preferredLanguage,
      'role': _$UserRoleEnumMap[instance.role]!,
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.client: 'Client',
  UserRole.lawyer: 'Lawyer',
  UserRole.admin: 'Admin',
};

_$LawyerProfileImpl _$$LawyerProfileImplFromJson(Map<String, dynamic> json) =>
    _$LawyerProfileImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      barNumber: json['barNumber'] as String,
      yearCalledToBar: (json['yearCalledToBar'] as num).toInt(),
      bio: json['bio'] as String?,
      lawFirm: json['lawFirm'] as String?,
      consultationFee15Min: (json['consultationFee15Min'] as num).toDouble(),
      consultationFee30Min: (json['consultationFee30Min'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool? ?? false,
      verificationStatus: json['verificationStatus'] as String? ?? 'Pending',
      ratingAvg: (json['ratingAvg'] as num?)?.toDouble() ?? 0.0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      totalConsultations: (json['totalConsultations'] as num?)?.toInt() ?? 0,
      responseTimeAvgMin: (json['responseTimeAvgMin'] as num?)?.toInt(),
      specializations: (json['specializations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LawyerProfileImplToJson(_$LawyerProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'barNumber': instance.barNumber,
      'yearCalledToBar': instance.yearCalledToBar,
      'bio': instance.bio,
      'lawFirm': instance.lawFirm,
      'consultationFee15Min': instance.consultationFee15Min,
      'consultationFee30Min': instance.consultationFee30Min,
      'isAvailable': instance.isAvailable,
      'verificationStatus': instance.verificationStatus,
      'ratingAvg': instance.ratingAvg,
      'ratingCount': instance.ratingCount,
      'totalConsultations': instance.totalConsultations,
      'responseTimeAvgMin': instance.responseTimeAvgMin,
      'specializations': instance.specializations,
    };

_$ConsultationImpl _$$ConsultationImplFromJson(Map<String, dynamic> json) =>
    _$ConsultationImpl(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String,
      lawyerId: json['lawyerId'] as String?,
      lawyerName: json['lawyerName'] as String?,
      legalTopicName: json['legalTopicName'] as String?,
      status: json['status'] as String,
      type: json['type'] as String,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      problemDescription: json['problemDescription'] as String,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      clientRating: (json['clientRating'] as num?)?.toInt(),
      totalFee: (json['totalFee'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ConsultationImplToJson(_$ConsultationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'lawyerId': instance.lawyerId,
      'lawyerName': instance.lawyerName,
      'legalTopicName': instance.legalTopicName,
      'status': instance.status,
      'type': instance.type,
      'durationMinutes': instance.durationMinutes,
      'problemDescription': instance.problemDescription,
      'startedAt': instance.startedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'clientRating': instance.clientRating,
      'totalFee': instance.totalFee,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$LegalTopicImpl _$$LegalTopicImplFromJson(Map<String, dynamic> json) =>
    _$LegalTopicImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      iconUrl: json['iconUrl'] as String?,
      consultationCount: (json['consultationCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$LegalTopicImplToJson(_$LegalTopicImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'consultationCount': instance.consultationCount,
    };

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      consultationId: json['consultationId'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      content: json['content'] as String,
      messageType: json['messageType'] as String? ?? 'Text',
      attachmentUrl: json['attachmentUrl'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      sentAt: DateTime.parse(json['sentAt'] as String),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'consultationId': instance.consultationId,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'content': instance.content,
      'messageType': instance.messageType,
      'attachmentUrl': instance.attachmentUrl,
      'isRead': instance.isRead,
      'sentAt': instance.sentAt.toIso8601String(),
    };

_$DocumentTemplateImpl _$$DocumentTemplateImplFromJson(
        Map<String, dynamic> json) =>
    _$DocumentTemplateImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      category: json['category'] as String,
      fee: (json['fee'] as num).toDouble(),
      requiredFields: (json['requiredFields'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      previewUrl: json['previewUrl'] as String?,
    );

Map<String, dynamic> _$$DocumentTemplateImplToJson(
        _$DocumentTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'fee': instance.fee,
      'requiredFields': instance.requiredFields,
      'previewUrl': instance.previewUrl,
    };

_$GeneratedDocumentImpl _$$GeneratedDocumentImplFromJson(
        Map<String, dynamic> json) =>
    _$GeneratedDocumentImpl(
      id: json['id'] as String,
      templateId: json['templateId'] as String,
      templateName: json['templateName'] as String,
      userId: json['userId'] as String,
      status: json['status'] as String,
      documentUrl: json['documentUrl'] as String?,
      fee: (json['fee'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$GeneratedDocumentImplToJson(
        _$GeneratedDocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'templateId': instance.templateId,
      'templateName': instance.templateName,
      'userId': instance.userId,
      'status': instance.status,
      'documentUrl': instance.documentUrl,
      'fee': instance.fee,
      'createdAt': instance.createdAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

_$PaymentMethodImpl _$$PaymentMethodImplFromJson(Map<String, dynamic> json) =>
    _$PaymentMethodImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      provider: json['provider'] as String,
      number: json['number'] as String,
      name: json['name'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PaymentMethodImplToJson(_$PaymentMethodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'provider': instance.provider,
      'number': instance.number,
      'name': instance.name,
      'isDefault': instance.isDefault,
      'createdAt': instance.createdAt.toIso8601String(),
    };
