import 'package:any_chat/core/config.dart';
import 'package:any_chat/data/chat/preferences.dart';
import 'package:any_chat/data/chat/provider/url.dart';
import 'package:any_chat/domain/chat/message.dart';
import 'package:any_chat/domain/chat/page.dart';
import 'package:dio/dio.dart';
import 'package:super_paging/super_paging.dart';

final class ChatPagingSource extends PagingSource<int, Message> {
  final Dio _client;
  final ChatPreferences _preferences;

  ChatPagingSource({
    required Dio client,
    required ChatPreferences preferences,
  }) : _client = client, _preferences = preferences;

  @override
  Future<LoadResult<int, Message>> load(LoadParams<int> params) =>
    _fetch(params.key);

  Future<LoadResult<int, Message>> _fetch(int? page) async {
    final queryPage = page
      ?? await _preferences.currentPage
      ?? await _preferences.totalPages;

    try {
      final response = await _client.get(
        '${BaseUrlProvider.httpBaseUrl}/messages',
        queryParameters: { 'page': queryPage, 'per_page': AppConfig.chatPageSize },
      );

      final msgPage = MessagePage.fromJson(response.data);

      return LoadResult.page(
        items: msgPage.messages,
        prevKey: msgPage.previous,
        nextKey: msgPage.next,
      );
    } on Exception catch (e) {
      return LoadResult.error(e);
    }
  }
}
