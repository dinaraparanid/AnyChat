import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../data/di/data_module.dart';
import '../chat/di/chat_module.dart';
import '../ui/theme/theme.dart';

extension AppModule on GetIt {
  void registerAppModule() =>
      this
        ..registerLazySingleton<AppTheme>(() => const AppTheme())
        ..registerLazySingleton<Dio>(
          () => Dio()..interceptors.add(PrettyDioLogger())
        )
        ..registerDataModule()
        ..registerChatModule();
}
