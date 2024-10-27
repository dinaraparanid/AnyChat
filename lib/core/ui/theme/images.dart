import 'package:flutter/cupertino.dart';

@immutable
final class AppImages {
  const AppImages._();

  static String load(String file) => 'assets/$file';
}
