import 'package:any_chat/data/chat/preferences.dart';
import 'package:any_chat/data/preferences/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatPreferences = Provider((ref) =>
  ChatPreferences(prefs: ref.watch(appPreferencesProvider))
);
