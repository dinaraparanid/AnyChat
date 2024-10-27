extension Functional<T> on T {
  R let<R>(R Function(T) transform) => transform(this);
}
