// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get preferredLanguage => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String phoneNumber,
      String fullName,
      String? email,
      String? avatarUrl,
      String? region,
      String? city,
      String? preferredLanguage,
      UserRole role,
      DateTime? lastLoginAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? fullName = null,
    Object? email = freezed,
    Object? avatarUrl = freezed,
    Object? region = freezed,
    Object? city = freezed,
    Object? preferredLanguage = freezed,
    Object? role = null,
    Object? lastLoginAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      preferredLanguage: freezed == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String phoneNumber,
      String fullName,
      String? email,
      String? avatarUrl,
      String? region,
      String? city,
      String? preferredLanguage,
      UserRole role,
      DateTime? lastLoginAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? fullName = null,
    Object? email = freezed,
    Object? avatarUrl = freezed,
    Object? region = freezed,
    Object? city = freezed,
    Object? preferredLanguage = freezed,
    Object? role = null,
    Object? lastLoginAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      preferredLanguage: freezed == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.phoneNumber,
      required this.fullName,
      this.email,
      this.avatarUrl,
      this.region,
      this.city,
      this.preferredLanguage,
      required this.role,
      this.lastLoginAt,
      required this.createdAt,
      required this.updatedAt});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String phoneNumber;
  @override
  final String fullName;
  @override
  final String? email;
  @override
  final String? avatarUrl;
  @override
  final String? region;
  @override
  final String? city;
  @override
  final String? preferredLanguage;
  @override
  final UserRole role;
  @override
  final DateTime? lastLoginAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'User(id: $id, phoneNumber: $phoneNumber, fullName: $fullName, email: $email, avatarUrl: $avatarUrl, region: $region, city: $city, preferredLanguage: $preferredLanguage, role: $role, lastLoginAt: $lastLoginAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.preferredLanguage, preferredLanguage) ||
                other.preferredLanguage == preferredLanguage) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      phoneNumber,
      fullName,
      email,
      avatarUrl,
      region,
      city,
      preferredLanguage,
      role,
      lastLoginAt,
      createdAt,
      updatedAt);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String id,
      required final String phoneNumber,
      required final String fullName,
      final String? email,
      final String? avatarUrl,
      final String? region,
      final String? city,
      final String? preferredLanguage,
      required final UserRole role,
      final DateTime? lastLoginAt,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get phoneNumber;
  @override
  String get fullName;
  @override
  String? get email;
  @override
  String? get avatarUrl;
  @override
  String? get region;
  @override
  String? get city;
  @override
  String? get preferredLanguage;
  @override
  UserRole get role;
  @override
  DateTime? get lastLoginAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LawyerProfile _$LawyerProfileFromJson(Map<String, dynamic> json) {
  return _LawyerProfile.fromJson(json);
}

/// @nodoc
mixin _$LawyerProfile {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get barNumber => throw _privateConstructorUsedError;
  int get yearCalledToBar => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get lawFirm => throw _privateConstructorUsedError;
  double get consultationFee15Min => throw _privateConstructorUsedError;
  double get consultationFee30Min => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  String get verificationStatus => throw _privateConstructorUsedError;
  double get ratingAvg => throw _privateConstructorUsedError;
  int get ratingCount => throw _privateConstructorUsedError;
  int get totalConsultations => throw _privateConstructorUsedError;
  int? get responseTimeAvgMin => throw _privateConstructorUsedError;
  List<String> get specializations => throw _privateConstructorUsedError;

  /// Serializes this LawyerProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LawyerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LawyerProfileCopyWith<LawyerProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LawyerProfileCopyWith<$Res> {
  factory $LawyerProfileCopyWith(
          LawyerProfile value, $Res Function(LawyerProfile) then) =
      _$LawyerProfileCopyWithImpl<$Res, LawyerProfile>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String fullName,
      String? avatarUrl,
      String barNumber,
      int yearCalledToBar,
      String? bio,
      String? lawFirm,
      double consultationFee15Min,
      double consultationFee30Min,
      bool isAvailable,
      String verificationStatus,
      double ratingAvg,
      int ratingCount,
      int totalConsultations,
      int? responseTimeAvgMin,
      List<String> specializations});
}

