import 'package:get_it/get_it.dart';

import '../ui/theme/theme.dart';

extension AppModule on GetIt {
  void registerAppModule() =>
      this
        ..registerLazySingleton<AppTheme>(() => const AppTheme());
}
