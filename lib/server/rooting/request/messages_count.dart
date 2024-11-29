import 'dart:convert';
import 'dart:io';

import 'package:any_chat/server/rooting/router.dart';
import 'package:any_chat/utils/functional.dart';

import '../../../data/chat/query.dart';

Future<void> onMessagesCount({
  required HttpRequest request,
  required UpdateCounterRequest onUpdateCounter,
}) async {
  final url = request.uri;
  final query = url.queryParameters;

  final lastMessageId = query[MessageQuery.queryMessagesLastMessageId]
      ?.let(int.tryParse);

  final cnt = await onUpdateCounter(lastMessageId: lastMessageId);

  request.response
    ..statusCode = HttpStatus.ok
    ..headers.contentType = ContentType('application', 'json', charset: 'utf-8')
    ..write(jsonEncode(cnt.toJson()))
    ..close();
}