/// @nodoc
class _$LawyerProfileCopyWithImpl<$Res, $Val extends LawyerProfile>
    implements $LawyerProfileCopyWith<$Res> {
  _$LawyerProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LawyerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = null,
    Object? avatarUrl = freezed,
    Object? barNumber = null,
    Object? yearCalledToBar = null,
    Object? bio = freezed,
    Object? lawFirm = freezed,
    Object? consultationFee15Min = null,
    Object? consultationFee30Min = null,
    Object? isAvailable = null,
    Object? verificationStatus = null,
    Object? ratingAvg = null,
    Object? ratingCount = null,
    Object? totalConsultations = null,
    Object? responseTimeAvgMin = freezed,
    Object? specializations = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      barNumber: null == barNumber
          ? _value.barNumber
          : barNumber // ignore: cast_nullable_to_non_nullable
              as String,
      yearCalledToBar: null == yearCalledToBar
          ? _value.yearCalledToBar
          : yearCalledToBar // ignore: cast_nullable_to_non_nullable
              as int,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      lawFirm: freezed == lawFirm
          ? _value.lawFirm
          : lawFirm // ignore: cast_nullable_to_non_nullable
              as String?,
      consultationFee15Min: null == consultationFee15Min
          ? _value.consultationFee15Min
          : consultationFee15Min // ignore: cast_nullable_to_non_nullable
              as double,
      consultationFee30Min: null == consultationFee30Min
          ? _value.consultationFee30Min
          : consultationFee30Min // ignore: cast_nullable_to_non_nullable
              as double,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as String,
      ratingAvg: null == ratingAvg
          ? _value.ratingAvg
          : ratingAvg // ignore: cast_nullable_to_non_nullable
              as double,
      ratingCount: null == ratingCount
          ? _value.ratingCount
          : ratingCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalConsultations: null == totalConsultations
          ? _value.totalConsultations
          : totalConsultations // ignore: cast_nullable_to_non_nullable
              as int,
      responseTimeAvgMin: freezed == responseTimeAvgMin
          ? _value.responseTimeAvgMin
          : responseTimeAvgMin // ignore: cast_nullable_to_non_nullable
              as int?,
      specializations: null == specializations
          ? _value.specializations
          : specializations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LawyerProfileImplCopyWith<$Res>
    implements $LawyerProfileCopyWith<$Res> {
  factory _$$LawyerProfileImplCopyWith(
          _$LawyerProfileImpl value, $Res Function(_$LawyerProfileImpl) then) =
      __$$LawyerProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String fullName,
      String? avatarUrl,
      String barNumber,
      int yearCalledToBar,
      String? bio,
      String? lawFirm,
      double consultationFee15Min,
      double consultationFee30Min,
      bool isAvailable,
      String verificationStatus,
      double ratingAvg,
      int ratingCount,
      int totalConsultations,
      int? responseTimeAvgMin,
      List<String> specializations});
}

/// @nodoc
class __$$LawyerProfileImplCopyWithImpl<$Res>
    extends _$LawyerProfileCopyWithImpl<$Res, _$LawyerProfileImpl>
    implements _$$LawyerProfileImplCopyWith<$Res> {
  __$$LawyerProfileImplCopyWithImpl(
      _$LawyerProfileImpl _value, $Res Function(_$LawyerProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of LawyerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = null,
    Object? avatarUrl = freezed,
    Object? barNumber = null,
    Object? yearCalledToBar = null,
    Object? bio = freezed,
    Object? lawFirm = freezed,
    Object? consultationFee15Min = null,
    Object? consultationFee30Min = null,
    Object? isAvailable = null,
    Object? verificationStatus = null,
    Object? ratingAvg = null,
    Object? ratingCount = null,
    Object? totalConsultations = null,
    Object? responseTimeAvgMin = freezed,
    Object? specializations = null,
  }) {
    return _then(_$LawyerProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      barNumber: null == barNumber
          ? _value.barNumber
          : barNumber // ignore: cast_nullable_to_non_nullable
              as String,
      yearCalledToBar: null == yearCalledToBar
          ? _value.yearCalledToBar
          : yearCalledToBar // ignore: cast_nullable_to_non_nullable
              as int,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      lawFirm: freezed == lawFirm
          ? _value.lawFirm
          : lawFirm // ignore: cast_nullable_to_non_nullable
              as String?,
      consultationFee15Min: null == consultationFee15Min
          ? _value.consultationFee15Min
          : consultationFee15Min // ignore: cast_nullable_to_non_nullable
              as double,
      consultationFee30Min: null == consultationFee30Min
          ? _value.consultationFee30Min
          : consultationFee30Min // ignore: cast_nullable_to_non_nullable
              as double,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as String,
      ratingAvg: null == ratingAvg
          ? _value.ratingAvg
          : ratingAvg // ignore: cast_nullable_to_non_nullable
              as double,
      ratingCount: null == ratingCount
          ? _value.ratingCount
          : ratingCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalConsultations: null == totalConsultations
          ? _value.totalConsultations
          : totalConsultations // ignore: cast_nullable_to_non_nullable
              as int,
      responseTimeAvgMin: freezed == responseTimeAvgMin
          ? _value.responseTimeAvgMin
          : responseTimeAvgMin // ignore: cast_nullable_to_non_nullable
              as int?,
      specializations: null == specializations
          ? _value._specializations
          : specializations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LawyerProfileImpl implements _LawyerProfile {
  const _$LawyerProfileImpl(
      {required this.id,
      required this.userId,
      required this.fullName,
      this.avatarUrl,
      required this.barNumber,
      required this.yearCalledToBar,
      this.bio,
      this.lawFirm,
      required this.consultationFee15Min,
      required this.consultationFee30Min,
      this.isAvailable = false,
      this.verificationStatus = 'Pending',
      this.ratingAvg = 0.0,
      this.ratingCount = 0,
      this.totalConsultations = 0,
      this.responseTimeAvgMin,
      final List<String> specializations = const []})
      : _specializations = specializations;

  factory _$LawyerProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$LawyerProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String fullName;
  @override
  final String? avatarUrl;
  @override
  final String barNumber;
  @override
  final int yearCalledToBar;
  @override
  final String? bio;
  @override
  final String? lawFirm;
  @override
  final double consultationFee15Min;
  @override
  final double consultationFee30Min;
  @override
  @JsonKey()
  final bool isAvailable;
  @override
  @JsonKey()
  final String verificationStatus;
  @override
  @JsonKey()
  final double ratingAvg;
  @override
  @JsonKey()
  final int ratingCount;
  @override
  @JsonKey()
  final int totalConsultations;
  @override
  final int? responseTimeAvgMin;
  final List<String> _specializations;
  @override
  @JsonKey()
  List<String> get specializations {
    if (_specializations is EqualUnmodifiableListView) return _specializations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specializations);
  }

  @override
  String toString() {
    return 'LawyerProfile(id: $id, userId: $userId, fullName: $fullName, avatarUrl: $avatarUrl, barNumber: $barNumber, yearCalledToBar: $yearCalledToBar, bio: $bio, lawFirm: $lawFirm, consultationFee15Min: $consultationFee15Min, consultationFee30Min: $consultationFee30Min, isAvailable: $isAvailable, verificationStatus: $verificationStatus, ratingAvg: $ratingAvg, ratingCount: $ratingCount, totalConsultations: $totalConsultations, responseTimeAvgMin: $responseTimeAvgMin, specializations: $specializations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LawyerProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.barNumber, barNumber) ||
                other.barNumber == barNumber) &&
            (identical(other.yearCalledToBar, yearCalledToBar) ||
                other.yearCalledToBar == yearCalledToBar) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.lawFirm, lawFirm) || other.lawFirm == lawFirm) &&
            (identical(other.consultationFee15Min, consultationFee15Min) ||
                other.consultationFee15Min == consultationFee15Min) &&
            (identical(other.consultationFee30Min, consultationFee30Min) ||
                other.consultationFee30Min == consultationFee30Min) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.verificationStatus, verificationStatus) ||
                other.verificationStatus == verificationStatus) &&
            (identical(other.ratingAvg, ratingAvg) ||
                other.ratingAvg == ratingAvg) &&
            (identical(other.ratingCount, ratingCount) ||
                other.ratingCount == ratingCount) &&
            (identical(other.totalConsultations, totalConsultations) ||
                other.totalConsultations == totalConsultations) &&
            (identical(other.responseTimeAvgMin, responseTimeAvgMin) ||
                other.responseTimeAvgMin == responseTimeAvgMin) &&
            const DeepCollectionEquality()
                .equals(other._specializations, _specializations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      fullName,
      avatarUrl,
      barNumber,
      yearCalledToBar,
      bio,
      lawFirm,
      consultationFee15Min,
      consultationFee30Min,
      isAvailable,
      verificationStatus,
      ratingAvg,
      ratingCount,
      totalConsultations,
      responseTimeAvgMin,
      const DeepCollectionEquality().hash(_specializations));

  /// Create a copy of LawyerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LawyerProfileImplCopyWith<_$LawyerProfileImpl> get copyWith =>
      __$$LawyerProfileImplCopyWithImpl<_$LawyerProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LawyerProfileImplToJson(
      this,
    );
  }
}

