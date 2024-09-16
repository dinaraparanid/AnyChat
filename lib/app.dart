import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get_it/get_it.dart';

import '/ui/theme/theme.dart';
import 'chat/presentation/chat_screen.dart';

class App extends StatelessWidget {
  App({super.key});

  final AppTheme _theme = GetIt.instance<AppTheme>();

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: "AnyChat",
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: ChatScreen(),
  );
}
