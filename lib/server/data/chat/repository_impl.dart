import 'dart:math';

import 'package:any_chat/domain/chat/message.dart';
import 'package:any_chat/domain/chat/page.dart';
import 'package:any_chat/server/data/sqflite/chat.dart';
import 'package:any_chat/server/data/sqflite/db.dart';
import 'package:any_chat/server/domain/chat/repository.dart';
import 'package:sqlite_async/sqlite_async.dart';

final class ChatRepositoryImpl extends ChatRepository {
  final ServerDatabaseProvider _dbProvider;
  ChatRepositoryImpl(this._dbProvider);

  SqliteDatabase get _db => _dbProvider.db;

  @override
  Future<MessagePage> getMessagePage({
    required int page,
    required int perPage,
  }) => _db.writeTransaction((txn) async {
    final messagesTask = txn.fetchMessagePage(page: page, perPage: perPage);
    final hasNextTask = txn.hasNext(page: page, perPage: perPage);

    return MessagePage(
      page: page,
      perPage: perPage,
      messages: await messagesTask,
      previous: page > 1 ? page - 1 : null,
      next: await hasNextTask ? page + 1 : null,
    );
  });

  @override
  Future<void> publishMessage(String message) async => await _db.execute('''
    INSERT INTO ${ChatTable.tableName} (${ChatTable.fieldText}, ${ChatTable.fieldTimestamp})
    VALUES (?, ?)
    ''',
    [message, DateTime.now().millisecondsSinceEpoch]
  );
}

extension _Messages on SqliteWriteContext {
  Future<List<Message>> fetchMessagePage({
    required int page,
    required int perPage,
  }) async {
    final pageIndex = max(page - 1, 0);
    final offset = pageIndex * perPage;

    final res = await execute('''
      SELECT * FROM ${ChatTable.tableName}
      LIMIT ? OFFSET ?
      ''',
      [perPage, offset],
    );

    return res.map(Message.fromJson).toList(growable: false);
  }

  Future<bool> hasNext({
    required int page,
    required int perPage,
  }) async {
    final offset = page * perPage;

    final res = await execute('''
      SELECT * FROM ${ChatTable.tableName}
      LIMIT 1 OFFSET ?
      ''',
      [offset],
    );

    return res.isNotEmpty;
  }
}
