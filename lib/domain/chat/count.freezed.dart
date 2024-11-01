// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'count.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageCount _$MessageCountFromJson(Map<String, dynamic> json) {
  return _MessageCount.fromJson(json);
}

/// @nodoc
mixin _$MessageCount {
  @JsonKey(name: "count")
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: "last_page")
  int get lastPage => throw _privateConstructorUsedError;

  /// Serializes this MessageCount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCountCopyWith<MessageCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCountCopyWith<$Res> {
  factory $MessageCountCopyWith(
          MessageCount value, $Res Function(MessageCount) then) =
      _$MessageCountCopyWithImpl<$Res, MessageCount>;
  @useResult
  $Res call(
      {@JsonKey(name: "count") int count,
      @JsonKey(name: "last_page") int lastPage});
}

/// @nodoc
class _$MessageCountCopyWithImpl<$Res, $Val extends MessageCount>
    implements $MessageCountCopyWith<$Res> {
  _$MessageCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? lastPage = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageCountImplCopyWith<$Res>
    implements $MessageCountCopyWith<$Res> {
  factory _$$MessageCountImplCopyWith(
          _$MessageCountImpl value, $Res Function(_$MessageCountImpl) then) =
      __$$MessageCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "count") int count,
      @JsonKey(name: "last_page") int lastPage});
}

/// @nodoc
class __$$MessageCountImplCopyWithImpl<$Res>
    extends _$MessageCountCopyWithImpl<$Res, _$MessageCountImpl>
    implements _$$MessageCountImplCopyWith<$Res> {
  __$$MessageCountImplCopyWithImpl(
      _$MessageCountImpl _value, $Res Function(_$MessageCountImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? lastPage = null,
  }) {
    return _then(_$MessageCountImpl(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageCountImpl implements _MessageCount {
  const _$MessageCountImpl(
      {@JsonKey(name: "count") required this.count,
      @JsonKey(name: "last_page") required this.lastPage});

  factory _$MessageCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageCountImplFromJson(json);

  @override
  @JsonKey(name: "count")
  final int count;
  @override
  @JsonKey(name: "last_page")
  final int lastPage;

  @override
  String toString() {
    return 'MessageCount(count: $count, lastPage: $lastPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageCountImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, count, lastPage);

  /// Create a copy of MessageCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageCountImplCopyWith<_$MessageCountImpl> get copyWith =>
      __$$MessageCountImplCopyWithImpl<_$MessageCountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageCountImplToJson(
      this,
    );
  }
}

abstract class _MessageCount implements MessageCount {
  const factory _MessageCount(
          {@JsonKey(name: "count") required final int count,
          @JsonKey(name: "last_page") required final int lastPage}) =
      _$MessageCountImpl;

  factory _MessageCount.fromJson(Map<String, dynamic> json) =
      _$MessageCountImpl.fromJson;

  @override
  @JsonKey(name: "count")
  int get count;
  @override
  @JsonKey(name: "last_page")
  int get lastPage;

  /// Create a copy of MessageCount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageCountImplCopyWith<_$MessageCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
