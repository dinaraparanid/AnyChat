import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/feature/chat/component/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/rxdart.dart';
import 'package:super_paging/super_paging.dart';

export 'state.dart';

final class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository _repository;
  final Pager<int, Message> pager;

  ChatNotifier(ChatRepository repository) :
    _repository = repository,
    pager = repository.pager,
    super(const ChatState(isScrollDownButtonVisible: false)) {
    _init();
  }

  void _init() => CombineLatestStream.combine2(
    _repository.lastMessageIdStream,
    _repository.chatPositionIdStream,
      (lastMessageId, chatPositionId) => state.copyWith(
      currentMessageId: chatPositionId ?? ChatState.undefinedPosition,
      lastMessageId: lastMessageId,
    ),
  ).listen((newState) => state = newState);

  Future<void> sendMessage({
    required String message,
    required void Function() onSuccess,
    void Function()? onError,
  }) async => (await _repository.sendMessage(message)).fold(
    (_) { if (onError != null) onError(); },
    (_) { onSuccess(); },
  );

  Future<void> refresh() => pager.refresh();

  Future<void> updateChatPosition(int messageId) async {
    await _repository.storeChatPositionId(messageId);
    state = state.copyWith(currentMessageId: messageId);
  }

  bool isFirstMessageForDate(int messageIndex) {
    if (messageIndex == 0) return true;

    final item = pager.items.elementAtOrNull(messageIndex);
    if (item == null) throw RangeError.index(messageIndex, pager.items);

    final prevItem = pager.items.elementAtOrNull(messageIndex - 1);
    if (prevItem == null) throw RangeError.index(messageIndex - 1, pager.items);

    return !item.createdAt.eqvDay(prevItem.createdAt);
  }

  void updateScrollDownButtonVisibility({required Set<int> visibleIds}) =>
    state = state.copyWith(
      isScrollDownButtonVisible: !visibleIds.contains(state.lastMessageId),
    );
}
