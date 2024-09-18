import 'package:any_chat/data/data.dart';
import 'package:any_chat/domain/domain.dart';
import 'package:any_chat/feature/chat/presentation/notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatNotifierProvider = StateNotifierProvider<ChatNotifier, List<Message>>(
  (ref) => ChatNotifier(ref.watch(chatRepositoryProvider)),
);
