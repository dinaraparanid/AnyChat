import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/ui/theme/theme.dart';
import 'package:any_chat/utils/date_time_ext.dart';
import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fpdart;

class Chat extends ConsumerStatefulWidget {
  final List<Message> messages;
  final ScrollController scrollController;

  const Chat({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

class _ChatState extends ConsumerState<Chat> {

  late Map<String, List<Message>> _groupedMessages;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

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
            left: theme.dimensions.padding.extraMedium,
            right: theme.dimensions.padding.extraMedium,
            top: theme.dimensions.padding.small,
            bottom: theme.dimensions.padding.small,
          ),
          itemCount: items.length,
          separatorBuilder: (ctx, idx) =>
              SizedBox(height: theme.dimensions.padding.extraMedium),
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

  Widget _date(String dayMonth) {
    final theme = ref.watch(appThemeProvider);

    return Container(
      alignment: Alignment.center,
      child: Card(
        color: theme.colors.background.dateLabel,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.dimensions.radius.extraMedium),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: theme.dimensions.padding.small,
            horizontal: theme.dimensions.padding.extraMedium,
          ),
          child: Text(
            dayMonth,
            style: theme.typography.regular.copyWith(
              color: theme.colors.text.onDateLabel,
            ),
          ),
        ),
      ),
    );
  }

  Widget _message({
    required Message msg,
    Alignment contentAlignment = Alignment.centerRight,
  }) {
    final theme = ref.watch(appThemeProvider);

    return Container(
      alignment: contentAlignment,
      child: Card(
        color: theme.colors.background.message,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.dimensions.radius.extraMedium),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: theme.dimensions.padding.medium,
            bottom: theme.dimensions.padding.small,
            left: theme.dimensions.padding.medium,
            right: theme.dimensions.padding.medium,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                msg.text,
                style: theme.typography.body.copyWith(
                  color: theme.colors.text.onMessage,
                ),
              ),

              SizedBox(height: theme.dimensions.padding.small),

              Text(
                msg.timestamp.timeFormat,
                style: theme.typography.caption.copyWith(
                  color: theme.colors.text.onMessage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
