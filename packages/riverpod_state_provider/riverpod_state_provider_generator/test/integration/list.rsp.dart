// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list.dart';

// **************************************************************************
// RiverpodStateProviderGenerator
// **************************************************************************

@Deprecated('Use myListStateProvider instead')
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
