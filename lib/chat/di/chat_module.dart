import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import '../presentation/notifier.dart';
import '../../../domain/chat/message.dart';

extension ChatModule on GetIt {
  void registerChatModule() => registerLazySingleton(
      () => StateNotifierProvider<ChatNotifier, List<Message>>(
          (_) => ChatNotifier(this())
      )
  );
}
