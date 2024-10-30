import 'dart:io';

import 'package:any_chat/domain/chat/page.dart';
import 'package:any_chat/server/rooting/request/messages_count.dart';
import 'package:any_chat/server/rooting/request/messages_page.dart';
import 'package:any_chat/server/rooting/request/query.dart';
import 'package:logger/logger.dart';

typedef ConnectedRequest = void Function(WebSocket client);
typedef MessagingRequest = void Function(String message);
typedef UpdatePagerRequest = Future<MessagePage> Function(int page, int perPage);
typedef UpdateCounterRequest = Future<int> Function();
typedef DisconnectedRequest = void Function(WebSocket client);

final class Router {
  final Logger _logger;
  Router({required Logger logger}) : _logger = logger;

  void handleRequest({
    required HttpRequest request,
    required ConnectedRequest onConnected,
    required MessagingRequest onMessaging,
    required UpdatePagerRequest onUpdatePager,
    required UpdateCounterRequest onUpdateCounter,
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
      onUpdatePager: onUpdatePager,
      onUpdateCounter: onUpdateCounter,
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
    required UpdatePagerRequest onUpdatePager,
    required UpdateCounterRequest onUpdateCounter,
  }) async {
    final url = request.uri;
    final method = request.method;
    final path = url.path;

    if (method == 'GET' && path == MessageQuery.pathMessages) {
      await onMessagesPage(request: request, onUpdateRequest: onUpdatePager);
    } else if (method == 'GET' && path == MessageQuery.pathMessagesCount) {
      await onMessagesCount(request: request, onUpdateCounter: onUpdateCounter);
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
