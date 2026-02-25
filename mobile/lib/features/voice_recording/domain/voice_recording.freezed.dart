// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_recording.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoiceRecording _$VoiceRecordingFromJson(Map<String, dynamic> json) {
  return _VoiceRecording.fromJson(json);
}

/// @nodoc
mixin _$VoiceRecording {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  double? get fileSize => throw _privateConstructorUsedError;

  /// Serializes this VoiceRecording to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoiceRecording
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoiceRecordingCopyWith<VoiceRecording> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceRecordingCopyWith<$Res> {
  factory $VoiceRecordingCopyWith(
          VoiceRecording value, $Res Function(VoiceRecording) then) =
      _$VoiceRecordingCopyWithImpl<$Res, VoiceRecording>;
  @useResult
  $Res call(
      {String id,
      String title,
      String filePath,
      DateTime createdAt,
      Duration duration,
      String? description,
      List<String>? tags,
      bool isFavorite,
      double? fileSize});
}

/// @nodoc
class _$VoiceRecordingCopyWithImpl<$Res, $Val extends VoiceRecording>
    implements $VoiceRecordingCopyWith<$Res> {
  _$VoiceRecordingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoiceRecording
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? filePath = null,
    Object? createdAt = null,
    Object? duration = null,
    Object? description = freezed,
    Object? tags = freezed,
    Object? isFavorite = null,
    Object? fileSize = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoiceRecordingImplCopyWith<$Res>
    implements $VoiceRecordingCopyWith<$Res> {
  factory _$$VoiceRecordingImplCopyWith(_$VoiceRecordingImpl value,
          $Res Function(_$VoiceRecordingImpl) then) =
      __$$VoiceRecordingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String filePath,
      DateTime createdAt,
      Duration duration,
      String? description,
      List<String>? tags,
      bool isFavorite,
      double? fileSize});
}

