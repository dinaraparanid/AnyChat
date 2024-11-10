import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class LoadResult<Key, Item> with _$LoadResult {
  const factory LoadResult.success({
    required Key key,
    required List<Item> items,
    Key? prependKey,
    Key? appendKey,
  }) = Success;

  const factory LoadResult.failure({Exception? error}) = Failure;
}
