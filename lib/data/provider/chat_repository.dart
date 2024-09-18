import 'package:any_chat/data/chat/chat_repository_impl.dart';
import 'package:any_chat/data/provider/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _chatApiBaseUrl = 'http://127.0.0.1:8000/api';

final chatRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ChatRepositoryImpl(client: dio, baseUrl: _chatApiBaseUrl);
});
