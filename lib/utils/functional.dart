void doNothing() {}

extension Functional<T> on T {
  R let<R>(R Function(T) transform) => transform(this);
  T also<R>(R Function(T) transform) => this..let(transform);
}
