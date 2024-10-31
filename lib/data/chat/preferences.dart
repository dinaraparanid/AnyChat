import 'package:shared_preferences/shared_preferences.dart';

final class ChatPreferences {
  final SharedPreferencesAsync _prefs;
  ChatPreferences({required SharedPreferencesAsync prefs}) : _prefs = prefs;

  static const _keyChatPosition = 'chat_position';
  static const _keyChatPage = 'chat_page';

  Future<int?> get chatPosition => _prefs.getInt(_keyChatPosition);

  Future<void> storeChatPosition(int position) =>
    _prefs.setInt(_keyChatPosition, position);

  Future<int?> get chatPage => _prefs.getInt(_keyChatPage);

  Future<void> storeChatPage(int page) =>
    _prefs.setInt(_keyChatPage, page);
}
