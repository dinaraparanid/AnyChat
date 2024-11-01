import 'package:any_chat/core/config.dart';
import 'package:any_chat/data/chat/preferences.dart';
import 'package:any_chat/data/chat/provider/url.dart';
import 'package:any_chat/domain/chat/message.dart';
import 'package:any_chat/domain/chat/page.dart';
import 'package:any_chat/utils/date_time.dart';
import 'package:any_chat/utils/iterable.dart';
import 'package:dio/dio.dart';
import 'package:paging_view/paging_view.dart';
import 'package:tuple/tuple.dart';

final class ChatPager extends DataSource<int, Message> {
  final Dio _client;
  final ChatPreferences _preferences;
  final Map<String, int> _firstMessagesForDates = {};

  ChatPager({
    required Dio client,
    required ChatPreferences preferences,
  }) : _client = client, _preferences = preferences;

  @override
  Future<LoadResult<int, Message>> load(LoadAction<int> action) async =>
    switch (action) {
      Refresh<int>() => await _fetch(null),
      Prepend<int>(key: final page) => await _fetch(page),
      Append<int>(key: final page) => await _fetch(page),
    };

  Future<LoadResult<int, Message>> _fetch(int? page) async {
    final queryPage = page
      ?? await _preferences.currentPage
      ?? await _preferences.totalPages
      ?? AppConfig.chatFirstPage;

    try {
      final response = await _client.get(
        '${BaseUrlProvider.httpBaseUrl}/messages',
        queryParameters: {'page': queryPage, 'per_page': AppConfig.chatPageSize },
      );

      final msgPage = MessagePage.fromJson(response.data);

      // TODO: подумать над логикой,
      // нужно смотреть, содержит ли предыдущее
      // сообщение дату предыдущего дня
      msgPage.messages
        .map((m) => Tuple2(m.createdAt.dayMonthYearDottedFormat, m.id))
        .distinct((data) => data.item1)
        .forEach((data) {
          if (!_firstMessagesForDates.containsKey(data.item1)) {
            _firstMessagesForDates[data.item1] = data.item2;
          }
        });

      final messagesWithDates = msgPage.messages.map((m) {
        final key = m.createdAt.dayMonthYearDottedFormat;
        return m.copyWith(firstForDate: _firstMessagesForDates[(key)] == m.id);
      }).toList(growable: false);

      return Success(page: PageData(
        data: messagesWithDates,
        prependKey: msgPage.previous,
        appendKey: msgPage.next,
      ));
    } on Exception catch (e) {
      return Failure(e: e);
    }
  }
}
