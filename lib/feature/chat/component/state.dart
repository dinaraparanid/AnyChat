import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState({
    int? currentMessageId,
    int? lastMessageId,
    required bool isScrollDownButtonVisible,
  }) = _ChatState;

  static const undefinedPosition = -1;
}
