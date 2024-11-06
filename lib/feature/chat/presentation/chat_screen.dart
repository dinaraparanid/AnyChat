import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/feature/chat/component/provider.dart';
import 'package:any_chat/feature/chat/presentation/ui/chat.dart';
import 'package:any_chat/feature/chat/presentation/ui/message_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

const _burgerButtonSize = 24.0;

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
      appBar: ChatBar(context),
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

  AppBar ChatBar(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return AppBar(
      leading: BurgerButton(),
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

  Widget BurgerButton() {
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
}
