import 'package:any_chat/domain/chat/message.dart';
import 'package:any_chat/domain/chat/page.dart';
import 'package:any_chat/server/data/sqflite/chat.dart';
import 'package:any_chat/server/data/sqflite/db.dart';
import 'package:any_chat/server/domain/chat/repository.dart';
import 'package:any_chat/utils/functional.dart';
import 'package:sqlite_async/sqlite_async.dart';

final class ChatRepositoryImpl extends ChatRepository {
  final ServerDatabaseProvider _dbProvider;
  ChatRepositoryImpl(this._dbProvider);

  SqliteDatabase get _db => _dbProvider.db;

  @override
  Future<MessagePage> getMessagePage({
    required int perPage,
    int? lastMessageId,
  }) => _db.writeTransaction((txn) async {
    final messagesTask = lastMessageId?.let((id) => txn.fetchMessagePage(
      lastMessageId: id,
      perPage: perPage,
    ));

    final prevPageTask = lastMessageId?.let((id) =>
      txn.pageBefore(lastMessageId: id, perPage: perPage)
    );

    final nextPageTask = lastMessageId?.let((id) =>
      txn.pageAfter(lastMessageId: id, perPage: perPage)
    );

    return MessagePage(
      perPage: perPage,
      messages: await messagesTask ?? [],
      previous: await prevPageTask,
      next: await nextPageTask,
    );
  });

  @override
  Future<void> publishMessage(String message) => _db.insertMessage(message);

  @override
  Future<int> get totalMessageCount => _db.totalMessageCount;

  @override
  Future<int?> get lastMessageId => _db.lastMessageId;

  @override
  Future<int> messageCountAfterId(int messageId) =>
    _db.messageCountAfterId(messageId);
}

extension _Messages on SqliteWriteContext {
  Future<List<Message>> fetchMessagePage({
    required int lastMessageId,
    required int perPage,
  }) async {
    final res = await messagePage(lastMessageId: lastMessageId, perPage: perPage);
    return res.map(Message.fromJson).toList(growable: false);
  }
}
