import 'package:any_chat/chat/presentation/ui/chat.dart';
import 'package:any_chat/chat/presentation/ui/message_text_field.dart';
import 'package:any_chat/domain/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get_it/get_it.dart';

import '../../ui/theme/images.dart';
import '../../ui/theme/theme.dart';

const _burgerButtonSize = 24.0;

class ChatScreen extends StatelessWidget {
  final _messageController = TextEditingController();
  final _theme = GetIt.instance<AppTheme>();
  
  final _messagesPlaceholder = [
    Message(
        text: "I ended up in the back of a flashing car\n"
            "With the city shining on my face\n"
            "The lights are blinding me again",
        timestamp: DateTime(2024, 9, 15, 14, 55),
    ),
    Message(
      text: "I ended up in the back of a flashing car\n"
          "With the city shining on my face\n"
          "The lights are blinding me again",
      timestamp: DateTime(2024, 9, 17, 14, 55),
    ),
    Message(
      text: "I ended up in the back of a flashing car\n"
          "With the city shining on my face\n"
          "The lights are blinding me again",
      timestamp: DateTime(2024, 9, 17, 15, 55),
    )
  ];

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: _theme.colors.background.primary,
        appBar: _chatBar(context),
        body: Column(
          children: [
            Expanded(child: Chat(messages: _messagesPlaceholder)),
            MessageTextField(controller: _messageController),
          ],
        ),
      );

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