abstract class _LawyerProfile implements LawyerProfile {
  const factory _LawyerProfile(
      {required final String id,
      required final String userId,
      required final String fullName,
      final String? avatarUrl,
      required final String barNumber,
      required final int yearCalledToBar,
      final String? bio,
      final String? lawFirm,
      required final double consultationFee15Min,
      required final double consultationFee30Min,
      final bool isAvailable,
      final String verificationStatus,
      final double ratingAvg,
      final int ratingCount,
      final int totalConsultations,
      final int? responseTimeAvgMin,
      final List<String> specializations}) = _$LawyerProfileImpl;

  factory _LawyerProfile.fromJson(Map<String, dynamic> json) =
      _$LawyerProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get fullName;
  @override
  String? get avatarUrl;
  @override
  String get barNumber;
  @override
  int get yearCalledToBar;
  @override
  String? get bio;
  @override
  String? get lawFirm;
  @override
  double get consultationFee15Min;
  @override
  double get consultationFee30Min;
  @override
  bool get isAvailable;
  @override
  String get verificationStatus;
  @override
  double get ratingAvg;
  @override
  int get ratingCount;
  @override
  int get totalConsultations;
  @override
  int? get responseTimeAvgMin;
  @override
  List<String> get specializations;

  /// Create a copy of LawyerProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LawyerProfileImplCopyWith<_$LawyerProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Consultation _$ConsultationFromJson(Map<String, dynamic> json) {
  return _Consultation.fromJson(json);
}

