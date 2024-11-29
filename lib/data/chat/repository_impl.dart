import 'dart:async';

import 'package:any_chat/core/config.dart';
import 'package:any_chat/data/chat/pager.dart';
import 'package:any_chat/data/chat/preferences.dart';
import 'package:any_chat/data/chat/provider/url.dart';
import 'package:any_chat/data/chat/query.dart';
import 'package:any_chat/domain/chat/count.dart';
import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/utils/functional.dart';
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
    config: const PagingConfig(pageSize: AppConfig.chatPageSize),
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

          // update local storage
          await messageCount(lastMessageId: await lastSeenMessageId);
          await socketChannel!.ready;

          await for (final _ in socketChannel!.stream) {
            // update local storage
            await messageCount(lastMessageId: await lastSeenMessageId);
            await pager.refresh(resetPages: false);
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
  Future<Either<Exception, MessageCount>> messageCount({int? lastMessageId}) async {
    try {
      final response = await client.get(
        '${BaseUrlProvider.httpBaseUrl}/messages/count'
            '?${MessageQuery.queryMessagesLastMessageId}=$lastMessageId',
      );

      return Either.right(
        MessageCount.fromJson(response.data).also((data) {
          data.lastMessageId?.let(storeLastMessageId);
          storeUnreadMessageCount(data.count);
        }),
      );
    } on Exception catch (e) {
      return Either.left(e);
    }
  }

  @override
  Stream<int?> get chatPositionIdStream => preferences.chatPositionIdStream;

  @override
  Future<void> storeChatPositionId(int messageId) =>
    preferences.storeChatPositionId(messageId);

  @override
  Stream<int?> get lastMessageIdStream => preferences.lastMessageIdStream;

  @override
  Future<void> storeLastMessageId(int messageId) =>
    preferences.storeLastMessageId(messageId);

  @override
  Future<int?> get lastSeenMessageId => preferences.lastSeenMessageId;

  @override
  Stream<int?> get lastSeenMessageIdStream =>
    preferences.lastSeenMessageIdStream;

  @override
  Future<void> storeLastSeenMessageId(int messageId) =>
    preferences.storeLastSeenMessageId(messageId);

  @override
  Stream<int> get unreadMessageCount => preferences.unreadMessageCount;

  @override
  Future<void> storeUnreadMessageCount(int count) =>
    preferences.storeUnreadMessageCount(count);
}
