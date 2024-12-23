import 'dart:io';

import 'package:any_chat/domain/chat/count.dart';
import 'package:any_chat/server/di/server_module.dart';
import 'package:any_chat/server/domain/chat/repository.dart';
import 'package:any_chat/server/rooting/router.dart';
import 'package:any_chat/server/rooting/signal.dart';
import 'package:any_chat/utils/functional.dart';
import 'package:logger/logger.dart';

final _host = InternetAddress.loopbackIPv4;
const _port = 8080;

Future<void> runServer() async {
  final server = await HttpServer.bind(_host, _port);
  final router = di<Router>();
  final logger = di<Logger>();
  final chatRepository = di<ChatRepository>();
  final clients = <WebSocket>[];

  logger.i('Listening on ${server.address}');

  await for (final request in server) {
    logger.d(request);
    router.handleRequest(
      request: request,
      onConnected: (client) {
        clients.add(client);
      },
      onDisconnected: clients.remove,
      onMessaging: (message) {
        logger.i('Received message: $message');
        chatRepository.publishMessage(message);

        for (final client in clients) {
          client.add(ServerSignal.update);
        }
      },
      onUpdatePager: ({required perPage, lastMessageId}) async =>
        chatRepository.getMessagePage(
          lastMessageId: lastMessageId,
          perPage: perPage,
        ),
      onUpdateCounter: ({lastMessageId}) async => MessageCount(
        count: await (
          lastMessageId
            ?.let(chatRepository.messageCountAfterId)
            ?? chatRepository.totalMessageCount
        ),
        lastMessageId: await chatRepository.lastMessageId,
      ),
    );
  }
}
