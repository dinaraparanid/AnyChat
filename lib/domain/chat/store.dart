mixin ChatStore {
  Stream<int?> get chatPositionIdStream;
  Future<void> storeChatPositionId(int messageId);

  Stream<int?> get lastMessageIdStream;
  Future<void> storeLastMessageId(int messageId);
}
