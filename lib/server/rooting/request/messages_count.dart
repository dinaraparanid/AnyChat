import 'dart:convert';
import 'dart:io';

import 'package:any_chat/server/rooting/router.dart';

Future<void> onMessagesCount({
  required HttpRequest request,
  required UpdateCounterRequest onUpdateCounter,
}) async {
  final cnt = await onUpdateCounter();

  request.response
    ..statusCode = HttpStatus.ok
    ..headers.contentType = ContentType('application', 'json', charset: 'utf-8')
    ..write(jsonEncode(cnt.toJson()))
    ..close();
}
