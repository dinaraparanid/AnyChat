import 'package:any_chat/domain/chat/count.dart';
import 'package:any_chat/domain/chat/pager.dart';
import 'package:fpdart/fpdart.dart';

mixin ChatApi {
  ChatPagingSource get pager;
  Future<Either<Exception, void>> sendMessage(String text);
  Future<Either<Exception, MessageCount>> get messageCount;
}
