T identity<T>(T value) => value;

extension Functional<T> on T {
  R let<R>(R Function(T) transform) => transform(this);
}
