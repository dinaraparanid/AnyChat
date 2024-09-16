import 'package:flutter/material.dart';

@immutable
class AppTypography {
  final AppHTypo h;
  final TextStyle body;
  final TextStyle regular;
  final TextStyle caption;
  final TextStyle captionSm;

  const AppTypography({
    this.h = const AppHTypo(),
    this.body = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      letterSpacing: 0,
    ),
    this.regular = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: 0.4,
    ),
    this.caption = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: 0.4,
    ),
    this.captionSm = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 10,
      letterSpacing: 0,
    ),
  });
}

@immutable
class AppHTypo {
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;

  const AppHTypo({
    this.h1 = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 32,
      letterSpacing: 0,
    ),
    this.h2 = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 24,
      letterSpacing: 0,
    ),
    this.h3 = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: 0,
    ),
  });
}
