// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatState {
  int? get currentMessageId => throw _privateConstructorUsedError;
  int? get lastMessageId => throw _privateConstructorUsedError;
  bool get isScrollDownButtonVisible => throw _privateConstructorUsedError;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatStateCopyWith<ChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
  @useResult
  $Res call(
      {int? currentMessageId,
      int? lastMessageId,
      bool isScrollDownButtonVisible});
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentMessageId = freezed,
    Object? lastMessageId = freezed,
    Object? isScrollDownButtonVisible = null,
  }) {
    return _then(_value.copyWith(
      currentMessageId: freezed == currentMessageId
          ? _value.currentMessageId
          : currentMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      lastMessageId: freezed == lastMessageId
          ? _value.lastMessageId
          : lastMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      isScrollDownButtonVisible: null == isScrollDownButtonVisible
          ? _value.isScrollDownButtonVisible
          : isScrollDownButtonVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatStateImplCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory _$$ChatStateImplCopyWith(
          _$ChatStateImpl value, $Res Function(_$ChatStateImpl) then) =
      __$$ChatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? currentMessageId,
      int? lastMessageId,
      bool isScrollDownButtonVisible});
}

/// @nodoc
class __$$ChatStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateImpl>
    implements _$$ChatStateImplCopyWith<$Res> {
  __$$ChatStateImplCopyWithImpl(
      _$ChatStateImpl _value, $Res Function(_$ChatStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentMessageId = freezed,
    Object? lastMessageId = freezed,
    Object? isScrollDownButtonVisible = null,
  }) {
    return _then(_$ChatStateImpl(
      currentMessageId: freezed == currentMessageId
          ? _value.currentMessageId
          : currentMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      lastMessageId: freezed == lastMessageId
          ? _value.lastMessageId
          : lastMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      isScrollDownButtonVisible: null == isScrollDownButtonVisible
          ? _value.isScrollDownButtonVisible
          : isScrollDownButtonVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ChatStateImpl implements _ChatState {
  const _$ChatStateImpl(
      {this.currentMessageId,
      this.lastMessageId,
      required this.isScrollDownButtonVisible});

  @override
  final int? currentMessageId;
  @override
  final int? lastMessageId;
  @override
  final bool isScrollDownButtonVisible;

  @override
  String toString() {
    return 'ChatState(currentMessageId: $currentMessageId, lastMessageId: $lastMessageId, isScrollDownButtonVisible: $isScrollDownButtonVisible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateImpl &&
            (identical(other.currentMessageId, currentMessageId) ||
                other.currentMessageId == currentMessageId) &&
            (identical(other.lastMessageId, lastMessageId) ||
                other.lastMessageId == lastMessageId) &&
            (identical(other.isScrollDownButtonVisible,
                    isScrollDownButtonVisible) ||
                other.isScrollDownButtonVisible == isScrollDownButtonVisible));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, currentMessageId, lastMessageId, isScrollDownButtonVisible);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      __$$ChatStateImplCopyWithImpl<_$ChatStateImpl>(this, _$identity);
}

abstract class _ChatState implements ChatState {
  const factory _ChatState(
      {final int? currentMessageId,
      final int? lastMessageId,
      required final bool isScrollDownButtonVisible}) = _$ChatStateImpl;

  @override
  int? get currentMessageId;
  @override
  int? get lastMessageId;
  @override
  bool get isScrollDownButtonVisible;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
