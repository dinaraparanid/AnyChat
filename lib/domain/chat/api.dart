import 'package:fpdart/fpdart.dart';

import 'message.dart';
import 'message_count.dart';

mixin ChatApi {
  Future<Either<Exception, void>> sendMessage(String text);
  Future<Either<Exception, List<Message>>> getMessages();
}
