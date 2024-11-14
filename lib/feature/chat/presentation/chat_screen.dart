import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/feature/chat/component/provider.dart';
import 'package:any_chat/feature/chat/presentation/ui/chat.dart';
import 'package:any_chat/feature/chat/presentation/ui/chat_bar.dart';
import 'package:any_chat/feature/chat/presentation/ui/message_text_field.dart';
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

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(chatNotifierProvider.notifier);
    final theme = ref.watch(appThemeProvider);
    final pager = notifier.pager;

    return Scaffold(
      backgroundColor: theme.colors.background.primary,
      appBar: ChatBar(context: context, theme: theme),
      body: Container(
        color: theme.colors.background.textField,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Chat(
                  pager: pager,
                  scrollController: scrollController,
                )
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
}
