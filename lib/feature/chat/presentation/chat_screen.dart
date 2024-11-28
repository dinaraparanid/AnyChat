import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/feature/chat/component/notifier.dart';
import 'package:any_chat/feature/chat/component/provider.dart';
import 'package:any_chat/feature/chat/presentation/ui/chat.dart';
import 'package:any_chat/feature/chat/presentation/ui/chat_bar.dart';
import 'package:any_chat/feature/chat/presentation/ui/message_text_field.dart';
import 'package:any_chat/feature/chat/presentation/ui/scroll_down_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

final class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

final class _ChatState extends ConsumerState<ChatScreen> {
  final messageController = TextEditingController();
  final scrollController = AutoScrollController();

  ChatNotifier get notifier => ref.read(chatNotifierProvider.notifier);
  AppTheme get theme => ref.watch(appThemeProvider);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: theme.colors.background.primary,
    appBar: ChatBar(context: context, theme: theme),
    body: Container(
      color: theme.colors.background.textField,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Chat(scrollController: scrollController),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: theme.dimensions.padding.extraMedium,
                      right: theme.dimensions.padding.extraMedium,
                    ),
                    child: ScrollDownButton(scrollController: scrollController),
                  ),
                ],
              ),
            ),
            MessageTextField(
              controller: messageController,
              onSendClick: () => notifier.sendMessage(
                message: messageController.text,
                onSuccess: messageController.clear,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
