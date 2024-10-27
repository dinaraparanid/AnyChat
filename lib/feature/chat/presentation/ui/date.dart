import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class DateUi extends ConsumerWidget {
  final String dayMonth;
  const DateUi({super.key, required this.dayMonth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return Container(
      alignment: Alignment.center,
      child: Card(
        color: theme.colors.background.dateLabel,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            theme.dimensions.radius.extraMedium
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: theme.dimensions.padding.small,
            horizontal: theme.dimensions.padding.extraMedium,
          ),
          child: Text(
            dayMonth,
            style: theme.typography.regular.copyWith(
              color: theme.colors.text.onDateLabel,
            ),
          ),
        ),
      ),
    );
  }
}