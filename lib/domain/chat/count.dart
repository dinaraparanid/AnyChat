import 'package:freezed_annotation/freezed_annotation.dart';

part 'count.freezed.dart';
part 'count.g.dart';

@freezed
abstract class MessageCount with _$MessageCount {
  const factory MessageCount({
    @JsonKey(name: "count") required int count,
    @JsonKey(name: "last_page") required int lastPage,
  }) = _MessageCount;

  factory MessageCount.fromJson(Map<String, Object?> json) =>
    _$MessageCountFromJson(json);
}
