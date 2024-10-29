import 'package:any_chat/server/di/server_module.dart';
import 'package:any_chat/server/server.dart';

Future<void> _initDI() {
  di.registerServerModule();
  return di.allReady();
}

void main() async {
  await _initDI();
  await runServer();
}
