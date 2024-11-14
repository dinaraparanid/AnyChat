import 'dart:async';

import 'package:any_chat/core/config.dart';
import 'package:any_chat/data/chat/pager.dart';
import 'package:any_chat/data/chat/preferences.dart';
import 'package:any_chat/data/chat/provider/url.dart';
import 'package:any_chat/domain/chat/count.dart';
import 'package:any_chat/domain/domain.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:super_paging/super_paging.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

final class ChatRepositoryImpl extends ChatRepository {
  final Dio client;
  final ChatPagingSource pagingSource;
  final ChatPreferences preferences;
  final Pager<int, Message> _pager;

  final connectivity = Connectivity();
  WebSocketChannel? socketChannel;

  ChatRepositoryImpl({
    required this.client,
    required this.pagingSource,
    required this.preferences,
  }) : _pager = Pager(
    config: const PagingConfig(
      pageSize: AppConfig.chatPageSize,
      //prefetchIndex: AppConfig.chatPageSize ~/ 2, // TODO: доработать библиотеку, чтобы prepend на <=
    ),
    pagingSourceFactory: () => pagingSource,
  ) {
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

          await messageCount; // update local storage
          await socketChannel!.ready;

          await for (final _ in socketChannel!.stream) {
            await messageCount; // update local storage
            await pager.refresh();
          }
        } else {
          socketChannel?.sink.close(status.goingAway);
          socketChannel = null;
        }
      });
  }

  @override
  Pager<int, Message> get pager => _pager;

  @override
  Future<Either<Exception, void>> sendMessage(String text) async {
    try {
      socketChannel!.sink.add(text);
      return Either.right(null);
    } on Exception catch (e) {
      return Either.left(e);
    }
  }

  @override
  Future<Either<Exception, MessageCount>> get messageCount async {
    try {
      final response = await client.get(
        '${BaseUrlProvider.httpBaseUrl}/messages/count',
      );

      final data = MessageCount.fromJson(response.data);
      await storeTotalPages(data.lastPage);
      return Either.right(data);
    } on Exception catch (e) {
      return Either.left(e);
    }
  }

  @override
  Future<int?> get chatPosition => preferences.chatPosition;

  @override
  Future<void> storeChatPosition(int position) =>
    preferences.storeChatPosition(position);

  @override
  Future<int?> get currentPage => preferences.currentPage;

  @override
  Future<void> storeCurrentPage(int page) => preferences.storeCurrentPage(page);

  @override
  Future<int?> get totalPages => preferences.totalPages;

  @override
  Future<void> storeTotalPages(int pages) => preferences.storeTotalPages(pages);
}
