import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'text') required String text,
    @JsonKey(name: 'timestamp') required int timestamp,
  }) = _Message;

  factory Message.fromJson(Map<String, Object?> json) =>
    _$MessageFromJson(json);
}

extension Properties on Message {
  DateTime get createdAt => DateTime
      .fromMillisecondsSinceEpoch(timestamp, isUtc: true)
      .toLocal();
}
