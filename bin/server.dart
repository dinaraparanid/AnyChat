import 'package:any_chat/server/di/server_module.dart';
import 'package:any_chat/server/server.dart';

void _initDI() => di.registerServerModule();

void main() async {
  _initDI();
  await runServer();
}
