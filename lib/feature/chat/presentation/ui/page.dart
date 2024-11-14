import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/domain/chat/message.dart';
import 'package:any_chat/feature/chat/presentation/ui/date.dart';
import 'package:any_chat/feature/chat/presentation/ui/message.dart';
import 'package:any_chat/utils/date_time.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class ChatPage extends ConsumerWidget {
  final IList<Message> messages;
  final VoidCallback scrollToPrevious;
  final VoidCallback scrollToNext;
  final ScrollController controller;

  const ChatPage({
    super.key,
    required this.messages,
    required this.scrollToPrevious,
    required this.scrollToNext,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final position = controller.position;
        if (!position.atEdge) return false;

        if (notification is ScrollEndNotification) {
          final offset = position.pixels;
          if (offset == position.minScrollExtent) scrollToPrevious();
          if (offset == position.maxScrollExtent) scrollToNext();
        }

        return false;
      },
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        controller: controller,
        itemCount: messages.length,
        itemBuilder: (ctx, msgIdx) {
          final message = messages[msgIdx];

          return switch (message.firstForDate) {
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
          };
        },
        separatorBuilder: (ctx, idx) =>
          SizedBox(height: theme.dimensions.padding.extraMedium),
      ),
    );
  }
}