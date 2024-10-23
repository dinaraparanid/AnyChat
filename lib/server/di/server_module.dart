import 'package:any_chat/server/rooting/di/module.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final di = GetIt.instance;

extension ServerModule on GetIt {
  void registerServerModule() {
    registerRouterModule();
    registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
  }
}
