// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_recording.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoiceRecordingImpl _$$VoiceRecordingImplFromJson(Map<String, dynamic> json) =>
    _$VoiceRecordingImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      filePath: json['filePath'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      description: json['description'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isFavorite: json['isFavorite'] as bool? ?? false,
      fileSize: (json['fileSize'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$VoiceRecordingImplToJson(
        _$VoiceRecordingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'filePath': instance.filePath,
      'createdAt': instance.createdAt.toIso8601String(),
      'duration': instance.duration.inMicroseconds,
      'description': instance.description,
      'tags': instance.tags,
      'isFavorite': instance.isFavorite,
      'fileSize': instance.fileSize,
    };
