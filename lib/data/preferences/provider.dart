import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

final appPreferencesProvider = Provider((_) =>
  RxSharedPreferences(SharedPreferences.getInstance()),
);
