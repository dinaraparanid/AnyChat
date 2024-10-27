import 'package:flutter/material.dart';

const _ChineseBlack = Color(0xFF0A1310);
const _ViridianGreen = Color(0xFF029696);
const _TuscanRed = Color(0xFF854C52);
const _Cultured = Color(0xFFF4F4F8);
const _RichBlack = Color(0xFF01363E);
const _DarkVanilla = Color(0xFFD6C1A6);
const _Timberwolf = Color(0xFFDDD8D2);
const _Tomato = Color(0xFFFE4A49);

@immutable
final class AppColors {
  final AppBackgroundColors background;
  final AppTextColors text;
  final AppButtonColors button;
  final AppProgressIndicator indicator;
  final Color error;

  const AppColors({
    this.background = const AppBackgroundColors(),
    this.text = const AppTextColors(),
    this.button = const AppButtonColors(),
    this.indicator = const AppProgressIndicator(),
    this.error = _Tomato,
  });
}

@immutable
final class AppBackgroundColors {
  final Color primary;
  final Color topBar;
  final Color message;
  final Color dateLabel;
  final Color textField;

  const AppBackgroundColors({
    this.primary = _RichBlack,
    this.topBar = _ViridianGreen,
    this.message = _TuscanRed,
    this.dateLabel = _DarkVanilla,
    this.textField = _ChineseBlack,
  });
}

@immutable
final class AppTextColors {
  final Color onTopBar;
  final Color onMessage;
  final Color onDateLabel;
  final Color onTextField;

  const AppTextColors({
    this.onTopBar = _ChineseBlack,
    this.onMessage = _Cultured,
    this.onDateLabel = _ChineseBlack,
    this.onTextField = _Timberwolf,
  });
}

@immutable
final class AppButtonColors {
  final Color onTopBar;
  final Color sendIcon;

  const AppButtonColors({
    this.onTopBar = _ChineseBlack,
    this.sendIcon = _DarkVanilla,
  });
}

@immutable
final class AppProgressIndicator {
  final Color primary;
  final Color background;

  const AppProgressIndicator({
    this.primary = _DarkVanilla,
    this.background = _RichBlack,
  });
}
