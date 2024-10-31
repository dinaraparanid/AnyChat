mixin ChatStore {
  Future<int?> get chatPosition;
  Future<void> storeChatPosition(int position);

  Future<int?> get chatPage;
  Future<void> storeChatPage(int page);
}
