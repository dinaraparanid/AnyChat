import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';

import '../data/di/data_module.dart';
import '../ui/theme/theme.dart';

extension AppModule on GetIt {
  void registerAppModule() =>
      this
        ..registerLazySingleton<AppTheme>(() => const AppTheme())
        ..registerLazySingleton<Dio>(() => Dio())
        ..registerDataModule();
}
