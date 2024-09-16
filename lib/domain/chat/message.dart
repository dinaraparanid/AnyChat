import 'package:flutter/material.dart';

@immutable
class Message {
  final String text;
  final DateTime timestamp;

  const Message({
    required this.text,
    required this.timestamp
  });
}
