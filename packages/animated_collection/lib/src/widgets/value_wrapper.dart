import 'package:meta/meta.dart';

/// A wrapper to handle nullable values.
@internal
class ValueWrapper<T> {
  const ValueWrapper(this.value);

  final T? value;

  @override
  String toString() => 'ValueWrapper($value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ValueWrapper<T>) return false;
    return value == other.value;
  }

  @override
  int get hashCode => value?.hashCode ?? 0;
}
