extension FunctionalExtensions<T> on T {
  /// Safe-cast method for statically typed variables.
  /// Will return the caller, [T] as type [R] if [T] is a child or parent
  /// type of [R], otherwise returns null.
  R? castOrNull<R>() => (this is R) ? this as R : null;
}
