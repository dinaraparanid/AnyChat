import 'dart:io';

import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _maxLines = 6;

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

  Widget InputTextField(BuildContext context) =>
    Platform.isIOS || Platform.isMacOS
      ? InputTextFieldCupertino(context)
      : InputTextFieldMaterial(context);

  Widget InputTextFieldCupertino(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return CupertinoTextField(
      controller: widget.controller,
      placeholder: AppLocalizations.of(context)!.chat_message_hint,
      placeholderStyle: theme.typography.body.copyWith(
        color: theme.colors.text.onTextField.withOpacity(0.5),
      ),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      style: theme.typography.body.copyWith(
        color: theme.colors.text.onTextField,
      ),
      cursorColor: theme.colors.text.onTextField,
      minLines: 1,
      maxLines: _maxLines,
      onChanged: (_) => setState(() {}),
    );
  }

  Widget InputTextFieldMaterial(BuildContext context) {
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
          borderSide: BorderSide(color: theme.colors.button.icon),
        ),
      ),
      style: theme.typography.body.copyWith(
        color: theme.colors.text.onTextField,
      ),
      cursorColor: theme.colors.text.onTextField,
      minLines: 1,
      maxLines: _maxLines,
      onChanged: (_) => setState(() {}),
    );
  }

  Widget SendButton() {
    final theme = ref.watch(appThemeProvider);
    final isNotEnabled = widget.controller.text.isBlank;
    final activeColor = theme.colors.button.icon;
    final color = isNotEnabled ? activeColor.withOpacity(0.5) : activeColor;

    return IconButton(
      icon: Image(
        image: AssetImage(AppImages.load('ic_send.png')),
        width: theme.dimensions.imageSize.extraBig,
        height: theme.dimensions.imageSize.extraBig,
        color: color,
      ),
      color: color,
      onPressed: isNotEnabled ? null : widget.onSendClick,
    );
  }
}
