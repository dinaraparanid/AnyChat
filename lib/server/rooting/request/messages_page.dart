import 'dart:convert';
import 'dart:io';

import 'package:any_chat/core/config.dart';
import 'package:any_chat/data/chat/query.dart';
import 'package:any_chat/server/rooting/router.dart';
import 'package:any_chat/utils/functional.dart';

Future<void> onMessagesPage({
  required HttpRequest request,
  required UpdatePagerRequest onUpdatePager,
  required UpdateCounterRequest onUpdateCounter,
}) async {
  final url = request.uri;
  final query = url.queryParameters;

  final lastMessageId = query[MessageQuery.queryMessagesLastMessageId]
    ?.let(int.tryParse)
    ?? (await onUpdateCounter()).lastMessageId;

  final perPage = query[MessageQuery.queryMessagesPerPage]
    ?.let(int.tryParse)
    ?? AppConfig.chatPageSize;

  final messagePage = await onUpdatePager(lastMessageId, perPage);

  request.response
    ..statusCode = HttpStatus.ok
    ..headers.contentType = ContentType('application', 'json', charset: 'utf-8')
    ..write(jsonEncode(messagePage.toJson()))
    ..close();
}
