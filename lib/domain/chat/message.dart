import 'package:flutter/material.dart';

@immutable
class Message {
  final String text;
  final DateTime timestamp;

  const Message({
    required this.text,
    required this.timestamp
  });

  factory Message.fromJson(dynamic json) => Message(
    text: json['text'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
  );
}
