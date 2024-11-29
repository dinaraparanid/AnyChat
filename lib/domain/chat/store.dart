mixin ChatStore {
  Stream<int?> get chatPositionIdStream;
  Future<void> storeChatPositionId(int messageId);

  Stream<int?> get lastMessageIdStream;
  Future<void> storeLastMessageId(int messageId);

  Future<int?> get lastSeenMessageId;
  Stream<int?> get lastSeenMessageIdStream;
  Future<void> storeLastSeenMessageId(int messageId);

  Stream<int> get unreadMessageCount;
  Future<void> storeUnreadMessageCount(int count);
}
