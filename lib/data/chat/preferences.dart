import 'package:shared_preferences/shared_preferences.dart';

final class ChatPreferences {
  final SharedPreferencesAsync _prefs;
  ChatPreferences({required SharedPreferencesAsync prefs}) : _prefs = prefs;

  static const _keyChatPosition = 'chat_position';
  static const _keyChatPage = 'chat_page';
  static const _keyChatTotalPages = 'total_pages';

  Future<int?> get chatPosition => _prefs.getInt(_keyChatPosition);

  Future<void> storeChatPosition(int position) =>
    _prefs.setInt(_keyChatPosition, position);

  Future<int?> get currentPage => _prefs.getInt(_keyChatPage);

  Future<void> storeCurrentPage(int page) =>
    _prefs.setInt(_keyChatPage, page);

  Future<int?> get totalPages => _prefs.getInt(_keyChatTotalPages);

  Future<void> storeTotalPages(int pages) =>
    _prefs.setInt(_keyChatTotalPages, pages);
}
