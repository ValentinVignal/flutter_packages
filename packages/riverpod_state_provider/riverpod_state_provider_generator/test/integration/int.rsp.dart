// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'int.dart';

// **************************************************************************
// RiverpodStateProviderGenerator
// **************************************************************************

@StateProviderFor(myInteger)
final myIntegerProvider = _myIntegerStateProvider;

@riverpod
class _MyIntegerState extends _$MyIntegerState {
  _MyIntegerState({this.overrideInitialState});

  final _MyIntegerOverrideValue? overrideInitialState;

  @override
  int build() {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return myInteger();
  }

  @override
  int get state => super.state;

  @override
  set state(int value) => super.state = value;

  /// Calls a function with the current [state] and assigns the result as the
  /// new state.
  ///
  /// This allows simplifying the syntax for updating the state when the update
  /// depends on the previous state, such that rather than:
  ///
  /// ```dart
  /// ref.read(provider.notifier).state = ref.read(provider.notifier).state + 1;
  /// ```
  ///
  /// we can do:
  ///
  /// ```dart
  /// ref.read(provider.notifier).update((state) => state + 1);
  /// ```
  int update(int Function(int state) cb) => state = cb(state);
}

class _MyIntegerOverrideValue {
  const _MyIntegerOverrideValue(this.value);

  final int value;
}

extension MyIntegerRiverpodStateProviderExtension
    on AutoDisposeNotifierProvider<_MyIntegerState, int> {
  Override overrideWithValue(int value) {
    return overrideWith(() {
      return _MyIntegerState(
        overrideInitialState: _MyIntegerOverrideValue(value),
      );
    });
  }
}
