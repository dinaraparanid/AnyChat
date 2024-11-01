mixin ChatStore {
  Future<int?> get chatPosition;
  Future<void> storeChatPosition(int position);

  Future<double?> get chatOffset;
  Future<void> storeChatOffset(double offset);

  Future<int?> get currentPage;
  Future<void> storeCurrentPage(int page);

  Future<int?> get totalPages;
  Future<void> storeTotalPages(int pages);
}
