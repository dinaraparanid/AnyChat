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

class ChatScreen extends ConsumerWidget {
  final _messageController = TextEditingController();
  final _theme = GetIt.instance<AppTheme>();
  final _provider = GetIt.instance<StateNotifierProvider<ChatNotifier, List<Message>>>();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_provider);
    final notifier = ref.read(_provider.notifier);

    return Scaffold(
      backgroundColor: _theme.colors.background.primary,
      appBar: _chatBar(context),
      body: Column(
        children: [
          Expanded(child: Chat(messages: state)),
          MessageTextField(
            controller: _messageController,
            onSendClick: () => notifier.sendMessage(
                message: _messageController.text,
                onSuccess: () {
                  notifier.loadMessages();
                  _messageController.clear();
                },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _chatBar(BuildContext context) =>
      AppBar(
        leading: _burgerButton(),
        title: Text(
          AppLocalizations.of(context)!.app_name,
          style: _theme.typography.h.h3.copyWith(
            color: _theme.colors.text.onTopBar,
          ),
        ),
        backgroundColor: _theme.colors.background.topBar,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(_theme.dimensions.radius.extraSmall),
            bottomRight: Radius.circular(_theme.dimensions.radius.extraSmall),
          ),
        ),
      );

  Widget _burgerButton() =>
      IconButton(
        icon: Image(
          image: AssetImage(AppImages.load('ic_burger.png')),
          width: _burgerButtonSize,
          height: _burgerButtonSize,
        ),
        color: _theme.colors.button.onTopBar,
        onPressed: () {
          // TODO: on click
        },
      );
}
