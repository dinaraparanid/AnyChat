import 'package:any_chat/core/ui/foundation/progress_indicator.dart';
import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/data/chat/provider/pager.dart';
import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/feature/chat/presentation/ui/date.dart';
import 'package:any_chat/feature/chat/presentation/ui/message.dart';
import 'package:any_chat/server/rooting/router.dart';
import 'package:any_chat/utils/date_time_ext.dart';
import 'package:any_chat/utils/functional.dart';
import 'package:any_chat/utils/scroll.dart';
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
  late Map<String, List<Message>> groupedMessages;
  bool isInitialScrollDone = false;
  void Function()? scrollListener;

  ScrollController get scrollController => widget.scrollController;

  @override
  void initState() {
    super.initState();
    final pagerNotifier = widget.source.notifier;

    pagerNotifier.addListener(scrollListener = () {
      if (!isInitialScrollDone &&
          !pagerNotifier.isLoading &&
          pagerNotifier.values.isNotEmpty
      ) {
        setState(() {
          scrollController.scrollToBottom();
          isInitialScrollDone = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    final pagerNotifier = widget.source.notifier;
    scrollListener?.let(pagerNotifier.removeListener);
    scrollListener = null;
  }

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
          builder: (context, message, index) => switch (message.firstForDate) {
            true => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DateUi(dayMonth: message.createdAt.dayMonthWordFormat),
                SizedBox(height: theme.dimensions.padding.extraMedium),
                MessageUi(msg: message),
              ],
            ),

            _ => MessageUi(msg: message),
          },
          errorBuilder: (context, err) => Text('TODO: Error stub'),
          initialLoadingWidget: const AppProgressIndicator(),
          controller: scrollController,
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
    groupedMessages.entries.flatMap((entry) =>
      <Widget>[DateUi(dayMonth: entry.value.first.createdAt.dayMonthWordFormat)] +
        entry.value.map((msg) => MessageUi(msg: msg)).toList(growable: false)
    ).toList(growable: false);
}