/// @nodoc
mixin _$Consultation {
  String get id => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  String? get lawyerId => throw _privateConstructorUsedError;
  String? get lawyerName => throw _privateConstructorUsedError;
  String? get legalTopicName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int? get durationMinutes => throw _privateConstructorUsedError;
  String get problemDescription => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;
  int? get clientRating => throw _privateConstructorUsedError;
  double? get totalFee => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Consultation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Consultation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsultationCopyWith<Consultation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsultationCopyWith<$Res> {
  factory $ConsultationCopyWith(
          Consultation value, $Res Function(Consultation) then) =
      _$ConsultationCopyWithImpl<$Res, Consultation>;
  @useResult
  $Res call(
      {String id,
      String clientId,
      String clientName,
      String? lawyerId,
      String? lawyerName,
      String? legalTopicName,
      String status,
      String type,
      int? durationMinutes,
      String problemDescription,
      DateTime? startedAt,
      DateTime? endedAt,
      int? clientRating,
      double? totalFee,
      DateTime createdAt});
}

/// @nodoc
class _$ConsultationCopyWithImpl<$Res, $Val extends Consultation>
    implements $ConsultationCopyWith<$Res> {
  _$ConsultationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Consultation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? clientName = null,
    Object? lawyerId = freezed,
    Object? lawyerName = freezed,
    Object? legalTopicName = freezed,
    Object? status = null,
    Object? type = null,
    Object? durationMinutes = freezed,
    Object? problemDescription = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? clientRating = freezed,
    Object? totalFee = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      lawyerId: freezed == lawyerId
          ? _value.lawyerId
          : lawyerId // ignore: cast_nullable_to_non_nullable
              as String?,
      lawyerName: freezed == lawyerName
          ? _value.lawyerName
          : lawyerName // ignore: cast_nullable_to_non_nullable
              as String?,
      legalTopicName: freezed == legalTopicName
          ? _value.legalTopicName
          : legalTopicName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      problemDescription: null == problemDescription
          ? _value.problemDescription
          : problemDescription // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clientRating: freezed == clientRating
          ? _value.clientRating
          : clientRating // ignore: cast_nullable_to_non_nullable
              as int?,
      totalFee: freezed == totalFee
          ? _value.totalFee
          : totalFee // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConsultationImplCopyWith<$Res>
    implements $ConsultationCopyWith<$Res> {
  factory _$$ConsultationImplCopyWith(
          _$ConsultationImpl value, $Res Function(_$ConsultationImpl) then) =
      __$$ConsultationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String clientId,
      String clientName,
      String? lawyerId,
      String? lawyerName,
      String? legalTopicName,
      String status,
      String type,
      int? durationMinutes,
      String problemDescription,
      DateTime? startedAt,
      DateTime? endedAt,
      int? clientRating,
      double? totalFee,
      DateTime createdAt});
}

/// @nodoc
class __$$ConsultationImplCopyWithImpl<$Res>
    extends _$ConsultationCopyWithImpl<$Res, _$ConsultationImpl>
    implements _$$ConsultationImplCopyWith<$Res> {
  __$$ConsultationImplCopyWithImpl(
      _$ConsultationImpl _value, $Res Function(_$ConsultationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Consultation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? clientName = null,
    Object? lawyerId = freezed,
    Object? lawyerName = freezed,
    Object? legalTopicName = freezed,
    Object? status = null,
    Object? type = null,
    Object? durationMinutes = freezed,
    Object? problemDescription = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? clientRating = freezed,
    Object? totalFee = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$ConsultationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      lawyerId: freezed == lawyerId
          ? _value.lawyerId
          : lawyerId // ignore: cast_nullable_to_non_nullable
              as String?,
      lawyerName: freezed == lawyerName
          ? _value.lawyerName
          : lawyerName // ignore: cast_nullable_to_non_nullable
              as String?,
      legalTopicName: freezed == legalTopicName
          ? _value.legalTopicName
          : legalTopicName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      problemDescription: null == problemDescription
          ? _value.problemDescription
          : problemDescription // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clientRating: freezed == clientRating
          ? _value.clientRating
          : clientRating // ignore: cast_nullable_to_non_nullable
              as int?,
      totalFee: freezed == totalFee
          ? _value.totalFee
          : totalFee // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsultationImpl implements _Consultation {
  const _$ConsultationImpl(
      {required this.id,
      required this.clientId,
      required this.clientName,
      this.lawyerId,
      this.lawyerName,
      this.legalTopicName,
      required this.status,
      required this.type,
      this.durationMinutes,
      required this.problemDescription,
      this.startedAt,
      this.endedAt,
      this.clientRating,
      this.totalFee,
      required this.createdAt});

  factory _$ConsultationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsultationImplFromJson(json);

  @override
  final String id;
  @override
  final String clientId;
  @override
  final String clientName;
  @override
  final String? lawyerId;
  @override
  final String? lawyerName;
  @override
  final String? legalTopicName;
  @override
  final String status;
  @override
  final String type;
  @override
  final int? durationMinutes;
  @override
  final String problemDescription;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? endedAt;
  @override
  final int? clientRating;
  @override
  final double? totalFee;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Consultation(id: $id, clientId: $clientId, clientName: $clientName, lawyerId: $lawyerId, lawyerName: $lawyerName, legalTopicName: $legalTopicName, status: $status, type: $type, durationMinutes: $durationMinutes, problemDescription: $problemDescription, startedAt: $startedAt, endedAt: $endedAt, clientRating: $clientRating, totalFee: $totalFee, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsultationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.lawyerId, lawyerId) ||
                other.lawyerId == lawyerId) &&
            (identical(other.lawyerName, lawyerName) ||
                other.lawyerName == lawyerName) &&
            (identical(other.legalTopicName, legalTopicName) ||
                other.legalTopicName == legalTopicName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.problemDescription, problemDescription) ||
                other.problemDescription == problemDescription) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.clientRating, clientRating) ||
                other.clientRating == clientRating) &&
            (identical(other.totalFee, totalFee) ||
                other.totalFee == totalFee) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clientId,
      clientName,
      lawyerId,
      lawyerName,
      legalTopicName,
      status,
      type,
      durationMinutes,
      problemDescription,
      startedAt,
      endedAt,
      clientRating,
      totalFee,
      createdAt);

  /// Create a copy of Consultation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsultationImplCopyWith<_$ConsultationImpl> get copyWith =>
      __$$ConsultationImplCopyWithImpl<_$ConsultationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsultationImplToJson(
      this,
    );
  }
}

