import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'colors.dart';
import 'dimensions.dart';
import 'typography.dart';

export 'images.dart';

final appThemeProvider = Provider((ref) => const AppTheme());

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
