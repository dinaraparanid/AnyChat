import 'package:fpdart/fpdart.dart';

extension IterableExt<T> on Iterable<T> {
  Iterable<T> distinct(Function(T)? keySelector) =>
    _DistinctIterable(this, keySelector);

  int? positionWhere(Function(T) predicate) {
    var i = 0;

    for (final item in this) {
      if (predicate(item)) {
        return i;
      }

      ++i;
    }

    return null;
  }
}

class _DistinctIterable<T> extends Iterable<T> {
  final Iterable<T> _iterable;
  final Function(T) _keySelector;
  final Map<dynamic, T> uniqueElements = {};

  _DistinctIterable(this._iterable, Function(T)? keySelector) :
    _keySelector = keySelector ?? identity;

  @override
  Iterator<T> get iterator {
    for (final element in _iterable) {
      final key = _keySelector(element);

      if (!uniqueElements.containsKey(key)) {
        uniqueElements[key] = element;
      }
    }

    return uniqueElements.values.iterator;
  }
}