/// Stores the value to override a state provider with.
///
/// Exposed only for code generated by
/// `package:riverpod_state_provider_generator`. Not meant to be used directly
/// by user code.
class ValueOverride<T> {
  const ValueOverride(this.value);

  final T value;
}
