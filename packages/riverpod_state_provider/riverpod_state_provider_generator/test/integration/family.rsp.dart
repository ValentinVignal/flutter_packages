// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family.dart';

// **************************************************************************
// RiverpodStateProviderGenerator
// **************************************************************************

@Deprecated('Use myFamilyPositionalParametersStateProvider instead')
@StateProviderFor(myFamilyPositionalParameters)
final myFamilyPositionalParametersProvider =
    myFamilyPositionalParametersStateProvider;

@riverpod
class MyFamilyPositionalParametersState
    extends _$MyFamilyPositionalParametersState {
  MyFamilyPositionalParametersState({this.overrideInitialState});

  final _MyFamilyPositionalParametersOverrideValue? overrideInitialState;

  @override
  int build(
    String param1,
    int param2,
    bool param3, [
    double param4 = 0.0,
    List<int>? param5,
  ]) {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return myFamilyPositionalParameters(
      ref,
      param1,
      param2,
      param3,
      param4,
      param5,
    );
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

class _MyFamilyPositionalParametersOverrideValue {
  const _MyFamilyPositionalParametersOverrideValue(this.value);

  final int value;
}

extension MyFamilyPositionalParametersRiverpodStateProviderExtension
    on MyFamilyPositionalParametersStateProvider {
  Override overrideWithValue(int value) {
    return overrideWith(() {
      return MyFamilyPositionalParametersState(
        overrideInitialState: _MyFamilyPositionalParametersOverrideValue(value),
      );
    });
  }
}

@Deprecated('Use myFamilyMixedParametersStateProvider instead')
@StateProviderFor(myFamilyMixedParameters)
final myFamilyMixedParametersProvider = myFamilyMixedParametersStateProvider;

@riverpod
class MyFamilyMixedParametersState extends _$MyFamilyMixedParametersState {
  MyFamilyMixedParametersState({this.overrideInitialState});

  final _MyFamilyMixedParametersOverrideValue? overrideInitialState;

  @override
  List<bool> build(
    String param1,
    int param2, {
    required bool param3,
    double param4 = 0.0,
    List<int>? param5,
  }) {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return myFamilyMixedParameters(
      ref,
      param1,
      param2,
      param3: param3,
      param4: param4,
      param5: param5,
    );
  }

  @override
  List<bool> get state => super.state;

  @override
  set state(List<bool> value) => super.state = value;

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
  List<bool> update(List<bool> Function(List<bool> state) cb) =>
      state = cb(state);
}

class _MyFamilyMixedParametersOverrideValue {
  const _MyFamilyMixedParametersOverrideValue(this.value);

  final List<bool> value;
}

extension MyFamilyMixedParametersRiverpodStateProviderExtension
    on MyFamilyMixedParametersStateProvider {
  Override overrideWithValue(List<bool> value) {
    return overrideWith(() {
      return MyFamilyMixedParametersState(
        overrideInitialState: _MyFamilyMixedParametersOverrideValue(value),
      );
    });
  }
}
