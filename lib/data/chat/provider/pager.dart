import 'package:any_chat/data/chat/provider/dio.dart';
import 'package:any_chat/data/chat/pager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pagerProvider = Provider((ref) =>
  ChatPager(client: ref.watch(dioProvider))
);
