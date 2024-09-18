import 'package:any_chat/feature/chat/presentation/ui/chat.dart';
import 'package:any_chat/feature/chat/presentation/ui/message_text_field.dart';
import 'package:any_chat/feature/chat/provider/chat_notifier.dart';
import 'package:any_chat/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _burgerButtonSize = 24.0;

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

class _ChatState extends ConsumerState<ChatScreen> {
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    ref
      .read(chatNotifierProvider.notifier)
      .loadMessages()
      .then((_) =>
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => scrollToBottom()
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatNotifierProvider);
    final notifier = ref.read(chatNotifierProvider.notifier);
    final theme = ref.watch(appThemeProvider);

    return Scaffold(
      backgroundColor: theme.colors.background.primary,
      appBar: chatBar(context),
      body: Column(
        children: [
          Expanded(
              child: Chat(
                messages: state,
                scrollController: scrollController,
              )
          ),
          MessageTextField(
            controller: messageController,
            onSendClick: () => notifier.sendMessage(
              message: messageController.text,
              onSuccess: () {
                notifier.loadMessages();
                scrollToBottom();
                messageController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar chatBar(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return AppBar(
      leading: burgerButton(),
      title: Text(
        AppLocalizations.of(context)!.app_name,
        style: theme.typography.h.h3.copyWith(
          color: theme.colors.text.onTopBar,
        ),
      ),
      backgroundColor: theme.colors.background.topBar,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(theme.dimensions.radius.extraSmall),
          bottomRight: Radius.circular(theme.dimensions.radius.extraSmall),
        ),
      ),
    );
  }

  Widget burgerButton() {
    final theme = ref.watch(appThemeProvider);

    return IconButton(
      icon: Image(
        image: AssetImage(AppImages.load('ic_burger.png')),
        width: _burgerButtonSize,
        height: _burgerButtonSize,
      ),
      color: theme.colors.button.onTopBar,
      onPressed: () {
        // TODO: on click
      },
    );
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }
}
