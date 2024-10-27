import 'package:any_chat/core/ui/foundation/progress_indicator.dart';
import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/feature/chat/presentation/ui/date.dart';
import 'package:any_chat/feature/chat/presentation/ui/message.dart';
import 'package:any_chat/utils/date_time_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:paging_view/paging_view.dart';

final class Chat extends ConsumerStatefulWidget {
  final DataSource<int, Message> source;
  final ScrollController scrollController;

  const Chat({
    super.key,
    required this.source,
    required this.scrollController,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

final class _ChatState extends ConsumerState<Chat> {
  late Map<String, List<Message>> _groupedMessages;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    // _groupedMessages = widget.messages.groupListsBy(
    //   (m) => m.createdAt.dayMonthYearDottedFormat
    // );

    // final items = _content();

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PagingList.separated(
          shrinkWrap: true,
          dataSource: widget.source,
          builder: (context, message, index) => MessageUi(msg: message),
          errorBuilder: (context, err) => Text('TODO: Error stub'),
          initialLoadingWidget: const AppProgressIndicator(),
          controller: widget.scrollController,
          padding: EdgeInsets.only(
            left: theme.dimensions.padding.extraMedium,
            right: theme.dimensions.padding.extraMedium,
            top: theme.dimensions.padding.small,
            bottom: theme.dimensions.padding.small,
          ),
          separatorBuilder: (ctx, idx) =>
            SizedBox(height: theme.dimensions.padding.extraMedium),
        )
      ],
    );
  }

  List<Widget> _content() =>
    _groupedMessages.entries.flatMap((entry) =>
      <Widget>[DateUi(dayMonth: entry.value.first.createdAt.dayMonthWordFormat)] +
        entry.value.map((msg) => MessageUi(msg: msg)).toList(growable: false)
    ).toList(growable: false);
}
