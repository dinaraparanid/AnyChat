import 'package:any_chat/domain/chat/count.dart';
import 'package:fpdart/fpdart.dart';

import 'package:any_chat/domain/chat/message.dart';
import 'package:super_paging/super_paging.dart';

mixin ChatApi {
  Pager<int, Message> get pager;
  Future<Either<Exception, void>> sendMessage(String text);
  Future<Either<Exception, MessageCount>> messageCount({int? lastMessageId});
}