/// @nodoc
class __$$VoiceRecordingImplCopyWithImpl<$Res>
    extends _$VoiceRecordingCopyWithImpl<$Res, _$VoiceRecordingImpl>
    implements _$$VoiceRecordingImplCopyWith<$Res> {
  __$$VoiceRecordingImplCopyWithImpl(
      _$VoiceRecordingImpl _value, $Res Function(_$VoiceRecordingImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceRecording
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? filePath = null,
    Object? createdAt = null,
    Object? duration = null,
    Object? description = freezed,
    Object? tags = freezed,
    Object? isFavorite = null,
    Object? fileSize = freezed,
  }) {
    return _then(_$VoiceRecordingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoiceRecordingImpl implements _VoiceRecording {
  const _$VoiceRecordingImpl(
      {required this.id,
      required this.title,
      required this.filePath,
      required this.createdAt,
      required this.duration,
      this.description,
      final List<String>? tags,
      this.isFavorite = false,
      this.fileSize})
      : _tags = tags;

  factory _$VoiceRecordingImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoiceRecordingImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String filePath;
  @override
  final DateTime createdAt;
  @override
  final Duration duration;
  @override
  final String? description;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isFavorite;
  @override
  final double? fileSize;

  @override
  String toString() {
    return 'VoiceRecording(id: $id, title: $title, filePath: $filePath, createdAt: $createdAt, duration: $duration, description: $description, tags: $tags, isFavorite: $isFavorite, fileSize: $fileSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoiceRecordingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      filePath,
      createdAt,
      duration,
      description,
      const DeepCollectionEquality().hash(_tags),
      isFavorite,
      fileSize);

  /// Create a copy of VoiceRecording
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoiceRecordingImplCopyWith<_$VoiceRecordingImpl> get copyWith =>
      __$$VoiceRecordingImplCopyWithImpl<_$VoiceRecordingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoiceRecordingImplToJson(
      this,
    );
  }
}

abstract class _VoiceRecording implements VoiceRecording {
  const factory _VoiceRecording(
      {required final String id,
      required final String title,
      required final String filePath,
      required final DateTime createdAt,
      required final Duration duration,
      final String? description,
      final List<String>? tags,
      final bool isFavorite,
      final double? fileSize}) = _$VoiceRecordingImpl;

  factory _VoiceRecording.fromJson(Map<String, dynamic> json) =
      _$VoiceRecordingImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get filePath;
  @override
  DateTime get createdAt;
  @override
  Duration get duration;
  @override
  String? get description;
  @override
  List<String>? get tags;
  @override
  bool get isFavorite;
  @override
  double? get fileSize;

  /// Create a copy of VoiceRecording
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoiceRecordingImplCopyWith<_$VoiceRecordingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AudioAmplitude {
  double get amplitude => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Create a copy of AudioAmplitude
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioAmplitudeCopyWith<AudioAmplitude> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioAmplitudeCopyWith<$Res> {
  factory $AudioAmplitudeCopyWith(
          AudioAmplitude value, $Res Function(AudioAmplitude) then) =
      _$AudioAmplitudeCopyWithImpl<$Res, AudioAmplitude>;
  @useResult
  $Res call({double amplitude, DateTime timestamp});
}

/// @nodoc
class _$AudioAmplitudeCopyWithImpl<$Res, $Val extends AudioAmplitude>
    implements $AudioAmplitudeCopyWith<$Res> {
  _$AudioAmplitudeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioAmplitude
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amplitude = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      amplitude: null == amplitude
          ? _value.amplitude
          : amplitude // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioAmplitudeImplCopyWith<$Res>
    implements $AudioAmplitudeCopyWith<$Res> {
  factory _$$AudioAmplitudeImplCopyWith(_$AudioAmplitudeImpl value,
          $Res Function(_$AudioAmplitudeImpl) then) =
      __$$AudioAmplitudeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amplitude, DateTime timestamp});
}

/// @nodoc
class __$$AudioAmplitudeImplCopyWithImpl<$Res>
    extends _$AudioAmplitudeCopyWithImpl<$Res, _$AudioAmplitudeImpl>
    implements _$$AudioAmplitudeImplCopyWith<$Res> {
  __$$AudioAmplitudeImplCopyWithImpl(
      _$AudioAmplitudeImpl _value, $Res Function(_$AudioAmplitudeImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioAmplitude
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amplitude = null,
    Object? timestamp = null,
  }) {
    return _then(_$AudioAmplitudeImpl(
      amplitude: null == amplitude
          ? _value.amplitude
          : amplitude // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$AudioAmplitudeImpl implements _AudioAmplitude {
  const _$AudioAmplitudeImpl(
      {required this.amplitude, required this.timestamp});

  @override
  final double amplitude;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'AudioAmplitude(amplitude: $amplitude, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioAmplitudeImpl &&
            (identical(other.amplitude, amplitude) ||
                other.amplitude == amplitude) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amplitude, timestamp);

  /// Create a copy of AudioAmplitude
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioAmplitudeImplCopyWith<_$AudioAmplitudeImpl> get copyWith =>
      __$$AudioAmplitudeImplCopyWithImpl<_$AudioAmplitudeImpl>(
          this, _$identity);
}

abstract class _AudioAmplitude implements AudioAmplitude {
  const factory _AudioAmplitude(
      {required final double amplitude,
      required final DateTime timestamp}) = _$AudioAmplitudeImpl;

  @override
  double get amplitude;
  @override
  DateTime get timestamp;

  /// Create a copy of AudioAmplitude
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioAmplitudeImplCopyWith<_$AudioAmplitudeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlaybackPosition {
  Duration get position => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;

  /// Create a copy of PlaybackPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybackPositionCopyWith<PlaybackPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybackPositionCopyWith<$Res> {
  factory $PlaybackPositionCopyWith(
          PlaybackPosition value, $Res Function(PlaybackPosition) then) =
      _$PlaybackPositionCopyWithImpl<$Res, PlaybackPosition>;
  @useResult
  $Res call({Duration position, Duration duration, double progress});
}

/// @nodoc
class _$PlaybackPositionCopyWithImpl<$Res, $Val extends PlaybackPosition>
    implements $PlaybackPositionCopyWith<$Res> {
  _$PlaybackPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybackPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? duration = null,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlaybackPositionImplCopyWith<$Res>
    implements $PlaybackPositionCopyWith<$Res> {
  factory _$$PlaybackPositionImplCopyWith(_$PlaybackPositionImpl value,
          $Res Function(_$PlaybackPositionImpl) then) =
      __$$PlaybackPositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration position, Duration duration, double progress});
}

/// @nodoc
class __$$PlaybackPositionImplCopyWithImpl<$Res>
    extends _$PlaybackPositionCopyWithImpl<$Res, _$PlaybackPositionImpl>
    implements _$$PlaybackPositionImplCopyWith<$Res> {
  __$$PlaybackPositionImplCopyWithImpl(_$PlaybackPositionImpl _value,
      $Res Function(_$PlaybackPositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlaybackPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? duration = null,
    Object? progress = null,
  }) {
    return _then(_$PlaybackPositionImpl(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$PlaybackPositionImpl implements _PlaybackPosition {
  const _$PlaybackPositionImpl(
      {required this.position, required this.duration, required this.progress});

  @override
  final Duration position;
  @override
  final Duration duration;
  @override
  final double progress;

  @override
  String toString() {
    return 'PlaybackPosition(position: $position, duration: $duration, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybackPositionImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position, duration, progress);

  /// Create a copy of PlaybackPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybackPositionImplCopyWith<_$PlaybackPositionImpl> get copyWith =>
      __$$PlaybackPositionImplCopyWithImpl<_$PlaybackPositionImpl>(
          this, _$identity);
}

abstract class _PlaybackPosition implements PlaybackPosition {
  const factory _PlaybackPosition(
      {required final Duration position,
      required final Duration duration,
      required final double progress}) = _$PlaybackPositionImpl;

  @override
  Duration get position;
  @override
  Duration get duration;
  @override
  double get progress;

  /// Create a copy of PlaybackPosition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybackPositionImplCopyWith<_$PlaybackPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecordingConfig {
  int get sampleRate => throw _privateConstructorUsedError;
  int get bitRate => throw _privateConstructorUsedError;
  String get format => throw _privateConstructorUsedError;
  bool get enableNoiseSuppression => throw _privateConstructorUsedError;
  bool get enableEchoCancellation => throw _privateConstructorUsedError;

  /// Create a copy of RecordingConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordingConfigCopyWith<RecordingConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordingConfigCopyWith<$Res> {
  factory $RecordingConfigCopyWith(
          RecordingConfig value, $Res Function(RecordingConfig) then) =
      _$RecordingConfigCopyWithImpl<$Res, RecordingConfig>;
  @useResult
  $Res call(
      {int sampleRate,
      int bitRate,
      String format,
      bool enableNoiseSuppression,
      bool enableEchoCancellation});
}

/// @nodoc
class _$RecordingConfigCopyWithImpl<$Res, $Val extends RecordingConfig>
    implements $RecordingConfigCopyWith<$Res> {
  _$RecordingConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordingConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sampleRate = null,
    Object? bitRate = null,
    Object? format = null,
    Object? enableNoiseSuppression = null,
    Object? enableEchoCancellation = null,
  }) {
    return _then(_value.copyWith(
      sampleRate: null == sampleRate
          ? _value.sampleRate
          : sampleRate // ignore: cast_nullable_to_non_nullable
              as int,
      bitRate: null == bitRate
          ? _value.bitRate
          : bitRate // ignore: cast_nullable_to_non_nullable
              as int,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      enableNoiseSuppression: null == enableNoiseSuppression
          ? _value.enableNoiseSuppression
          : enableNoiseSuppression // ignore: cast_nullable_to_non_nullable
              as bool,
      enableEchoCancellation: null == enableEchoCancellation
          ? _value.enableEchoCancellation
          : enableEchoCancellation // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordingConfigImplCopyWith<$Res>
    implements $RecordingConfigCopyWith<$Res> {
  factory _$$RecordingConfigImplCopyWith(_$RecordingConfigImpl value,
          $Res Function(_$RecordingConfigImpl) then) =
      __$$RecordingConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int sampleRate,
      int bitRate,
      String format,
      bool enableNoiseSuppression,
      bool enableEchoCancellation});
}

/// @nodoc
class __$$RecordingConfigImplCopyWithImpl<$Res>
    extends _$RecordingConfigCopyWithImpl<$Res, _$RecordingConfigImpl>
    implements _$$RecordingConfigImplCopyWith<$Res> {
  __$$RecordingConfigImplCopyWithImpl(
      _$RecordingConfigImpl _value, $Res Function(_$RecordingConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordingConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sampleRate = null,
    Object? bitRate = null,
    Object? format = null,
    Object? enableNoiseSuppression = null,
    Object? enableEchoCancellation = null,
  }) {
    return _then(_$RecordingConfigImpl(
      sampleRate: null == sampleRate
          ? _value.sampleRate
          : sampleRate // ignore: cast_nullable_to_non_nullable
              as int,
      bitRate: null == bitRate
          ? _value.bitRate
          : bitRate // ignore: cast_nullable_to_non_nullable
              as int,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      enableNoiseSuppression: null == enableNoiseSuppression
          ? _value.enableNoiseSuppression
          : enableNoiseSuppression // ignore: cast_nullable_to_non_nullable
              as bool,
      enableEchoCancellation: null == enableEchoCancellation
          ? _value.enableEchoCancellation
          : enableEchoCancellation // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RecordingConfigImpl implements _RecordingConfig {
  const _$RecordingConfigImpl(
      {this.sampleRate = 44100,
      this.bitRate = 128000,
      this.format = 'm4a',
      this.enableNoiseSuppression = true,
      this.enableEchoCancellation = true});

  @override
  @JsonKey()
  final int sampleRate;
  @override
  @JsonKey()
  final int bitRate;
  @override
  @JsonKey()
  final String format;
  @override
  @JsonKey()
  final bool enableNoiseSuppression;
  @override
  @JsonKey()
  final bool enableEchoCancellation;

  @override
  String toString() {
    return 'RecordingConfig(sampleRate: $sampleRate, bitRate: $bitRate, format: $format, enableNoiseSuppression: $enableNoiseSuppression, enableEchoCancellation: $enableEchoCancellation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordingConfigImpl &&
            (identical(other.sampleRate, sampleRate) ||
                other.sampleRate == sampleRate) &&
            (identical(other.bitRate, bitRate) || other.bitRate == bitRate) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.enableNoiseSuppression, enableNoiseSuppression) ||
                other.enableNoiseSuppression == enableNoiseSuppression) &&
            (identical(other.enableEchoCancellation, enableEchoCancellation) ||
                other.enableEchoCancellation == enableEchoCancellation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sampleRate, bitRate, format,
      enableNoiseSuppression, enableEchoCancellation);

  /// Create a copy of RecordingConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordingConfigImplCopyWith<_$RecordingConfigImpl> get copyWith =>
      __$$RecordingConfigImplCopyWithImpl<_$RecordingConfigImpl>(
          this, _$identity);
}

abstract class _RecordingConfig implements RecordingConfig {
  const factory _RecordingConfig(
      {final int sampleRate,
      final int bitRate,
      final String format,
      final bool enableNoiseSuppression,
      final bool enableEchoCancellation}) = _$RecordingConfigImpl;

  @override
  int get sampleRate;
  @override
  int get bitRate;
  @override
  String get format;
  @override
  bool get enableNoiseSuppression;
  @override
  bool get enableEchoCancellation;

  /// Create a copy of RecordingConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordingConfigImplCopyWith<_$RecordingConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
