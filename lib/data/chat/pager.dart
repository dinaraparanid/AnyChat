import 'package:any_chat/core/config.dart';
import 'package:any_chat/data/chat/preferences.dart';
import 'package:any_chat/data/chat/provider/url.dart';
import 'package:any_chat/data/chat/query.dart';
import 'package:any_chat/domain/chat/message.dart';
import 'package:any_chat/domain/chat/page.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:super_paging/super_paging.dart';

final class ChatPagingSource extends PagingSource<int, Message> {
  final Dio _client;
  final ChatPreferences _preferences;
  final Set<int> _presentIds = {};

  ChatPagingSource({
    required Dio client,
    required ChatPreferences preferences,
  }) : _client = client, _preferences = preferences;

  @override
  Future<LoadResult<int, Message>> load(LoadParams<int> params) =>
    _fetch(params.key);

  Future<LoadResult<int, Message>> _fetch(int? messageId) async {
    final queryMessageId = messageId ?? await _preferences.chatPosition;

    try {
      final response = await _client.get(
        '${BaseUrlProvider.httpBaseUrl}${MessageQuery.pathMessages}',
        queryParameters: {
          MessageQuery.queryMessagesLastMessageId: queryMessageId,
          MessageQuery.queryMessagesPerPage: AppConfig.chatPageSize,
        },
      );

      final msgPage = MessagePage.fromJson(response.data);

      final msgList = msgPage.messages
          .whereNot((m) => _presentIds.contains(m.id))
          .toList(growable: false);

      _presentIds.addAll(msgList.map((m) => m.id));

      return LoadResult.page(
        items: msgList,
        prevKey: msgPage.previous,
        nextKey: msgPage.next,
      );
    } on Exception catch (e) {
      return LoadResult.error(e);
    }
  }
}
