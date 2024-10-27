import 'package:any_chat/data/data.dart';
import 'package:any_chat/feature/chat/component/notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatNotifierProvider = StateNotifierProvider<ChatNotifier, void>(
  (ref) => ChatNotifier(ref.watch(chatRepositoryProvider)),
);
