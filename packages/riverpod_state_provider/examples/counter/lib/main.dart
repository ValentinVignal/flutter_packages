import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta_meta.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

// A Counter example implemented with riverpod

void main() {
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    ProviderScope(
      child: ProviderScope(
        overrides: [
          myIntegerProvider.overrideWithValue(42),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

@riverpod
int integer(Ref ref) {
  ref.watch(stateProvider.notifier);
  return 0;
}

final stateProvider = StateProvider.autoDispose<int>((ref) => 0);

@RiverpodStateProvider()
int myInteger() {
  return 0;
}

// API

@Target({TargetKind.function})
class RiverpodStateProvider {
  const RiverpodStateProvider();
}

// Generated
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

  // Remove the protected status
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

// End generated

/// Annotating a class by `@riverpod` defines a new shared state for your application,
/// accessible using the generated [counterProvider].
/// This class is both responsible for initializing the state (through the [build] method)
/// and exposing ways to modify it (cf [increment]).
@riverpod
class Counter extends _$Counter {
  /// Classes annotated by `@riverpod` **must** define a [build] function.
  /// This function is expected to return the initial state of your shared state.
  /// It is totally acceptable for this function to return a [Future] or [Stream] if you need to.
  /// You can also freely define parameters on this method.
  @override
  int build() => 0;

  void increment() => state++;
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    myIntegerProvider.overrideWith(_MyIntegerState.new);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        child: Text(
            '${ref.watch(counterProvider)} - ${ref.watch(myIntegerProvider)}'),
      ),
      floatingActionButton: FloatingActionButton(
        // The read method is a utility to read a provider without listening to it
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
          ref.read(myIntegerProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
