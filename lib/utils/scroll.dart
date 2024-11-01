import 'package:collection/collection.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

extension AutoScrollExt on AutoScrollController {
  int? get positionIndex => tagMap.keys.maxOrNull;
}
