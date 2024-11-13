import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/feature/chat/component/provider.dart';
import 'package:any_chat/feature/chat/presentation/ui/page.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nested_scroll_views/material.dart';

final class Chat extends ConsumerStatefulWidget {
  final PageController pagingController;

  const Chat({
    super.key,
    required this.pagingController,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

final class _ChatState extends ConsumerState<Chat> {
  var isPreparedForInitialScroll = false;
  var isInitialScrollDone = false;
  var currentPageOffsetAfterPrepend = 0;

  PageController get pagingController => widget.pagingController;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatNotifierProvider);
    final notifier = ref.read(chatNotifierProvider.notifier);
    final theme = ref.watch(appThemeProvider);

    return Container(
      color: theme.colors.background.primary,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NestedPageView.builder(
            controller: pagingController,
            itemCount: state.pages.length,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (ctx, idx) {
              // TODO: метчить состояния + добавить UiState
              final chunk = state.pages[idx]?.messages ?? IList();
              return ChatPage(messages: chunk);
            },
            onPageChanged: notifier.updateChatPage,
          ),
        ],
      ),
    );
  }
}
