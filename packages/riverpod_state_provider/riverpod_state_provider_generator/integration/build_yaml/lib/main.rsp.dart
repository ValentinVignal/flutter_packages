// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main.dart';

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

@StateProviderFor(myList)
final myListProvider = _myListStateProvider;

@riverpod
class _MyListState extends _$MyListState {
  _MyListState({this.overrideInitialState});

  final _MyListOverrideValue? overrideInitialState;

  @override
  List<int> build() {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return myList();
  }

  @override
  List<int> get state => super.state;

  @override
  set state(List<int> value) => super.state = value;

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
  List<int> update(List<int> Function(List<int> state) cb) => state = cb(state);
}

class _MyListOverrideValue {
  const _MyListOverrideValue(this.value);

  final List<int> value;
}

extension MyListRiverpodStateProviderExtension
    on AutoDisposeNotifierProvider<_MyListState, List<int>> {
  Override overrideWithValue(List<int> value) {
    return overrideWith(() {
      return _MyListState(
        overrideInitialState: _MyListOverrideValue(value),
      );
    });
  }
}

@StateProviderFor(myFamilyPositionalParameters)
final myFamilyPositionalParametersProvider =
    _myFamilyPositionalParametersStateProvider;

@riverpod
class _MyFamilyPositionalParametersState
    extends _$MyFamilyPositionalParametersState {
  _MyFamilyPositionalParametersState({this.overrideInitialState});

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
    on _MyFamilyPositionalParametersStateProvider {
  Override overrideWithValue(int value) {
    return overrideWith(() {
      return _MyFamilyPositionalParametersState(
        overrideInitialState: _MyFamilyPositionalParametersOverrideValue(value),
      );
    });
  }
}

@StateProviderFor(myFamilyMixedParameters)
final myFamilyMixedParametersProvider = _myFamilyMixedParametersStateProvider;

@riverpod
class _MyFamilyMixedParametersState extends _$MyFamilyMixedParametersState {
  _MyFamilyMixedParametersState({this.overrideInitialState});

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
    on _MyFamilyMixedParametersStateProvider {
  Override overrideWithValue(List<bool> value) {
    return overrideWith(() {
      return _MyFamilyMixedParametersState(
        overrideInitialState: _MyFamilyMixedParametersOverrideValue(value),
      );
    });
  }
}