abstract class _Consultation implements Consultation {
  const factory _Consultation(
      {required final String id,
      required final String clientId,
      required final String clientName,
      final String? lawyerId,
      final String? lawyerName,
      final String? legalTopicName,
      required final String status,
      required final String type,
      final int? durationMinutes,
      required final String problemDescription,
      final DateTime? startedAt,
      final DateTime? endedAt,
      final int? clientRating,
      final double? totalFee,
      required final DateTime createdAt}) = _$ConsultationImpl;

  factory _Consultation.fromJson(Map<String, dynamic> json) =
      _$ConsultationImpl.fromJson;

  @override
  String get id;
  @override
  String get clientId;
  @override
  String get clientName;
  @override
  String? get lawyerId;
  @override
  String? get lawyerName;
  @override
  String? get legalTopicName;
  @override
  String get status;
  @override
  String get type;
  @override
  int? get durationMinutes;
  @override
  String get problemDescription;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get endedAt;
  @override
  int? get clientRating;
  @override
  double? get totalFee;
  @override
  DateTime get createdAt;

  /// Create a copy of Consultation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsultationImplCopyWith<_$ConsultationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LegalTopic _$LegalTopicFromJson(Map<String, dynamic> json) {
  return _LegalTopic.fromJson(json);
}

/// @nodoc
mixin _$LegalTopic {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  int get consultationCount => throw _privateConstructorUsedError;

  /// Serializes this LegalTopic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LegalTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LegalTopicCopyWith<LegalTopic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LegalTopicCopyWith<$Res> {
  factory $LegalTopicCopyWith(
          LegalTopic value, $Res Function(LegalTopic) then) =
      _$LegalTopicCopyWithImpl<$Res, LegalTopic>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? iconUrl,
      int consultationCount});
}

/// @nodoc
class _$LegalTopicCopyWithImpl<$Res, $Val extends LegalTopic>
    implements $LegalTopicCopyWith<$Res> {
  _$LegalTopicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LegalTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? iconUrl = freezed,
    Object? consultationCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      consultationCount: null == consultationCount
          ? _value.consultationCount
          : consultationCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LegalTopicImplCopyWith<$Res>
    implements $LegalTopicCopyWith<$Res> {
  factory _$$LegalTopicImplCopyWith(
          _$LegalTopicImpl value, $Res Function(_$LegalTopicImpl) then) =
      __$$LegalTopicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? iconUrl,
      int consultationCount});
}

