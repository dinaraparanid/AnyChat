import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:fpdart/fpdart.dart' as fpdart;

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:get_it/get_it.dart';

import '../../../domain/chat/message.dart';
import '../../../utils/date_time_ext.dart';
import '../../../ui/theme/theme.dart';

class Chat extends StatefulWidget {
  final List<Message> messages;
  final ScrollController scrollController;

  const Chat({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  State<StatefulWidget> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  late Map<String, List<Message>> _groupedMessages;

  final _theme = GetIt.instance<AppTheme>();

  @override
  Widget build(BuildContext context) {
    _groupedMessages = widget.messages.groupListsBy(
      (m) => m.timestamp.dayMonthYearDottedFormat
    );

    final items = _content();

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (ctx, idx) => items[idx],
          controller: widget.scrollController,
          padding: EdgeInsets.only(
            left: _theme.dimensions.padding.extraMedium,
            right: _theme.dimensions.padding.extraMedium,
            top: _theme.dimensions.padding.small,
            bottom: _theme.dimensions.padding.small,
          ),
          itemCount: items.length,
          separatorBuilder: (ctx, idx) =>
              SizedBox(height: _theme.dimensions.padding.extraMedium),
        )
      ],
    );
  }

  List<Widget> _content() =>
      _groupedMessages.entries
          .flatMap((entry) =>
            [_date(entry.value.first.timestamp.dayMonthWordFormat)].lock
                .addAll(entry.value.map((msg) => _message(msg: msg)))
          )
          .toList();

  Widget _date(String dayMonth) => Container(
    alignment: Alignment.center,
    child: Card(
      color: _theme.colors.background.dateLabel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_theme.dimensions.radius.extraMedium),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: _theme.dimensions.padding.small,
          horizontal: _theme.dimensions.padding.extraMedium,
        ),
        child: Text(
          dayMonth,
          style: _theme.typography.regular.copyWith(
            color: _theme.colors.text.onDateLabel,
          ),
        ),
      ),
    ),
  );

  Widget _message({
    required Message msg,
    Alignment contentAlignment = Alignment.centerRight,
  }) => Container(
    alignment: contentAlignment,
    child: Card(
      color: _theme.colors.background.message,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_theme.dimensions.radius.extraMedium),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: _theme.dimensions.padding.medium,
          bottom: _theme.dimensions.padding.small,
          left: _theme.dimensions.padding.medium,
          right: _theme.dimensions.padding.medium,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msg.text,
              style: _theme.typography.body.copyWith(
                color: _theme.colors.text.onMessage,
              ),
            ),

            SizedBox(height: _theme.dimensions.padding.small),

            Text(
              msg.timestamp.timeFormat,
              style: _theme.typography.caption.copyWith(
                color: _theme.colors.text.onMessage,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
