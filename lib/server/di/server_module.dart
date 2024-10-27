import 'package:any_chat/server/data/di/data_module.dart';
import 'package:any_chat/server/rooting/di/module.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final di = GetIt.instance;

extension ServerModule on GetIt {
  void registerServerModule() {
    registerDataModule();
    registerRouterModule();
    registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
  }
}
