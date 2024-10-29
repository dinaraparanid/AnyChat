import 'package:any_chat/server/data/sqflite/chat.dart';
import 'package:sqlite_async/sqlite_async.dart';

const _dbPath = 'chat.db';

final class ServerDatabaseProvider {
  final SqliteDatabase db;
  ServerDatabaseProvider._(this.db);

  static Future<ServerDatabaseProvider> init() async {
    final db = SqliteDatabase(path: _dbPath);
    await db.createChatTableIfNotExists();
    return ServerDatabaseProvider._(db);
  }
}
