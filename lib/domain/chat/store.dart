mixin ChatStore {
  Future<int?> get chatPosition;
  Future<void> storeChatPosition(int position);
}
