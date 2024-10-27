import 'dart:convert';
import 'dart:io';

import 'package:any_chat/domain/chat/page.dart';
import 'package:any_chat/server/rooting/request/message.dart';
import 'package:any_chat/utils/functional.dart';
import 'package:logger/logger.dart';

const _defaultPage = 1;
const _defaultPerPage = 20;

typedef ConnectedRequest = void Function(WebSocket client);
typedef MessagingRequest = void Function(String message);
typedef UpdateRequest = Future<MessagePage> Function(int page, int perPage);
typedef DisconnectedRequest = void Function(WebSocket client);

final class Router {
  final Logger _logger;
  Router({required Logger logger}) : _logger = logger;

  void handleRequest({
    required HttpRequest request,
    required ConnectedRequest onConnected,
    required MessagingRequest onMessaging,
    required UpdateRequest onUpdateRequest,
    required DisconnectedRequest onDisconnected,
  }) async => switch (request.headers.value('Upgrade')) {
    'websocket' => await _onWebSocketRequest(
      request: request,
      onConnected: onConnected,
      onMessaging: onMessaging,
      onDisconnected: onDisconnected,
    ),

    _ => await _onHttpRequest(
      request: request,
      onUpdateRequest: onUpdateRequest
    ),
  };

  Future<void> _onWebSocketRequest({
    required HttpRequest request,
    required ConnectedRequest onConnected,
    required MessagingRequest onMessaging,
    required DisconnectedRequest onDisconnected,
  }) async {
    final socket = await WebSocketTransformer.upgrade(request);

    onConnected(socket);
    _logger.i('Client connected');

    socket.listen(
      (message) => onMessaging(message),
      onDone: () => onDisconnected(socket),
      onError: (_) => onDisconnected(socket),
      cancelOnError: true,
    );
  }

  Future<void> _onHttpRequest({
    required HttpRequest request,
    required UpdateRequest onUpdateRequest,
}) async {
    final url = request.uri;

    if (request.method == 'GET' && url.path == MessageRequester.pathMessages) {
      final query = url.queryParameters;
      final page = query[MessageRequester.queryMessagePage]?.let(int.tryParse) ?? _defaultPage;
      final perPage = query[MessageRequester.queryMessagePerPage]?.let(int.tryParse) ?? _defaultPerPage;
      final messagePage = await onUpdateRequest(page, perPage);

      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType('application', 'json', charset: 'utf-8')
        ..write(jsonEncode(messagePage.toJson()))
        ..close();
    } else {
      _onUndefinedRequest(request);
    }
  }

  void _onUndefinedRequest(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.forbidden
      ..close();
  }
}
