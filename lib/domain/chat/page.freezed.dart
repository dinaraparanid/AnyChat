// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessagePage _$MessagePageFromJson(Map<String, dynamic> json) {
  return _MessagePage.fromJson(json);
}

/// @nodoc
mixin _$MessagePage {
  int get perPage => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  int? get next => throw _privateConstructorUsedError;
  int? get previous => throw _privateConstructorUsedError;

  /// Serializes this MessagePage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessagePage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessagePageCopyWith<MessagePage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagePageCopyWith<$Res> {
  factory $MessagePageCopyWith(
          MessagePage value, $Res Function(MessagePage) then) =
      _$MessagePageCopyWithImpl<$Res, MessagePage>;
  @useResult
  $Res call({int perPage, List<Message> messages, int? next, int? previous});
}

/// @nodoc
class _$MessagePageCopyWithImpl<$Res, $Val extends MessagePage>
    implements $MessagePageCopyWith<$Res> {
  _$MessagePageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessagePage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? perPage = null,
    Object? messages = null,
    Object? next = freezed,
    Object? previous = freezed,
  }) {
    return _then(_value.copyWith(
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as int?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessagePageImplCopyWith<$Res>
    implements $MessagePageCopyWith<$Res> {
  factory _$$MessagePageImplCopyWith(
          _$MessagePageImpl value, $Res Function(_$MessagePageImpl) then) =
      __$$MessagePageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int perPage, List<Message> messages, int? next, int? previous});
}

/// @nodoc
class __$$MessagePageImplCopyWithImpl<$Res>
    extends _$MessagePageCopyWithImpl<$Res, _$MessagePageImpl>
    implements _$$MessagePageImplCopyWith<$Res> {
  __$$MessagePageImplCopyWithImpl(
      _$MessagePageImpl _value, $Res Function(_$MessagePageImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagePage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? perPage = null,
    Object? messages = null,
    Object? next = freezed,
    Object? previous = freezed,
  }) {
    return _then(_$MessagePageImpl(
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as int?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessagePageImpl implements _MessagePage {
  const _$MessagePageImpl(
      {required this.perPage,
      required final List<Message> messages,
      this.next,
      this.previous})
      : _messages = messages;

  factory _$MessagePageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessagePageImplFromJson(json);

  @override
  final int perPage;
  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final int? next;
  @override
  final int? previous;

  @override
  String toString() {
    return 'MessagePage(perPage: $perPage, messages: $messages, next: $next, previous: $previous)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagePageImpl &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, perPage,
      const DeepCollectionEquality().hash(_messages), next, previous);

  /// Create a copy of MessagePage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagePageImplCopyWith<_$MessagePageImpl> get copyWith =>
      __$$MessagePageImplCopyWithImpl<_$MessagePageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessagePageImplToJson(
      this,
    );
  }
}

abstract class _MessagePage implements MessagePage {
  const factory _MessagePage(
      {required final int perPage,
      required final List<Message> messages,
      final int? next,
      final int? previous}) = _$MessagePageImpl;

  factory _MessagePage.fromJson(Map<String, dynamic> json) =
      _$MessagePageImpl.fromJson;

  @override
  int get perPage;
  @override
  List<Message> get messages;
  @override
  int? get next;
  @override
  int? get previous;

  /// Create a copy of MessagePage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessagePageImplCopyWith<_$MessagePageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
