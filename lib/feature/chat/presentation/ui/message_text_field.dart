import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _maxLines = 6;
const _sendIconSize = 32.0;

final class MessageTextField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final void Function() onSendClick;

  const MessageTextField({
    super.key,
    required this.controller,
    required this.onSendClick,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MessageTextFieldState();
}

final class _MessageTextFieldState extends ConsumerState<MessageTextField> {

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return Container(
      padding: EdgeInsets.only(
        top: theme.dimensions.padding.small,
        bottom: theme.dimensions.padding.medium,
        right: theme.dimensions.padding.extraMedium,
        left: theme.dimensions.padding.small,
      ),
      decoration: BoxDecoration(
        color: theme.colors.background.textField,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(theme.dimensions.radius.extraSmall),
          topRight: Radius.circular(theme.dimensions.radius.extraSmall),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: InputTextField(context)),
          SizedBox(width: theme.dimensions.padding.extraMedium),
          SendButton(),
        ],
      ),
    );
  }

  Widget InputTextField(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.chat_message_hint,
        hintStyle: theme.typography.body.copyWith(
          color: theme.colors.text.onTextField.withOpacity(0.5),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colors.text.onTextField),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colors.text.onTextField),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colors.button.sendIcon),
        ),
      ),
      style: theme.typography.body.copyWith(
        color: theme.colors.text.onTextField,
      ),
      cursorColor: theme.colors.text.onTextField,
      minLines: 1,
      maxLines: _maxLines,
    );
  }

  Widget SendButton() {
    final theme = ref.watch(appThemeProvider);

    return IconButton(
      icon: Image(
        image: AssetImage(AppImages.load('ic_send.png')),
        width: _sendIconSize,
        height: _sendIconSize,
      ),
      color: theme.colors.button.sendIcon,
      onPressed: widget.onSendClick,
    );
  }
}
