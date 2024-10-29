import 'dart:math';

import 'package:sqlite_async/sqlite3_common.dart';
import 'package:sqlite_async/sqlite_async.dart';

final class ChatTable {
  ChatTable._();

  static const tableName = 'Chat';
  static const fieldId = 'id';
  static const fieldText = 'text';
  static const fieldTimestamp = 'timestamp';
}

extension ChatTableQueries on SqliteWriteContext {
  Future<void> createChatTableIfNotExists() => execute('''
      CREATE TABLE IF NOT EXISTS ${ChatTable.tableName} (
        ${ChatTable.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ChatTable.fieldText} TEXT NOT NULL,
        ${ChatTable.fieldTimestamp} INTEGER NOT NULL
      )
    ''');

  Future<void> insertMessage(String message) {
    final now = DateTime.now().toUtc();
    final timestamp = now.millisecondsSinceEpoch;

    return execute('''
      INSERT INTO ${ChatTable.tableName} (
        ${ChatTable.fieldText},
        ${ChatTable.fieldTimestamp}
      )
      VALUES (?, ?)
      ''',
      [message, timestamp],
    );
  }

  Future<ResultSet> selectMessagePage({
    required int page,
    required int perPage,
  }) {
    final pageIndex = max(page - 1, 0);
    final offset = pageIndex * perPage;

    return execute('''
      SELECT * FROM ${ChatTable.tableName}
      LIMIT ? OFFSET ?
      ''',
      [perPage, offset],
    );
  }

  Future<bool> hasPageAfter({
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
