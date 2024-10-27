import 'package:any_chat/server/data/sqflite/chat.dart';
import 'package:sqlite_async/sqlite_async.dart';

const _dbPath = 'chat.db';

final class ServerDatabaseProvider {
  final SqliteDatabase db;
  ServerDatabaseProvider._(this.db);

  static Future<ServerDatabaseProvider> init() async {
    final db = SqliteDatabase(path: _dbPath);

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${ChatTable.tableName} (
        ${ChatTable.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ChatTable.fieldText} TEXT NOT NULL,
        ${ChatTable.fieldTimestamp} INTEGER NOT NULL
      )
    ''');

    return ServerDatabaseProvider._(db);
  }
}
