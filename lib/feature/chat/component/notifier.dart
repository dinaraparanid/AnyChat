import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/feature/chat/component/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paging_view/paging_view.dart';

export 'state.dart';

final class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository _repository;
  final DataSource<int, Message> pagingSource;

  ChatNotifier(ChatRepository repository) :
    _repository = repository,
    pagingSource = repository.pagingSource,
    super(const ChatState()) {
    repository.chatPosition.then((pos) =>
      repository.messageCount.then((countResponse) =>
        state = state.copyWith(
          scrollPosition: pos ?? ChatState.undefinedPosition,
          totalCount: countResponse.map((r) => r.count).getOrElse((_) => 0),
        )
      )
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

  Future<void> refresh() => pagingSource.refresh();

  Future<void> updateChatPosition(int position) async {
    await _repository.storeChatPosition(position);
    state = state.copyWith(scrollPosition: position);
  }

  Future<void> updateChatPage(int page) => _repository.storeCurrentPage(page);
}
