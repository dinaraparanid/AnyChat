import 'dart:convert';

import 'package:any_chat/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class ChatRepositoryImpl extends ChatRepository {
  final Dio client;
  final String baseUrl;

  ChatRepositoryImpl({required this.client, required this.baseUrl});

  @override
  Future<Either<Exception, List<Message>>> getMessages() async {
    try {
      final response = await client.get('$baseUrl/messages/');
      // TODO: убрать эту порнографию, когда будет нормальный сервер
      final String messagesStr = response.data['detail']['messages'].replaceAll('\'', '"');
      final messagesJson = jsonDecode(messagesStr);
      final messages = messagesJson.map(Message.fromJson).toList();
      return Either.right(messages);
    } on Exception catch (e) {
      return Either.left(e);
    }
  }

  @override
  Future<Either<Exception, void>> sendMessage(String text) async {
    try {
      await client.post(
          '$baseUrl/messages/',
          data: { 'text': text, 'timestamp': DateTime.timestamp().toIso8601String() },
      );
      return Either.right(null);
    } on Exception catch (e) {
      return Either.left(e);
    }
  }
}
