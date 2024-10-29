import 'package:flutter/widgets.dart';

extension ScrollControllerExt on ScrollController {
  void scrollToBottom() {
    if (hasClients) {
      jumpTo(position.maxScrollExtent);
    }
  }
}