/// @nodoc
class __$$LegalTopicImplCopyWithImpl<$Res>
    extends _$LegalTopicCopyWithImpl<$Res, _$LegalTopicImpl>
    implements _$$LegalTopicImplCopyWith<$Res> {
  __$$LegalTopicImplCopyWithImpl(
      _$LegalTopicImpl _value, $Res Function(_$LegalTopicImpl) _then)
      : super(_value, _then);

  /// Create a copy of LegalTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? iconUrl = freezed,
    Object? consultationCount = null,
  }) {
    return _then(_$LegalTopicImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      consultationCount: null == consultationCount
          ? _value.consultationCount
          : consultationCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LegalTopicImpl implements _LegalTopic {
  const _$LegalTopicImpl(
      {required this.id,
      required this.name,
      this.description,
      this.iconUrl,
      this.consultationCount = 0});

  factory _$LegalTopicImpl.fromJson(Map<String, dynamic> json) =>
      _$$LegalTopicImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? iconUrl;
  @override
  @JsonKey()
  final int consultationCount;

  @override
  String toString() {
    return 'LegalTopic(id: $id, name: $name, description: $description, iconUrl: $iconUrl, consultationCount: $consultationCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LegalTopicImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.consultationCount, consultationCount) ||
                other.consultationCount == consultationCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, iconUrl, consultationCount);

  /// Create a copy of LegalTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LegalTopicImplCopyWith<_$LegalTopicImpl> get copyWith =>
      __$$LegalTopicImplCopyWithImpl<_$LegalTopicImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LegalTopicImplToJson(
      this,
    );
  }
}

abstract class _LegalTopic implements LegalTopic {
  const factory _LegalTopic(
      {required final String id,
      required final String name,
      final String? description,
      final String? iconUrl,
      final int consultationCount}) = _$LegalTopicImpl;

  factory _LegalTopic.fromJson(Map<String, dynamic> json) =
      _$LegalTopicImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get iconUrl;
  @override
  int get consultationCount;

  /// Create a copy of LegalTopic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LegalTopicImplCopyWith<_$LegalTopicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get id => throw _privateConstructorUsedError;
  String get consultationId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get messageType => throw _privateConstructorUsedError;
  String? get attachmentUrl => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  DateTime get sentAt => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) then) =
      _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call(
      {String id,
      String consultationId,
      String senderId,
      String senderName,
      String content,
      String messageType,
      String? attachmentUrl,
      bool isRead,
      DateTime sentAt});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? consultationId = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? content = null,
    Object? messageType = null,
    Object? attachmentUrl = freezed,
    Object? isRead = null,
    Object? sentAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      consultationId: null == consultationId
          ? _value.consultationId
          : consultationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      messageType: null == messageType
          ? _value.messageType
          : messageType // ignore: cast_nullable_to_non_nullable
              as String,
      attachmentUrl: freezed == attachmentUrl
          ? _value.attachmentUrl
          : attachmentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
          _$ChatMessageImpl value, $Res Function(_$ChatMessageImpl) then) =
      __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String consultationId,
      String senderId,
      String senderName,
      String content,
      String messageType,
      String? attachmentUrl,
      bool isRead,
      DateTime sentAt});
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
      _$ChatMessageImpl _value, $Res Function(_$ChatMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? consultationId = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? content = null,
    Object? messageType = null,
    Object? attachmentUrl = freezed,
    Object? isRead = null,
    Object? sentAt = null,
  }) {
    return _then(_$ChatMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      consultationId: null == consultationId
          ? _value.consultationId
          : consultationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      messageType: null == messageType
          ? _value.messageType
          : messageType // ignore: cast_nullable_to_non_nullable
              as String,
      attachmentUrl: freezed == attachmentUrl
          ? _value.attachmentUrl
          : attachmentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl implements _ChatMessage {
  const _$ChatMessageImpl(
      {required this.id,
      required this.consultationId,
      required this.senderId,
      required this.senderName,
      required this.content,
      this.messageType = 'Text',
      this.attachmentUrl,
      this.isRead = false,
      required this.sentAt});

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String consultationId;
  @override
  final String senderId;
  @override
  final String senderName;
  @override
  final String content;
  @override
  @JsonKey()
  final String messageType;
  @override
  final String? attachmentUrl;
  @override
  @JsonKey()
  final bool isRead;
  @override
  final DateTime sentAt;

  @override
  String toString() {
    return 'ChatMessage(id: $id, consultationId: $consultationId, senderId: $senderId, senderName: $senderName, content: $content, messageType: $messageType, attachmentUrl: $attachmentUrl, isRead: $isRead, sentAt: $sentAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.consultationId, consultationId) ||
                other.consultationId == consultationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.attachmentUrl, attachmentUrl) ||
                other.attachmentUrl == attachmentUrl) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, consultationId, senderId,
      senderName, content, messageType, attachmentUrl, isRead, sentAt);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(
      this,
    );
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage(
      {required final String id,
      required final String consultationId,
      required final String senderId,
      required final String senderName,
      required final String content,
      final String messageType,
      final String? attachmentUrl,
      final bool isRead,
      required final DateTime sentAt}) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get consultationId;
  @override
  String get senderId;
  @override
  String get senderName;
  @override
  String get content;
  @override
  String get messageType;
  @override
  String? get attachmentUrl;
  @override
  bool get isRead;
  @override
  DateTime get sentAt;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DocumentTemplate _$DocumentTemplateFromJson(Map<String, dynamic> json) {
  return _DocumentTemplate.fromJson(json);
}

/// @nodoc
mixin _$DocumentTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;
  List<String> get requiredFields => throw _privateConstructorUsedError;
  String? get previewUrl => throw _privateConstructorUsedError;

  /// Serializes this DocumentTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentTemplateCopyWith<DocumentTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentTemplateCopyWith<$Res> {
  factory $DocumentTemplateCopyWith(
          DocumentTemplate value, $Res Function(DocumentTemplate) then) =
      _$DocumentTemplateCopyWithImpl<$Res, DocumentTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String category,
      double fee,
      List<String> requiredFields,
      String? previewUrl});
}

/// @nodoc
class _$DocumentTemplateCopyWithImpl<$Res, $Val extends DocumentTemplate>
    implements $DocumentTemplateCopyWith<$Res> {
  _$DocumentTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = null,
    Object? fee = null,
    Object? requiredFields = null,
    Object? previewUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      requiredFields: null == requiredFields
          ? _value.requiredFields
          : requiredFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      previewUrl: freezed == previewUrl
          ? _value.previewUrl
          : previewUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentTemplateImplCopyWith<$Res>
    implements $DocumentTemplateCopyWith<$Res> {
  factory _$$DocumentTemplateImplCopyWith(_$DocumentTemplateImpl value,
          $Res Function(_$DocumentTemplateImpl) then) =
      __$$DocumentTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String category,
      double fee,
      List<String> requiredFields,
      String? previewUrl});
}

