import 'package:any_chat/data/chat/provider/dio.dart';
import 'package:any_chat/data/chat/provider/pager.dart';
import 'package:any_chat/data/chat/provider/preferences.dart';
import 'package:any_chat/data/chat/repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRepositoryProvider = Provider((ref) =>
  ChatRepositoryImpl(
    client: ref.watch(dioProvider),
    pager: ref.watch(chatPagerProvider),
    preferences: ref.watch(chatPreferencesProvider),
  )
);
