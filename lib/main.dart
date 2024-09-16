import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import '../di/app_module.dart';
import 'app.dart';

void main() {
  GetIt.instance.registerAppModule();
  runApp(App());
}
