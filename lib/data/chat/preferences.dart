import 'package:rx_shared_preferences/rx_shared_preferences.dart';

final class ChatPreferences {
  final RxSharedPreferences _prefs;
  ChatPreferences({required RxSharedPreferences prefs}) : _prefs = prefs;

  static const _keyChatPositionId = 'chat_position_id';
  static const _keyLastMessageId = 'last_message_id';

  Future<int?> get chatPositionId => _prefs.getInt(_keyChatPositionId);

  Stream<int?> get chatPositionIdStream => _prefs.getIntStream(_keyChatPositionId);

  Future<void> storeChatPositionId(int position) =>
    _prefs.setInt(_keyChatPositionId, position);

  Stream<int?> get lastMessageIdStream => _prefs.getIntStream(_keyLastMessageId);

  Future<void> storeLastMessageId(int lastMessageId) =>
    _prefs.setInt(_keyLastMessageId, lastMessageId);
}
