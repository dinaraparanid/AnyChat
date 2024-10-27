import 'package:any_chat/core/ui/theme/theme.dart';
import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/utils/date_time_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class MessageUi extends ConsumerWidget {
  final Message msg;
  final Alignment contentAlignment;

  const MessageUi({
    super.key,
    required this.msg,
    this.contentAlignment = Alignment.centerRight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return Container(
      alignment: contentAlignment,
      child: Card(
        color: theme.colors.background.message,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.dimensions.radius.extraMedium),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: theme.dimensions.padding.medium,
            bottom: theme.dimensions.padding.small,
            left: theme.dimensions.padding.medium,
            right: theme.dimensions.padding.medium,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                msg.text,
                style: theme.typography.body.copyWith(
                  color: theme.colors.text.onMessage,
                ),
              ),

              SizedBox(height: theme.dimensions.padding.small),

              Text(
                msg.createdAt.timeFormat,
                style: theme.typography.caption.copyWith(
                  color: theme.colors.text.onMessage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
