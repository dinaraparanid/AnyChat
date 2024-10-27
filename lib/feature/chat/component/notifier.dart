import 'package:any_chat/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paging_view/paging_view.dart';

final class ChatNotifier extends StateNotifier<void> {
  final ChatRepository _repository;
  final DataSource<int, Message> pagingSource;

  ChatNotifier(ChatRepository repository) :
    _repository = repository,
    pagingSource = repository.pagingSource,
    super(null);

  void sendMessage({
    required String message,
    required void Function() onSuccess,
    void Function()? onError,
  }) async => (await _repository.sendMessage(message)).fold(
    (_) { if (onError != null) onError(); },
    (_) { onSuccess(); },
  );

  Future<void> refresh() => pagingSource.refresh();
}
