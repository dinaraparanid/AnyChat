import 'package:any_chat/core/config.dart';

int getChatPageByPosition(int position) {
  final completePagesNum = position ~/ AppConfig.chatPageSize;
  final lastPage = position > completePagesNum * AppConfig.chatPageSize ? 1 : 0;
  return completePagesNum + lastPage;
}
