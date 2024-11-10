// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoadResult<Key, Item> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Key key, List<Item> items, Key? prependKey, Key? appendKey)
        success,
    required TResult Function(Exception? error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            Key key, List<Item> items, Key? prependKey, Key? appendKey)?
        success,
    TResult? Function(Exception? error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Key key, List<Item> items, Key? prependKey, Key? appendKey)?
        success,
    TResult Function(Exception? error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<Key, Item> value) success,
    required TResult Function(Failure<Key, Item> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success<Key, Item> value)? success,
    TResult? Function(Failure<Key, Item> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<Key, Item> value)? success,
    TResult Function(Failure<Key, Item> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadResultCopyWith<Key, Item, $Res> {
  factory $LoadResultCopyWith(LoadResult<Key, Item> value,
          $Res Function(LoadResult<Key, Item>) then) =
      _$LoadResultCopyWithImpl<Key, Item, $Res, LoadResult<Key, Item>>;
}

/// @nodoc
class _$LoadResultCopyWithImpl<Key, Item, $Res,
        $Val extends LoadResult<Key, Item>>
    implements $LoadResultCopyWith<Key, Item, $Res> {
  _$LoadResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoadResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<Key, Item, $Res> {
  factory _$$SuccessImplCopyWith(_$SuccessImpl<Key, Item> value,
          $Res Function(_$SuccessImpl<Key, Item>) then) =
      __$$SuccessImplCopyWithImpl<Key, Item, $Res>;
  @useResult
  $Res call({Key key, List<Item> items, Key? prependKey, Key? appendKey});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<Key, Item, $Res>
    extends _$LoadResultCopyWithImpl<Key, Item, $Res, _$SuccessImpl<Key, Item>>
    implements _$$SuccessImplCopyWith<Key, Item, $Res> {
  __$$SuccessImplCopyWithImpl(_$SuccessImpl<Key, Item> _value,
      $Res Function(_$SuccessImpl<Key, Item>) _then)
      : super(_value, _then);

  /// Create a copy of LoadResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? items = null,
    Object? prependKey = freezed,
    Object? appendKey = freezed,
  }) {
    return _then(_$SuccessImpl<Key, Item>(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as Key,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
      prependKey: freezed == prependKey
          ? _value.prependKey
          : prependKey // ignore: cast_nullable_to_non_nullable
              as Key?,
      appendKey: freezed == appendKey
          ? _value.appendKey
          : appendKey // ignore: cast_nullable_to_non_nullable
              as Key?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl<Key, Item> implements Success<Key, Item> {
  const _$SuccessImpl(
      {required this.key,
      required final List<Item> items,
      this.prependKey,
      this.appendKey})
      : _items = items;

  @override
  final Key key;
  final List<Item> _items;
  @override
  List<Item> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final Key? prependKey;
  @override
  final Key? appendKey;

  @override
  String toString() {
    return 'LoadResult<$Key, $Item>.success(key: $key, items: $items, prependKey: $prependKey, appendKey: $appendKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl<Key, Item> &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other.prependKey, prependKey) &&
            const DeepCollectionEquality().equals(other.appendKey, appendKey));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(prependKey),
      const DeepCollectionEquality().hash(appendKey));

  /// Create a copy of LoadResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<Key, Item, _$SuccessImpl<Key, Item>> get copyWith =>
      __$$SuccessImplCopyWithImpl<Key, Item, _$SuccessImpl<Key, Item>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Key key, List<Item> items, Key? prependKey, Key? appendKey)
        success,
    required TResult Function(Exception? error) failure,
  }) {
    return success(key, items, prependKey, appendKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            Key key, List<Item> items, Key? prependKey, Key? appendKey)?
        success,
    TResult? Function(Exception? error)? failure,
  }) {
    return success?.call(key, items, prependKey, appendKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Key key, List<Item> items, Key? prependKey, Key? appendKey)?
        success,
    TResult Function(Exception? error)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(key, items, prependKey, appendKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<Key, Item> value) success,
    required TResult Function(Failure<Key, Item> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success<Key, Item> value)? success,
    TResult? Function(Failure<Key, Item> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<Key, Item> value)? success,
    TResult Function(Failure<Key, Item> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success<Key, Item> implements LoadResult<Key, Item> {
  const factory Success(
      {required final Key key,
      required final List<Item> items,
      final Key? prependKey,
      final Key? appendKey}) = _$SuccessImpl<Key, Item>;

  Key get key;
  List<Item> get items;
  Key? get prependKey;
  Key? get appendKey;

  /// Create a copy of LoadResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<Key, Item, _$SuccessImpl<Key, Item>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<Key, Item, $Res> {
  factory _$$FailureImplCopyWith(_$FailureImpl<Key, Item> value,
          $Res Function(_$FailureImpl<Key, Item>) then) =
      __$$FailureImplCopyWithImpl<Key, Item, $Res>;
  @useResult
  $Res call({Exception? error});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<Key, Item, $Res>
    extends _$LoadResultCopyWithImpl<Key, Item, $Res, _$FailureImpl<Key, Item>>
    implements _$$FailureImplCopyWith<Key, Item, $Res> {
  __$$FailureImplCopyWithImpl(_$FailureImpl<Key, Item> _value,
      $Res Function(_$FailureImpl<Key, Item>) _then)
      : super(_value, _then);

  /// Create a copy of LoadResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$FailureImpl<Key, Item>(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc

class _$FailureImpl<Key, Item> implements Failure<Key, Item> {
  const _$FailureImpl({this.error});

  @override
  final Exception? error;

  @override
  String toString() {
    return 'LoadResult<$Key, $Item>.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl<Key, Item> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of LoadResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<Key, Item, _$FailureImpl<Key, Item>> get copyWith =>
      __$$FailureImplCopyWithImpl<Key, Item, _$FailureImpl<Key, Item>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Key key, List<Item> items, Key? prependKey, Key? appendKey)
        success,
    required TResult Function(Exception? error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            Key key, List<Item> items, Key? prependKey, Key? appendKey)?
        success,
    TResult? Function(Exception? error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Key key, List<Item> items, Key? prependKey, Key? appendKey)?
        success,
    TResult Function(Exception? error)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<Key, Item> value) success,
    required TResult Function(Failure<Key, Item> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success<Key, Item> value)? success,
    TResult? Function(Failure<Key, Item> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<Key, Item> value)? success,
    TResult Function(Failure<Key, Item> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class Failure<Key, Item> implements LoadResult<Key, Item> {
  const factory Failure({final Exception? error}) = _$FailureImpl<Key, Item>;

  Exception? get error;

  /// Create a copy of LoadResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<Key, Item, _$FailureImpl<Key, Item>> get copyWith =>
      throw _privateConstructorUsedError;
}
