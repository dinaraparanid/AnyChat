import 'package:any_chat/domain/chat/page.dart';

abstract class ChatRepository {
  Future<MessagePage> getMessagePage({
    required int perPage,
    int? lastMessageId,
  });

  Future<void> publishMessage(String message);

  Future<int> get totalMessageCount;

  Future<int?> get lastMessageId;
}
