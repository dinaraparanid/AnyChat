import 'package:any_chat/utils/paging/result.dart';

export 'result.dart';

abstract class PagingSource<Key, Item> {
  Future<LoadResult<Key, Item>> load({Key? key});
}
