import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/feature/chat/component/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_paging/super_paging.dart';

export 'state.dart';

final class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository _repository;
  final Pager<int, Message> pager;

  ChatNotifier(ChatRepository repository) :
    _repository = repository,
    pager = repository.pager,
    super(const ChatState()) {
    _init();
  }

  Future<void> _init() async {
    final position = await _repository.chatPosition;
    final countResponse = await _repository.messageCount;

    state = state.copyWith(
      scrollPosition: position ?? ChatState.undefinedPosition,
      totalCount: countResponse.map((r) => r.count).getOrElse((_) => 0),
    );
  }

  Future<void> sendMessage({
    required String message,
    required void Function() onSuccess,
    void Function()? onError,
  }) async => (await _repository.sendMessage(message)).fold(
    (_) { if (onError != null) onError(); },
    (_) { onSuccess(); },
  );

  Future<void> refresh() => pager.refresh();

  Future<void> updateChatPosition(int position) async {
    await _repository.storeChatPosition(position);
    state = state.copyWith(scrollPosition: position);
  }

  Future<void> updateChatPage(int page) => _repository.storeCurrentPage(page);
}
