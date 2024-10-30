import 'package:any_chat/domain/chat/page.dart';

abstract class ChatRepository {
  Future<MessagePage> getMessagePage({
    required int page,
    required int perPage,
  });

  Future<void> publishMessage(String message);

  Future<int> get totalMessageCount;
}
