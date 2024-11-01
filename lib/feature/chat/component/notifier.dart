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
    _init();
  }

  Future<void> _init() async {
    final position = await _repository.chatPosition;
    final offset = await _repository.chatOffset;
    final countResponse = await _repository.messageCount;

    state = state.copyWith(
      scrollPosition: position ?? ChatState.undefinedPosition,
      offset: offset ?? 0,
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

  Future<void> refresh() => pagingSource.refresh();

  Future<void> updateChatPosition(int position) async {
    await _repository.storeChatPosition(position);
    state = state.copyWith(scrollPosition: position);
  }

  Future<void> updateChatOffset(double offset) async {
    await _repository.storeChatOffset(offset);
    state = state.copyWith(offset: offset);
  }

  Future<void> updateChatPage(int page) => _repository.storeCurrentPage(page);
}
