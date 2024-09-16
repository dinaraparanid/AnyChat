import 'package:any_chat/data/chat/chat_repository_impl.dart';
import 'package:any_chat/domain/chat/chat_repository.dart';
import 'package:get_it/get_it.dart';

const _chatApiBaseUrl = 'http:127.0.0.1:8000/api';

extension DataModule on GetIt {
  void registerDataModule() =>
      this..registerLazySingleton<ChatRepository>(
        () => ChatRepositoryImpl(client: this(), baseUrl: _chatApiBaseUrl)
      );
}
