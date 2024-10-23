import 'package:any_chat/server/rooting/router.dart';
import 'package:get_it/get_it.dart';

extension RouterModule on GetIt {
  void registerRouterModule() =>
      registerLazySingleton(() => Router(logger: this()));
}
