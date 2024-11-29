import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

final class ChatPreferences {
  final RxSharedPreferences _prefs;
  ChatPreferences({required RxSharedPreferences prefs}) : _prefs = prefs;

  static const _keyChatPositionId = 'chat_position_id';
  static const _keyLastMessageId = 'last_message_id';
  static const _keyLastSeenMessageId = 'last_seen_message_id';
  static const _keyUnreadMessageCount = 'unread_message_count';

  Future<int?> get chatPositionId => _prefs.getInt(_keyChatPositionId);

  Stream<int?> get chatPositionIdStream => _prefs.getIntStream(_keyChatPositionId);

  Future<void> storeChatPositionId(int position) =>
    _prefs.setInt(_keyChatPositionId, position);

  Stream<int?> get lastMessageIdStream => _prefs.getIntStream(_keyLastMessageId);

  Future<void> storeLastMessageId(int lastMessageId) =>
    _prefs.setInt(_keyLastMessageId, lastMessageId);

  Future<int?> get lastSeenMessageId =>  _prefs.getInt(_keyLastSeenMessageId);

  Stream<int?> get lastSeenMessageIdStream =>
    _prefs.getIntStream(_keyLastSeenMessageId);

  Future<void> storeLastSeenMessageId(int lastSeenMessageId) =>
    _prefs.setInt(_keyLastSeenMessageId, lastSeenMessageId);

  Stream<int> get unreadMessageCount =>
    _prefs.getIntStream(_keyUnreadMessageCount).whereNotNull();

  Future<void> storeUnreadMessageCount(int count) =>
    _prefs.setInt(_keyUnreadMessageCount, count);
}
