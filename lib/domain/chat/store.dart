mixin ChatStore {
  Future<int?> get currentPage;
  Future<void> storeCurrentPage(int page);

  Future<int?> get totalPages;
  Future<void> storeTotalPages(int pages);
}
