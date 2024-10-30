import 'dart:convert';
import 'dart:io';

import 'package:any_chat/server/rooting/request/query.dart';
import 'package:any_chat/server/rooting/router.dart';
import 'package:any_chat/utils/functional.dart';

const _defaultPage = 1;
const _defaultPerPage = 20;

Future<void> onMessagesPage({
  required HttpRequest request,
  required UpdatePagerRequest onUpdateRequest,
}) async {
  final url = request.uri;
  final query = url.queryParameters;
  final page = query[MessageQuery.queryMessagesPage]?.let(int.tryParse) ?? _defaultPage;
  final perPage = query[MessageQuery.queryMessagesPerPage]?.let(int.tryParse) ?? _defaultPerPage;
  final messagePage = await onUpdateRequest(page, perPage);

  request.response
    ..statusCode = HttpStatus.ok
    ..headers.contentType = ContentType('application', 'json', charset: 'utf-8')
    ..write(jsonEncode(messagePage.toJson()))
    ..close();
}
