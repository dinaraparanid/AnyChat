import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import '../di/app_module.dart';
import 'app.dart';

void main() {
  GetIt.instance.registerAppModule();
  runApp(const ProviderScope(child: App()));
}
