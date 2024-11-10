import 'package:any_chat/domain/chat/message.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_data.freezed.dart';

@freezed
abstract class PageData with _$PageData {
  const factory PageData({
    required IList<Message> messages,
    int? previousPage,
    int? nextPage,
  }) = _PageData;
}
