import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/feature/chat/component/provider.dart';
import 'package:any_chat/utils/scroll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:super_paging/super_paging.dart';

const _visibilityAnimDuration = Duration(milliseconds: 300);

final class ScrollDownButton extends ConsumerWidget {
  final AutoScrollController scrollController;

  const ScrollDownButton({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(chatNotifierProvider);

    return Visibility(
      maintainAnimation: true,
      maintainState: true,
      visible: state.isScrollDownButtonVisible,
      child: AnimatedOpacity(
        curve: Curves.fastOutSlowIn,
        duration: _visibilityAnimDuration,
        opacity: state.isScrollDownButtonVisible ? 1 : 0,
        child: FloatingActionButton(
          backgroundColor: theme.colors.button.fab,
          shape: const CircleBorder(),
          onPressed: () => scrollController.scrollToIndex(
            ref.read(chatNotifierProvider.notifier).pager.items.length,
          ),
          child: Icon(
            CupertinoIcons.chevron_down,
            size: theme.dimensions.imageSize.extraBig,
            color: theme.colors.button.icon,
          ),
        ),
      ),
    );
  }
}