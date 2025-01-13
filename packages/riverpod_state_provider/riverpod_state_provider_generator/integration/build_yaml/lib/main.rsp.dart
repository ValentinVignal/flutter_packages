// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main.dart';

// **************************************************************************
// RiverpodStateProviderGenerator
// **************************************************************************

@StateProviderFor(myInteger)
final myIntegerProvider = myIntegerStateProvider;

@riverpod
class MyIntegerState extends _$MyIntegerState {
  MyIntegerState({this.overrideInitialState});

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
    on AutoDisposeNotifierProvider<MyIntegerState, int> {
  Override overrideWithValue(int value) {
    return overrideWith(() {
      return MyIntegerState(
        overrideInitialState: _MyIntegerOverrideValue(value),
      );
    });
  }
}

@StateProviderFor(myIntegerKeepAlive)
final myIntegerKeepAliveProvider = myIntegerKeepAliveStateProvider;

@Riverpod(
  keepAlive: true,
)
class MyIntegerKeepAliveState extends _$MyIntegerKeepAliveState {
  MyIntegerKeepAliveState({this.overrideInitialState});

  final _MyIntegerKeepAliveOverrideValue? overrideInitialState;

  @override
  int build() {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return myIntegerKeepAlive();
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

class _MyIntegerKeepAliveOverrideValue {
  const _MyIntegerKeepAliveOverrideValue(this.value);

  final int value;
}

extension MyIntegerKeepAliveRiverpodStateProviderExtension
    on NotifierProvider<MyIntegerKeepAliveState, int> {
  Override overrideWithValue(int value) {
    return overrideWith(() {
      return MyIntegerKeepAliveState(
        overrideInitialState: _MyIntegerKeepAliveOverrideValue(value),
      );
    });
  }
}

@StateProviderFor(myList)
final myListProvider = myListStateProvider;

@riverpod
class MyListState extends _$MyListState {
  MyListState({this.overrideInitialState});

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
    on AutoDisposeNotifierProvider<MyListState, List<int>> {
  Override overrideWithValue(List<int> value) {
    return overrideWith(() {
      return MyListState(
        overrideInitialState: _MyListOverrideValue(value),
      );
    });
  }
}

@StateProviderFor(myListKeepAlive)
final myListKeepAliveProvider = myListKeepAliveStateProvider;

@Riverpod(
  keepAlive: true,
)
class MyListKeepAliveState extends _$MyListKeepAliveState {
  MyListKeepAliveState({this.overrideInitialState});

  final _MyListKeepAliveOverrideValue? overrideInitialState;

  @override
  List<int> build() {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return myListKeepAlive();
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

class _MyListKeepAliveOverrideValue {
  const _MyListKeepAliveOverrideValue(this.value);

  final List<int> value;
}

extension MyListKeepAliveRiverpodStateProviderExtension
    on NotifierProvider<MyListKeepAliveState, List<int>> {
  Override overrideWithValue(List<int> value) {
    return overrideWith(() {
      return MyListKeepAliveState(
        overrideInitialState: _MyListKeepAliveOverrideValue(value),
      );
    });
  }
}

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
