import 'dart:io';

import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

PreferredSizeWidget ChatBar({
  required BuildContext context,
  required AppTheme theme,
}) => Platform.isIOS || Platform.isMacOS
  ? _ChatBarCupertino(context: context, theme: theme)
  : _ChatBarMaterial(context: context, theme: theme);

PreferredSizeWidget _ChatBarMaterial({
  required BuildContext context,
  required AppTheme theme,
}) => AppBar(
  leading: BurgerButton(theme: theme),
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

PreferredSizeWidget _ChatBarCupertino({
  required BuildContext context,
  required AppTheme theme,
}) => CupertinoNavigationBar(
  leading: BurgerButton(theme: theme),
  middle: Text(
    AppLocalizations.of(context)!.app_name,
    style: theme.typography.h.h3.copyWith(
      color: theme.colors.text.onTopBar,
    ),
  ),
  backgroundColor: theme.colors.background.topBar,
);

Widget BurgerButton({required AppTheme theme}) => IconButton(
  icon: Image(
    image: AssetImage(AppImages.load('ic_burger.png')),
    width: theme.dimensions.imageSize.big,
    height: theme.dimensions.imageSize.big,
  ),
  color: theme.colors.button.onTopBar,
  onPressed: () {
    // TODO: on click
  },
);
