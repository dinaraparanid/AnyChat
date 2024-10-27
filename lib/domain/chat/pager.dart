import 'package:any_chat/data/chat/provider/url.dart';
import 'package:any_chat/domain/chat/message.dart';
import 'package:any_chat/domain/chat/page.dart';
import 'package:dio/dio.dart';
import 'package:paging_view/paging_view.dart';

final class ChatPager extends DataSource<int, Message> {
  final Dio _client;
  ChatPager({required Dio client}) : _client = client;

  @override
  Future<LoadResult<int, Message>> load(LoadAction<int> action) async =>
    switch (action) {
      Refresh<int>() => await _fetch(null),
      Prepend<int>() => const None(),
      Append<int>(key: final page) => await _fetch(page),
    };

  Future<LoadResult<int, Message>> _fetch(int? page) async {
    try {
      final response = await _client.get(
        '${BaseUrlProvider.httpBaseUrl}/messages',
        queryParameters: {'page': page ?? 1 },
      );

      final msgPage = MessagePage.fromJson(response.data);

      return Success(page: PageData(
        data: msgPage.messages,
        prependKey: msgPage.previous,
        appendKey: msgPage.next,
      ));
    } on Exception catch (e) {
      return Failure(e: e);
    }
  }
}
