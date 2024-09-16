import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimensions.dart';
import 'typography.dart';

@immutable
class AppTheme {
  final AppColors colors;
  final AppDimensions dimensions;
  final AppTypography typography;

  const AppTheme({
    this.colors = const AppColors(),
    this.dimensions = const AppDimensions(),
    this.typography = const AppTypography(),
  });
}