/// @nodoc
class __$$DocumentTemplateImplCopyWithImpl<$Res>
    extends _$DocumentTemplateCopyWithImpl<$Res, _$DocumentTemplateImpl>
    implements _$$DocumentTemplateImplCopyWith<$Res> {
  __$$DocumentTemplateImplCopyWithImpl(_$DocumentTemplateImpl _value,
      $Res Function(_$DocumentTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DocumentTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = null,
    Object? fee = null,
    Object? requiredFields = null,
    Object? previewUrl = freezed,
  }) {
    return _then(_$DocumentTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      requiredFields: null == requiredFields
          ? _value._requiredFields
          : requiredFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      previewUrl: freezed == previewUrl
          ? _value.previewUrl
          : previewUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentTemplateImpl implements _DocumentTemplate {
  const _$DocumentTemplateImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.category,
      required this.fee,
      final List<String> requiredFields = const [],
      this.previewUrl})
      : _requiredFields = requiredFields;

  factory _$DocumentTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String category;
  @override
  final double fee;
  final List<String> _requiredFields;
  @override
  @JsonKey()
  List<String> get requiredFields {
    if (_requiredFields is EqualUnmodifiableListView) return _requiredFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredFields);
  }

  @override
  final String? previewUrl;

  @override
  String toString() {
    return 'DocumentTemplate(id: $id, name: $name, description: $description, category: $category, fee: $fee, requiredFields: $requiredFields, previewUrl: $previewUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            const DeepCollectionEquality()
                .equals(other._requiredFields, _requiredFields) &&
            (identical(other.previewUrl, previewUrl) ||
                other.previewUrl == previewUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, category,
      fee, const DeepCollectionEquality().hash(_requiredFields), previewUrl);

  /// Create a copy of DocumentTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentTemplateImplCopyWith<_$DocumentTemplateImpl> get copyWith =>
      __$$DocumentTemplateImplCopyWithImpl<_$DocumentTemplateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentTemplateImplToJson(
      this,
    );
  }
}

abstract class _DocumentTemplate implements DocumentTemplate {
  const factory _DocumentTemplate(
      {required final String id,
      required final String name,
      final String? description,
      required final String category,
      required final double fee,
      final List<String> requiredFields,
      final String? previewUrl}) = _$DocumentTemplateImpl;

  factory _DocumentTemplate.fromJson(Map<String, dynamic> json) =
      _$DocumentTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get category;
  @override
  double get fee;
  @override
  List<String> get requiredFields;
  @override
  String? get previewUrl;

  /// Create a copy of DocumentTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentTemplateImplCopyWith<_$DocumentTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeneratedDocument _$GeneratedDocumentFromJson(Map<String, dynamic> json) {
  return _GeneratedDocument.fromJson(json);
}

/// @nodoc
mixin _$GeneratedDocument {
  String get id => throw _privateConstructorUsedError;
  String get templateId => throw _privateConstructorUsedError;
  String get templateName => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get documentUrl => throw _privateConstructorUsedError;
  double? get fee => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this GeneratedDocument to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeneratedDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeneratedDocumentCopyWith<GeneratedDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratedDocumentCopyWith<$Res> {
  factory $GeneratedDocumentCopyWith(
          GeneratedDocument value, $Res Function(GeneratedDocument) then) =
      _$GeneratedDocumentCopyWithImpl<$Res, GeneratedDocument>;
  @useResult
  $Res call(
      {String id,
      String templateId,
      String templateName,
      String userId,
      String status,
      String? documentUrl,
      double? fee,
      DateTime createdAt,
      DateTime? completedAt});
}

/// @nodoc
class _$GeneratedDocumentCopyWithImpl<$Res, $Val extends GeneratedDocument>
    implements $GeneratedDocumentCopyWith<$Res> {
  _$GeneratedDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeneratedDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? templateId = null,
    Object? templateName = null,
    Object? userId = null,
    Object? status = null,
    Object? documentUrl = freezed,
    Object? fee = freezed,
    Object? createdAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: null == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      templateName: null == templateName
          ? _value.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      documentUrl: freezed == documentUrl
          ? _value.documentUrl
          : documentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeneratedDocumentImplCopyWith<$Res>
    implements $GeneratedDocumentCopyWith<$Res> {
  factory _$$GeneratedDocumentImplCopyWith(_$GeneratedDocumentImpl value,
          $Res Function(_$GeneratedDocumentImpl) then) =
      __$$GeneratedDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String templateId,
      String templateName,
      String userId,
      String status,
      String? documentUrl,
      double? fee,
      DateTime createdAt,
      DateTime? completedAt});
}

