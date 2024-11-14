import 'package:any_chat/core/config.dart';
import 'package:any_chat/core/ui/foundation/progress_indicator.dart';
import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/feature/chat/component/provider.dart';
import 'package:any_chat/feature/chat/presentation/ui/date.dart';
import 'package:any_chat/feature/chat/presentation/ui/message.dart';
import 'package:any_chat/utils/date_time.dart';
import 'package:any_chat/utils/functional.dart';
import 'package:any_chat/utils/page.dart';
import 'package:any_chat/utils/scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:super_paging/super_paging.dart';

final class Chat extends ConsumerStatefulWidget {
  final Pager<int, Message> pager;
  final AutoScrollController scrollController;

  const Chat({
    super.key,
    required this.pager,
    required this.scrollController,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

final class _ChatState extends ConsumerState<Chat> {
  var isPreparedForInitialScroll = false;
  var isInitialScrollDone = false;
  var currentPageOffsetAfterPrepend = 0;

  Pager<int, Message> get pager => widget.pager;
  AutoScrollController get scrollController => widget.scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initListeners());
  }

  @override
  void didUpdateWidget(covariant Chat oldWidget) {
    super.didUpdateWidget(oldWidget);
    removeListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) => initListeners());
  }

  @override
  void dispose() {
    super.dispose();
    removeListeners();
  }

  void initListeners() {
    scrollController.addListener(scrollListener);
    pager.addListener(pagerListener);
  }

  void removeListeners() {
    scrollController.removeListener(scrollListener);
    pager.removeListener(pagerListener);
  }

  void scrollListener() {
    final position = scrollController.positionIndex;
    final page = position?.let(getChatPageByPosition) ?? AppConfig.chatFirstPage;
    final notifier = ref.read(chatNotifierProvider.notifier);
    position?.let(notifier.updateChatPosition);
    notifier.updateChatPage(page); // TODO: придумать алгоритм вычисления страницы
  }

  void pagerListener() {
    if (pager.refreshLoadState is Loading) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
        restorePosition(isAfterRefresh: true),
      );
    } else if (pager.prependLoadState is Loading) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
        restorePosition(isAfterRefresh: false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return Container(
      color: theme.colors.background.primary,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BidirectionalPagingListView.separated(
            pager: pager,
            itemBuilder: (context, index) {
              final message = pager.items.elementAt(index);
              return AutoScrollTag(
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
              );
            },
            errorBuilder: (context, err) => const Text('TODO: Error stub'),
            loadingBuilder: (context) => const AppProgressIndicator(),
            emptyBuilder: (context) => const Text('TODO: Empty stub'),
            controller: scrollController,
            padding: EdgeInsets.only(
              left: theme.dimensions.padding.extraMedium,
              right: theme.dimensions.padding.extraMedium,
              top: theme.dimensions.padding.small,
              bottom: theme.dimensions.padding.small,
            ),
            separatorBuilder: (ctx, idx) =>
              SizedBox(height: theme.dimensions.padding.extraMedium),
          ),
        ],
      ),
    );
  }

  void restorePosition({required bool isAfterRefresh}) {
    // if (!isAfterRefresh && currentPageOffsetAfterPrepend == 0) return;
    // final scrollPosition = ref.read(chatNotifierProvider).scrollPosition;
    //
    // if (scrollPosition != null) {
    //   final pageOffset = ++currentPageOffsetAfterPrepend * AppConfig.chatPageSize;
    //   final itemOffset = scrollPosition % AppConfig.chatPageSize;
    //   final relativeItemPosition = pageOffset + itemOffset;
    //
    //   scrollController.scrollToIndex(
    //     relativeItemPosition,
    //     duration: const Duration(milliseconds: 1),
    //   ).then((_) => --currentPageOffsetAfterPrepend);
    // }
  }
}
