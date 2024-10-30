import 'package:any_chat/domain/chat/store.dart';

import 'api.dart';

abstract class ChatRepository with ChatApi, ChatStore {}
