import 'package:async/async.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/chat/chat_repository.dart';
import '../../domain/chat/message.dart';

const _messagePollingDelay = Duration(seconds: 2);

class ChatNotifier extends StateNotifier<List<Message>> {
  final ChatRepository _repository;
  late CancelableOperation<void> _messagePollingTask;

  ChatNotifier(this._repository) : super([]) {
    _messagePollingTask = CancelableOperation.fromFuture(_launchMessagesPolling());
  }

  void loadMessages() async {
    state = await _repository.getMessages().then(
      (res) => res.fold(
        (_) => state,
        (x) => x,
      )
    );
  }

  Future<void> _launchMessagesPolling() async {
    while (true) {
      loadMessages();
      await Future.delayed(_messagePollingDelay);
    }
  }

  void sendMessage({
    required String message,
    required void Function() onSuccess,
    void Function()? onError,
  }) async => (await _repository.sendMessage(message)).fold(
        (_) { if (onError != null) onError(); },
        (_) { onSuccess(); },
  );

  @override
  void dispose() async {
    super.dispose();
    await _messagePollingTask.cancel();
  }
}
