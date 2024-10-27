import 'dart:async';
import 'package:any_chat/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _messagePollingDelay = Duration(seconds: 2);

class ChatNotifier extends StateNotifier<List<Message>> {
  final ChatRepository _repository;
  Timer? _timer;

  ChatNotifier(this._repository) : super([]) {
    _timer?.cancel();
    _timer = Timer.periodic(_messagePollingDelay, (_) => loadMessages());
  }

  Future<void> loadMessages() async {
    state = await _repository.getMessages().then(
      (res) => res.fold(
        (_) => state,
        (x) => x,
      )
    );
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
    _timer?.cancel();
    _timer = null;
  }
}
