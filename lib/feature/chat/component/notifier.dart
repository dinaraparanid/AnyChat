import 'package:any_chat/core/config.dart';
import 'package:any_chat/domain/chat/pager.dart';
import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/feature/chat/component/page_data.dart';
import 'package:any_chat/feature/chat/component/state.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'state.dart';

final class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository _repository;

  ChatNotifier(ChatRepository repository) :
    _repository = repository,
    super(ChatState.initial()) {
    _init();
  }

  Future<void> _init() async {
    final currentPage = (await _repository.currentPage)
      ?? (await _repository.messageCount)
        .map((x) => x.lastPage)
        .getOrElse((_) => AppConfig.chatFirstPage);

    await updateChatPage(currentPage);
  }

  Future<void> sendMessage({
    required String message,
    required void Function() onSuccess,
    void Function()? onError,
  }) async => (await _repository.sendMessage(message)).fold(
    (_) { if (onError != null) onError(); },
    (_) { onSuccess(); },
  );

  Future<void> refresh() => _loadChatPage();

  Future<void> updateChatPage(int page) async {
    final hasPage = state.pages.containsKey(page)
      ? true : await _loadChatPage(page);

    if (!hasPage) return;

    _repository.storeCurrentPage(page);

    final data = state.pages[page]!;
    final prev = data.previousPage;
    final next = data.nextPage;

    if (prev != null && state.mustLoadPage(prev)) {
      await _loadChatPage(prev);
    }

    if (next != null && state.mustLoadPage(next)) {
      await _loadChatPage(next);
    }

    state = state.copyWith(currentPage: page);
  }

  Future<void> loadNextPage() => _loadChatPage(state.nextPage);
  Future<void> loadPreviousPage() => _loadChatPage(state.previousPage);

  Future<bool> _loadChatPage([int? page]) async {
    switch (await _repository.pager.load(key: page)) {
      case Success<int, Message>(
        key: final page,
        prependKey: final prev,
        appendKey: final next,
        items: final items,
      ):
        final pageData = PageData(
          messages: IList(items),
          previousPage: prev,
          nextPage: next,
        );

        state = state.copyWith(
          pages: state.pages.update(
            page,
            (_) => pageData,
            ifAbsent: () => pageData,
          ),
          currentError: null,
        );
        return true;

      case Failure<int, Message>(error: final e):
        state = state.copyWith(currentError: e);
        return false;
    }
  }
}