/// @nodoc
class __$$GeneratedDocumentImplCopyWithImpl<$Res>
    extends _$GeneratedDocumentCopyWithImpl<$Res, _$GeneratedDocumentImpl>
    implements _$$GeneratedDocumentImplCopyWith<$Res> {
  __$$GeneratedDocumentImplCopyWithImpl(_$GeneratedDocumentImpl _value,
      $Res Function(_$GeneratedDocumentImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeneratedDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? templateId = null,
    Object? templateName = null,
    Object? userId = null,
    Object? status = null,
    Object? documentUrl = freezed,
    Object? fee = freezed,
    Object? createdAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(_$GeneratedDocumentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: null == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      templateName: null == templateName
          ? _value.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      documentUrl: freezed == documentUrl
          ? _value.documentUrl
          : documentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneratedDocumentImpl implements _GeneratedDocument {
  const _$GeneratedDocumentImpl(
      {required this.id,
      required this.templateId,
      required this.templateName,
      required this.userId,
      required this.status,
      this.documentUrl,
      this.fee,
      required this.createdAt,
      this.completedAt});

  factory _$GeneratedDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneratedDocumentImplFromJson(json);

  @override
  final String id;
  @override
  final String templateId;
  @override
  final String templateName;
  @override
  final String userId;
  @override
  final String status;
  @override
  final String? documentUrl;
  @override
  final double? fee;
  @override
  final DateTime createdAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'GeneratedDocument(id: $id, templateId: $templateId, templateName: $templateName, userId: $userId, status: $status, documentUrl: $documentUrl, fee: $fee, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratedDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.templateName, templateName) ||
                other.templateName == templateName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.documentUrl, documentUrl) ||
                other.documentUrl == documentUrl) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, templateId, templateName,
      userId, status, documentUrl, fee, createdAt, completedAt);

  /// Create a copy of GeneratedDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratedDocumentImplCopyWith<_$GeneratedDocumentImpl> get copyWith =>
      __$$GeneratedDocumentImplCopyWithImpl<_$GeneratedDocumentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneratedDocumentImplToJson(
      this,
    );
  }
}

abstract class _GeneratedDocument implements GeneratedDocument {
  const factory _GeneratedDocument(
      {required final String id,
      required final String templateId,
      required final String templateName,
      required final String userId,
      required final String status,
      final String? documentUrl,
      final double? fee,
      required final DateTime createdAt,
      final DateTime? completedAt}) = _$GeneratedDocumentImpl;

  factory _GeneratedDocument.fromJson(Map<String, dynamic> json) =
      _$GeneratedDocumentImpl.fromJson;

  @override
  String get id;
  @override
  String get templateId;
  @override
  String get templateName;
  @override
  String get userId;
  @override
  String get status;
  @override
  String? get documentUrl;
  @override
  double? get fee;
  @override
  DateTime get createdAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of GeneratedDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeneratedDocumentImplCopyWith<_$GeneratedDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) {
  return _PaymentMethod.fromJson(json);
}

/// @nodoc
mixin _$PaymentMethod {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PaymentMethod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentMethodCopyWith<PaymentMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodCopyWith<$Res> {
  factory $PaymentMethodCopyWith(
          PaymentMethod value, $Res Function(PaymentMethod) then) =
      _$PaymentMethodCopyWithImpl<$Res, PaymentMethod>;
  @useResult
  $Res call(
      {String id,
      String type,
      String provider,
      String number,
      String name,
      bool isDefault,
      DateTime createdAt});
}

/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res, $Val extends PaymentMethod>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? provider = null,
    Object? number = null,
    Object? name = null,
    Object? isDefault = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentMethodImplCopyWith<$Res>
    implements $PaymentMethodCopyWith<$Res> {
  factory _$$PaymentMethodImplCopyWith(
          _$PaymentMethodImpl value, $Res Function(_$PaymentMethodImpl) then) =
      __$$PaymentMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String provider,
      String number,
      String name,
      bool isDefault,
      DateTime createdAt});
}

/// @nodoc
class __$$PaymentMethodImplCopyWithImpl<$Res>
    extends _$PaymentMethodCopyWithImpl<$Res, _$PaymentMethodImpl>
    implements _$$PaymentMethodImplCopyWith<$Res> {
  __$$PaymentMethodImplCopyWithImpl(
      _$PaymentMethodImpl _value, $Res Function(_$PaymentMethodImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? provider = null,
    Object? number = null,
    Object? name = null,
    Object? isDefault = null,
    Object? createdAt = null,
  }) {
    return _then(_$PaymentMethodImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentMethodImpl implements _PaymentMethod {
  const _$PaymentMethodImpl(
      {required this.id,
      required this.type,
      required this.provider,
      required this.number,
      required this.name,
      this.isDefault = false,
      required this.createdAt});

  factory _$PaymentMethodImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentMethodImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String provider;
  @override
  final String number;
  @override
  final String name;
  @override
  @JsonKey()
  final bool isDefault;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'PaymentMethod(id: $id, type: $type, provider: $provider, number: $number, name: $name, isDefault: $isDefault, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, provider, number, name, isDefault, createdAt);

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      __$$PaymentMethodImplCopyWithImpl<_$PaymentMethodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentMethodImplToJson(
      this,
    );
  }
}

abstract class _PaymentMethod implements PaymentMethod {
  const factory _PaymentMethod(
      {required final String id,
      required final String type,
      required final String provider,
      required final String number,
      required final String name,
      final bool isDefault,
      required final DateTime createdAt}) = _$PaymentMethodImpl;

  factory _PaymentMethod.fromJson(Map<String, dynamic> json) =
      _$PaymentMethodImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get provider;
  @override
  String get number;
  @override
  String get name;
  @override
  bool get isDefault;
  @override
  DateTime get createdAt;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
