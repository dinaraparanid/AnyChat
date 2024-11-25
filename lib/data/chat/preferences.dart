import 'package:shared_preferences/shared_preferences.dart';

final class ChatPreferences {
  final SharedPreferencesAsync _prefs;
  ChatPreferences({required SharedPreferencesAsync prefs}) : _prefs = prefs;

  static const _keyChatPosition = 'chat_position';

  Future<int?> get chatPosition => _prefs.getInt(_keyChatPosition);

  Future<void> storeChatPosition(int position) =>
    _prefs.setInt(_keyChatPosition, position);
}
