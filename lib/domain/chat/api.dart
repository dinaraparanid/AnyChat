import 'package:fpdart/fpdart.dart';

import 'package:any_chat/domain/chat/message.dart';
import 'package:paging_view/paging_view.dart';

mixin ChatApi {
  DataSource<int, Message> get pagingSource;
  Future<Either<Exception, void>> sendMessage(String text);
}
