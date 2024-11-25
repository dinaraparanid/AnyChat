import 'package:any_chat/domain/chat/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page.freezed.dart';
part 'page.g.dart';

@freezed
abstract class MessagePage with _$MessagePage {
  const factory MessagePage({
    required int perPage,
    required List<Message> messages,
    int? next,
    int? previous,
  }) = _MessagePage;

  factory MessagePage.fromJson(Map<String, Object?> json) =>
    _$MessagePageFromJson(json);
}
