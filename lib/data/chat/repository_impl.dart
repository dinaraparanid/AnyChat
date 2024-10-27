import 'dart:async';
import 'dart:convert';

import 'package:any_chat/data/chat/provider/url.dart';
import 'package:any_chat/domain/chat/pager.dart';
import 'package:any_chat/domain/domain.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:paging_view/paging_view.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

final class ChatRepositoryImpl extends ChatRepository {
  final Dio client;
  final ChatPager pager;

  final connectivity = Connectivity();
  WebSocketChannel? socketChannel;

  ChatRepositoryImpl({
    required this.client,
    required this.pager,
  }) {
    connectivity
      .onConnectivityChanged
      .map((types) => types.any((t) =>
        t == ConnectivityResult.ethernet ||
            t == ConnectivityResult.mobile ||
            t == ConnectivityResult.wifi
      ))
      .distinct()
      .listen((isConnected) async {
        if (isConnected) {
          socketChannel = WebSocketChannel.connect(
            Uri.parse('${BaseUrlProvider.webSocketBaseUrl}/messages')
          );

          await socketChannel!.ready;

          await for (final _ in socketChannel!.stream) {
            await pager.refresh();
          }
        } else {
          socketChannel?.sink.close(status.goingAway);
          socketChannel = null;
        }
      });
  }

  @override
  DataSource<int, Message> get pagingSource => pager;

  @override
  Future<Either<Exception, void>> sendMessage(String text) async {
    try {
      socketChannel!.sink.add(text);
      return Either.right(null);
    } on Exception catch (e) {
      return Either.left(e);
    }
  }
}
