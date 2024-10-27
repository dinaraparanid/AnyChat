import 'package:any_chat/server/data/chat/repository_impl.dart';
import 'package:any_chat/server/data/sqflite/db.dart';
import 'package:any_chat/server/domain/chat/repository.dart';
import 'package:get_it/get_it.dart';

extension DataModule on GetIt {
  void registerDataModule() {
    registerSingletonAsync<ServerDatabaseProvider>(() async =>
      await ServerDatabaseProvider.init()
    );

    registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(this()));
  }
}
