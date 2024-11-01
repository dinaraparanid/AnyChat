import 'package:shared_preferences/shared_preferences.dart';

final class ChatPreferences {
  final SharedPreferencesAsync _prefs;
  ChatPreferences({required SharedPreferencesAsync prefs}) : _prefs = prefs;

  static const _keyChatPosition = 'chat_position';
  static const _keyChatOffset = 'chat_offset';
  static const _keyChatPage = 'chat_page';
  static const _keyChatTotalPages = 'total_pages';

  Future<int?> get chatPosition => _prefs.getInt(_keyChatPosition);

  Future<void> storeChatPosition(int position) =>
    _prefs.setInt(_keyChatPosition, position);

  Future<double?> get chatOffset => _prefs.getDouble(_keyChatOffset);

  Future<void> storeChatOffset(double offset) =>
    _prefs.setDouble(_keyChatOffset, offset);

  Future<int?> get currentPage => _prefs.getInt(_keyChatPage);

  Future<void> storeCurrentPage(int page) =>
    _prefs.setInt(_keyChatPage, page);

  Future<int?> get totalPages => _prefs.getInt(_keyChatTotalPages);

  Future<void> storeTotalPages(int pages) =>
    _prefs.setInt(_keyChatTotalPages, pages);
}
