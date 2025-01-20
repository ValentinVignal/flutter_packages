// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main.dart';

// **************************************************************************
// RiverpodStateProviderGenerator
// **************************************************************************

@StateProviderFor(myInteger)
@riverpod
class MyIntegerState extends _$MyIntegerState {
  MyIntegerState({this.overrideInitialState});

  final ValueOverride<int>? overrideInitialState;

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

extension MyIntegerRiverpodStateProviderExtension
    on AutoDisposeNotifierProvider<MyIntegerState, int> {
  Override overrideWithValue(int value) {
    return overrideWith(() {
      return MyIntegerState(
        overrideInitialState: ValueOverride<int>(value),
      );
    });
  }
}

@StateProviderFor(myIntegerKeepAlive)
@Riverpod(
  keepAlive: true,
)
class MyIntegerKeepAliveState extends _$MyIntegerKeepAliveState {
  MyIntegerKeepAliveState({this.overrideInitialState});

  final ValueOverride<int>? overrideInitialState;

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

extension MyIntegerKeepAliveRiverpodStateProviderExtension
    on NotifierProvider<MyIntegerKeepAliveState, int> {
  Override overrideWithValue(int value) {
    return overrideWith(() {
      return MyIntegerKeepAliveState(
        overrideInitialState: ValueOverride<int>(value),
      );
    });
  }
}

@StateProviderFor(myList)
@riverpod
class MyListState extends _$MyListState {
  MyListState({this.overrideInitialState});

  final ValueOverride<List<int>>? overrideInitialState;

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

extension MyListRiverpodStateProviderExtension
    on AutoDisposeNotifierProvider<MyListState, List<int>> {
  Override overrideWithValue(List<int> value) {
    return overrideWith(() {
      return MyListState(
        overrideInitialState: ValueOverride<List<int>>(value),
      );
    });
  }
}

@StateProviderFor(myListKeepAlive)
@Riverpod(
  keepAlive: true,
)
class MyListKeepAliveState extends _$MyListKeepAliveState {
  MyListKeepAliveState({this.overrideInitialState});

  final ValueOverride<List<int>>? overrideInitialState;

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

extension MyListKeepAliveRiverpodStateProviderExtension
    on NotifierProvider<MyListKeepAliveState, List<int>> {
  Override overrideWithValue(List<int> value) {
    return overrideWith(() {
      return MyListKeepAliveState(
        overrideInitialState: ValueOverride<List<int>>(value),
      );
    });
  }
}

@StateProviderFor(myFamilyPositionalParameters)
@riverpod
class MyFamilyPositionalParametersState
    extends _$MyFamilyPositionalParametersState {
  MyFamilyPositionalParametersState({this.overrideInitialState});

  final ValueOverride<int>? overrideInitialState;

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

extension MyFamilyPositionalParametersRiverpodStateProviderExtension
    on MyFamilyPositionalParametersStateProvider {
  Override overrideWithValue(int value) {
    return overrideWith(() {
      return MyFamilyPositionalParametersState(
        overrideInitialState: ValueOverride<int>(value),
      );
    });
  }
}

@StateProviderFor(myFamilyMixedParameters)
@riverpod
class MyFamilyMixedParametersState extends _$MyFamilyMixedParametersState {
  MyFamilyMixedParametersState({this.overrideInitialState});

  final ValueOverride<List<bool>>? overrideInitialState;

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

extension MyFamilyMixedParametersRiverpodStateProviderExtension
    on MyFamilyMixedParametersStateProvider {
  Override overrideWithValue(List<bool> value) {
    return overrideWith(() {
      return MyFamilyMixedParametersState(
        overrideInitialState: ValueOverride<List<bool>>(value),
      );
    });
  }
}
