import 'package:any_chat/data/chat/pager.dart';
import 'package:any_chat/data/chat/provider/dio.dart';
import 'package:any_chat/data/chat/provider/preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatPagerProvider = Provider((ref) => ChatPagingSourceImpl(
  client: ref.watch(dioProvider),
  preferences: ref.watch(chatPreferencesProvider),
));
