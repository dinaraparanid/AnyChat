import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import 'notifier.dart';
import 'ui/chat.dart';
import 'ui/message_text_field.dart';
import '../../domain/chat/message.dart';
import '../../ui/theme/images.dart';
import '../../ui/theme/theme.dart';

const _burgerButtonSize = 24.0;

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

class _ChatState extends ConsumerState<ChatScreen> {
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  final theme = GetIt.instance<AppTheme>();
  final provider = GetIt.instance<StateNotifierProvider<ChatNotifier, List<Message>>>();

  @override
  void initState() {
    super.initState();

    ref
      .read(provider.notifier)
      .loadMessages()
      .then((_) =>
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => scrollToBottom()
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

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

  AppBar chatBar(BuildContext context) =>
    AppBar(
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

  Widget burgerButton() =>
    IconButton(
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

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }
}