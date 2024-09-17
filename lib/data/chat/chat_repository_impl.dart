import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:fpdart/fpdart.dart';

import '../../domain/chat/message.dart';
import '../../domain/chat/message_count.dart';
import '../../domain/chat/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final Dio client;
  final String baseUrl;

  ChatRepositoryImpl({required this.client, required this.baseUrl});

  @override
  Future<Either<Exception, MessageCount>> getMessageCount() async {
    try {
      final response = await client.get('$baseUrl/messages/count/');
      return Either.right(MessageCount(count: response.data['detail']['count'] as int));
    } on Exception catch (e) {
      return Either.left(e);
    }
  }

  @override
  Future<Either<Exception, List<Message>>> getMessages() async {
    try {
      final response = await client.get('$baseUrl/messages/');
      // TODO: убрать эту порнографию, когда будет нормальный сервер
      final String messagesStr = response.data['detail']['messages'].replaceAll('\'', '"');
      final messagesJson = jsonDecode(messagesStr) as List<dynamic>;
      final messages = messagesJson.map(Message.fromJson).toList();
      return Either.right(messages);
    } on Exception catch (e) {
      return Either.left(e);
    }
  }

  @override
  Future<Either<Exception, void>> sendMessage(String text) async {
    try {
      // TODO: убрать эту порнографию, когда будет нормальный сервер
      await client.post(
          '$baseUrl/messages/',
          data: { 'text': text, 'timestamp': DateTime.timestamp().toIso8601String() },
      );
      return Either.right(null);
    } on Exception catch (e) {
      print(e);
      return Either.left(e);
    }
  }
}
