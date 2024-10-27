import 'dart:io';

import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class AppProgressIndicator extends ConsumerWidget {
  const AppProgressIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoActivityIndicator(
        color: theme.colors.indicator.primary,
      );
    } else {
      return CircularProgressIndicator(
        backgroundColor: theme.colors.indicator.background,
        color: theme.colors.indicator.primary,
      );
    }
  }
}
