import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get_it/get_it.dart';

import '../../../ui/theme/images.dart';
import '../../../ui/theme/theme.dart';

const _maxLines = 6;
const _sendIconSize = 32.0;

class MessageTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function() onSendClick;

  const MessageTextField({
    super.key,
    required this.controller,
    required this.onSendClick,
  });

  @override
  State<StatefulWidget> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  final _theme = GetIt.instance<AppTheme>();

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.only(
      top: _theme.dimensions.padding.small,
      bottom: _theme.dimensions.padding.medium,
      right: _theme.dimensions.padding.extraMedium,
      left: _theme.dimensions.padding.small,
    ),
    decoration: BoxDecoration(
      color: _theme.colors.background.textField,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(_theme.dimensions.radius.extraSmall),
        topRight: Radius.circular(_theme.dimensions.radius.extraSmall),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: _textField(context)),
        SizedBox(width: _theme.dimensions.padding.extraMedium),
        _sendButton(),
      ],
    ),
  );

  Widget _textField(BuildContext context) => TextField(
    controller: widget.controller,
    decoration: InputDecoration(
      hintText: AppLocalizations.of(context)!.chat_message_hint,
      hintStyle: _theme.typography.body.copyWith(
        color: _theme.colors.text.onTextField.withOpacity(0.5),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: _theme.colors.text.onTextField),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _theme.colors.text.onTextField),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _theme.colors.button.sendIcon),
      ),
    ),
    style: _theme.typography.body.copyWith(
        color: _theme.colors.text.onTextField,
    ),
    cursorColor: _theme.colors.text.onTextField,
    minLines: 1,
    maxLines: _maxLines,
  );

  Widget _sendButton() => IconButton(
    icon: Image(
      image: AssetImage(AppImages.load('ic_send.png')),
      width: _sendIconSize,
      height: _sendIconSize,
    ),
    color: _theme.colors.button.sendIcon,
    onPressed: widget.onSendClick,
  );
}
