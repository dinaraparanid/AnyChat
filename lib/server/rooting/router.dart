import 'dart:io';

import 'package:logger/logger.dart';

final class Router {
  final Logger _logger;
  Router({required Logger logger}) : _logger = logger;

  void handleRequest({
    required HttpRequest request,
    required void Function(WebSocket client) onConnected,
    required void Function(String message) onMessaging,
    required void Function(WebSocket client) onDisconnected,
  }) async => switch (request.headers.value('Upgrade')) {
    'websocket' => await _onWebSocketRequest(
      request: request,
      onConnected: onConnected,
      onMessaging: onMessaging,
      onDisconnected: onDisconnected,
    ),

    _ => await _onHttpRequest(request),
  };

  Future<void> _onWebSocketRequest({
    required HttpRequest request,
    required void Function(WebSocket client) onConnected,
    required void Function(String message) onMessaging,
    required void Function(WebSocket client) onDisconnected,
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

  Future<void> _onHttpRequest(HttpRequest request) async {

  }

  void _onUndefinedRequest(HttpRequest request) {
    request.response.statusCode = HttpStatus.forbidden;
    request.response.close();
  }
}
