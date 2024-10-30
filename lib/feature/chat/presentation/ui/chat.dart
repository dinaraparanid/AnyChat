import 'package:any_chat/core/ui/foundation/progress_indicator.dart';
import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/feature/chat/component/provider.dart';
import 'package:any_chat/feature/chat/presentation/ui/date.dart';
import 'package:any_chat/feature/chat/presentation/ui/message.dart';
import 'package:any_chat/utils/date_time.dart';
import 'package:any_chat/utils/functional.dart';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paging_view/paging_view.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

final class Chat extends ConsumerStatefulWidget {
  final DataSource<int, Message> source;
  final AutoScrollController scrollController;

  const Chat({
    super.key,
    required this.source,
    required this.scrollController,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

final class _ChatState extends ConsumerState<Chat> {
  bool isInitialScrollDone = false;
  void Function()? scrollListener;

  DataSource<int, Message> get source => widget.source;
  AutoScrollController get scrollController => widget.scrollController;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollListener = () {
      final position = scrollController.tagMap.keys.max;
      ref.read(chatNotifierProvider.notifier).updateChatPosition(position);
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollListener?.let(scrollController.removeListener);
    scrollListener = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PagingList.separated(
          shrinkWrap: true,
          dataSource: source,
          builder: (context, message, index) => AutoScrollTag(
            key: ValueKey(index),
            controller: scrollController,
            index: index,
            child: switch (message.firstForDate) {
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
          ),
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
}
