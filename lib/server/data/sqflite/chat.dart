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

  Future<ResultSet> messagePage({
    required int lastMessageId,
    required int perPage,
  }) => execute('''
    SELECT * FROM ${ChatTable.tableName}
    WHERE ${ChatTable.fieldTimestamp} >= (
      SELECT ${ChatTable.fieldTimestamp} FROM ${ChatTable.tableName}
      WHERE ${ChatTable.fieldId} = ? LIMIT 1
    )
    LIMIT ?
    ''',
    [lastMessageId, perPage],
  );

  Future<int?> pageBefore({
    required int lastMessageId,
    required int perPage,
  }) async {
    final res = await execute('''
      SELECT ${ChatTable.fieldId} FROM (
        SELECT ${ChatTable.fieldId}, ${ChatTable.fieldTimestamp} FROM ${ChatTable.tableName}
        WHERE ${ChatTable.fieldTimestamp} < (
          SELECT ${ChatTable.fieldTimestamp} FROM ${ChatTable.tableName}
          WHERE ${ChatTable.fieldId} = ? LIMIT 1
        )
        ORDER BY ${ChatTable.fieldTimestamp} DESC
        LIMIT ?
      )
      ORDER BY ${ChatTable.fieldTimestamp} ASC
      LIMIT 1
      ''',
      [lastMessageId, perPage],
    );

    return res.singleOrNull?.messageId;
  }

  Future<int?> pageAfter({
    required int lastMessageId,
    required int perPage,
  }) async {
    final ResultSet res = await execute('''
      SELECT ${ChatTable.fieldId} FROM ${ChatTable.tableName}
      WHERE ${ChatTable.fieldTimestamp} >= (
        SELECT ${ChatTable.fieldTimestamp} FROM ${ChatTable.tableName}
        WHERE ${ChatTable.fieldId} = ? LIMIT 1
      )
      LIMIT ?
      ''',
      [lastMessageId, perPage + 1],
    );

    return res.length > perPage ? res[perPage].messageId : null;
  }

  Future<int> messageCountAfterId(int messageId) async {
    final res = await execute(
      '''
      SELECT COUNT(${ChatTable.fieldId}) FROM ${ChatTable.tableName}
      WHERE ${ChatTable.fieldTimestamp} > (
        SELECT ${ChatTable.fieldTimestamp} FROM ${ChatTable.tableName}
        WHERE ${ChatTable.fieldId} = ? LIMIT 1
      )
      ''',
      [messageId]
    );

    return res.rows[0][0] as int;
  }

  Future<int> get totalMessageCount async {
    final res = await execute(
      'SELECT COUNT(${ChatTable.fieldId}) FROM ${ChatTable.tableName}'
    );

    return res.rows[0][0] as int;
  }

  Future<int?> get lastMessageId async {
    final res = await execute(
      '''
      SELECT ${ChatTable.fieldId} FROM ${ChatTable.tableName}
      ORDER BY ${ChatTable.fieldTimestamp} DESC
      LIMIT 1
      '''
    );

    return res.singleOrNull.messageId;
  }
}

extension _MessageId on Row? {
  int? get messageId => this?.values.firstOrNull as int?;
}
