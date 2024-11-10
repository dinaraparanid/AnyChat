import 'package:any_chat/core/config.dart';
import 'package:any_chat/data/chat/preferences.dart';
import 'package:any_chat/data/chat/provider/url.dart';
import 'package:any_chat/domain/chat/message.dart';
import 'package:any_chat/domain/chat/page.dart';
import 'package:any_chat/domain/chat/pager.dart';
import 'package:any_chat/utils/date_time.dart';
import 'package:any_chat/utils/iterable.dart';
import 'package:dio/dio.dart';
import 'package:tuple/tuple.dart';

final class ChatPagingSourceImpl extends ChatPagingSource {
  final Dio _client;
  final ChatPreferences _preferences;
  final Map<String, int> _firstMessagesForDates = {};

  ChatPagingSourceImpl({
    required Dio client,
    required ChatPreferences preferences,
  }) : _client = client, _preferences = preferences;

  @override
  Future<LoadResult<int, Message>> load({int? key}) async {
    final queryPage = key
      ?? await _preferences.currentPage
      ?? await _preferences.totalPages;

    try {
      final response = await _client.get(
        '${BaseUrlProvider.httpBaseUrl}/messages',
        queryParameters: { 'page': queryPage, 'per_page': AppConfig.chatPageSize },
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

      return LoadResult.success(
        key: msgPage.page,
        items: messagesWithDates,
        prependKey: msgPage.previous,
        appendKey: msgPage.next,
      );
    } on Exception catch (e) {
      return LoadResult.failure(error: e);
    }
  }
}
