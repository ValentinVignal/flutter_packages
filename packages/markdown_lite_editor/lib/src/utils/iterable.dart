extension IterableNumExtensions<T extends num> on Iterable<T> {
  /// Returns the maximum value in the iterable.
  T? get maxOrNull {
    if (isEmpty) {
      return null;
    }
    T maxValue = first;
    for (final value in this) {
      if (value > maxValue) {
        maxValue = value;
      }
    }
    return maxValue;
  }
}
