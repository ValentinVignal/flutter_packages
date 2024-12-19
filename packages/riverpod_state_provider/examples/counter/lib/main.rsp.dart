// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main.dart';

// **************************************************************************
// RiverpodStateProviderGenerator
// **************************************************************************

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

final myNullableIntegerProvider = _myNullableIntegerStateProvider;

@riverpod
class _MyNullableIntegerState extends _$MyNullableIntegerState {
  _MyNullableIntegerState({this.overrideInitialState});

  final _MyNullableIntegerOverrideValue? overrideInitialState;

  @override
  int? build() {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return myNullableInteger();
  }

  @override
  int? get state => super.state;

  @override
  set state(int? value) => super.state = value;

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
  int? update(int? Function(int? state) cb) => state = cb(state);
}

class _MyNullableIntegerOverrideValue {
  const _MyNullableIntegerOverrideValue(this.value);

  final int? value;
}

extension MyNullableIntegerRiverpodStateProviderExtension
    on AutoDisposeNotifierProvider<_MyNullableIntegerState, int?> {
  Override overrideWithValue(int? value) {
    return overrideWith(() {
      return _MyNullableIntegerState(
        overrideInitialState: _MyNullableIntegerOverrideValue(value),
      );
    });
  }
}

final myDoubleProvider = _myDoubleStateProvider;

@riverpod
class _MyDoubleState extends _$MyDoubleState {
  _MyDoubleState({this.overrideInitialState});

  final _MyDoubleOverrideValue? overrideInitialState;

  @override
  double build() {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return myDouble();
  }

  @override
  double get state => super.state;

  @override
  set state(double value) => super.state = value;

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
  double update(double Function(double state) cb) => state = cb(state);
}

class _MyDoubleOverrideValue {
  const _MyDoubleOverrideValue(this.value);

  final double value;
}

extension MyDoubleRiverpodStateProviderExtension
    on AutoDisposeNotifierProvider<_MyDoubleState, double> {
  Override overrideWithValue(double value) {
    return overrideWith(() {
      return _MyDoubleState(
        overrideInitialState: _MyDoubleOverrideValue(value),
      );
    });
  }
}

final myClassIntegerProvider = _myClassIntegerStateProvider;

@riverpod
class _MyClassIntegerState extends _$MyClassIntegerState {
  _MyClassIntegerState({this.overrideInitialState});

  final _MyClassIntegerOverrideValue? overrideInitialState;

  @override
  MyClass<int> build() {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return myClassInteger();
  }

  @override
  MyClass<int> get state => super.state;

  @override
  set state(MyClass<int> value) => super.state = value;

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
  MyClass<int> update(MyClass<int> Function(MyClass<int> state) cb) =>
      state = cb(state);
}

class _MyClassIntegerOverrideValue {
  const _MyClassIntegerOverrideValue(this.value);

  final MyClass<int> value;
}

extension MyClassIntegerRiverpodStateProviderExtension
    on AutoDisposeNotifierProvider<_MyClassIntegerState, MyClass<int>> {
  Override overrideWithValue(MyClass<int> value) {
    return overrideWith(() {
      return _MyClassIntegerState(
        overrideInitialState: _MyClassIntegerOverrideValue(value),
      );
    });
  }
}

final mySetIntegerProvider = _mySetIntegerStateProvider;

@riverpod
class _MySetIntegerState extends _$MySetIntegerState {
  _MySetIntegerState({this.overrideInitialState});

  final _MySetIntegerOverrideValue? overrideInitialState;

  @override
  Set<int> build() {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return mySetInteger();
  }

  @override
  Set<int> get state => super.state;

  @override
  set state(Set<int> value) => super.state = value;

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
  Set<int> update(Set<int> Function(Set<int> state) cb) => state = cb(state);
}

class _MySetIntegerOverrideValue {
  const _MySetIntegerOverrideValue(this.value);

  final Set<int> value;
}

extension MySetIntegerRiverpodStateProviderExtension
    on AutoDisposeNotifierProvider<_MySetIntegerState, Set<int>> {
  Override overrideWithValue(Set<int> value) {
    return overrideWith(() {
      return _MySetIntegerState(
        overrideInitialState: _MySetIntegerOverrideValue(value),
      );
    });
  }
}

final myListIntegerProvider = _myListIntegerStateProvider;

@riverpod
class _MyListIntegerState extends _$MyListIntegerState {
  _MyListIntegerState({this.overrideInitialState});

  final _MyListIntegerOverrideValue? overrideInitialState;

  @override
  List<int> build() {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return myListInteger();
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

class _MyListIntegerOverrideValue {
  const _MyListIntegerOverrideValue(this.value);

  final List<int> value;
}

extension MyListIntegerRiverpodStateProviderExtension
    on AutoDisposeNotifierProvider<_MyListIntegerState, List<int>> {
  Override overrideWithValue(List<int> value) {
    return overrideWith(() {
      return _MyListIntegerState(
        overrideInitialState: _MyListIntegerOverrideValue(value),
      );
    });
  }
}

final myMapIntegerProvider = _myMapIntegerStateProvider;

@riverpod
class _MyMapIntegerState extends _$MyMapIntegerState {
  _MyMapIntegerState({this.overrideInitialState});

  final _MyMapIntegerOverrideValue? overrideInitialState;

  @override
  Map<int, int> build() {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return myMapInteger();
  }

  @override
  Map<int, int> get state => super.state;

  @override
  set state(Map<int, int> value) => super.state = value;

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
  Map<int, int> update(Map<int, int> Function(Map<int, int> state) cb) =>
      state = cb(state);
}

class _MyMapIntegerOverrideValue {
  const _MyMapIntegerOverrideValue(this.value);

  final Map<int, int> value;
}

extension MyMapIntegerRiverpodStateProviderExtension
    on AutoDisposeNotifierProvider<_MyMapIntegerState, Map<int, int>> {
  Override overrideWithValue(Map<int, int> value) {
    return overrideWith(() {
      return _MyMapIntegerState(
        overrideInitialState: _MyMapIntegerOverrideValue(value),
      );
    });
  }
}
