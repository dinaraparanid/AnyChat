import 'dart:io';

import 'package:any_chat/server/rooting/router.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final _host = InternetAddress.loopbackIPv4;
const _port = 8080;

Future<void> runServer() async {
  final server = await HttpServer.bind(_host, _port);
  final router = GetIt.instance<Router>();
  final logger = GetIt.instance<Logger>();
  final clients = <WebSocket>[];

  logger.i('Listening on ${server.address}');

  await for (final request in server) {
    logger.d(request);
    router.handleRequest(
      request: request,
      onConnected: clients.add,
      onMessaging: (message) {
        logger.i('Received message: $message');
        // TODO: в базу данных
      },
      onDisconnected: clients.remove,
    );
  }
}
