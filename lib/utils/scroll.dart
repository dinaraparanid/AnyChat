import 'package:any_chat/utils/functional.dart';
import 'package:collection/collection.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

extension AutoScrollExt on AutoScrollController {
  int? get positionIndex => tagMap.keys
    .sorted(Comparable.compare)
    .let((keys) => keys[keys.length ~/ 2]);

  Iterable<int> get visibleIndices => tagMap.keys;
}
