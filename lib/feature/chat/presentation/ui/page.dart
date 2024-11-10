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

  const ChatPage({super.key, required this.messages});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return ListView.separated(
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
    );
  }
}