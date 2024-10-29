import 'package:any_chat/data/chat/provider/url.dart';
import 'package:any_chat/domain/chat/message.dart';
import 'package:any_chat/domain/chat/page.dart';
import 'package:any_chat/utils/date_time_ext.dart';
import 'package:any_chat/utils/iterable.dart';
import 'package:dio/dio.dart';
import 'package:paging_view/paging_view.dart';
import 'package:tuple/tuple.dart';

final class ChatPager extends DataSource<int, Message> {
  final Dio _client;
  final Map<String, int> _firstMessagesForDates = {};
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