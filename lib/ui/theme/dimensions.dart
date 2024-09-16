import 'package:flutter/material.dart';

@immutable
class AppDimensions {
  final AppPadding padding;
  final AppRadius radius;

  const AppDimensions({
    this.padding = const AppPadding(),
    this.radius = const AppRadius()
  });
}

@immutable
class AppPadding {
  final double zero;
  final double minimum;
  final double extraSmall;
  final double small;
  final double medium;
  final double extraMedium;
  final double big;
  final double extraBig;
  final double large;
  final double extraLarge;
  final double enormous;

  const AppPadding({
    this.zero = 0.0,
    this.minimum = 2.0,
    this.extraSmall = 4.0,
    this.small = 8.0,
    this.medium = 12.0,
    this.extraMedium = 16.0,
    this.big = 20.0,
    this.extraBig = 24.0,
    this.large = 32.0,
    this.extraLarge = 48.0,
    this.enormous = 64.0,
  });
}

@immutable
class AppRadius {
  final double minimum;
  final double extraSmall;
  final double small;
  final double medium;
  final double extraMedium;

  const AppRadius({
    this.minimum = 4.0,
    this.extraSmall = 8.0,
    this.small = 16.0,
    this.medium = 20.0,
    this.extraMedium = 24.0,
  });
}
