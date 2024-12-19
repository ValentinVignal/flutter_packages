import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_state_provider_annotation/riverpod_state_provider_annotation.dart';

part 'main.g.dart';
part 'main.rsp.dart';

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

@RiverpodStateProvider()
int myInteger() {
  return 0;
}

@RiverpodStateProvider()
int? myNullableInteger() {
  return 0;
}

@RiverpodStateProvider()
double myDouble() {
  return 0;
}

class MyClass<T> {
  const MyClass({required this.value});

  final T value;
}

@RiverpodStateProvider()
MyClass<int> myClassInteger() {
  return MyClass(value: 0);
}

@RiverpodStateProvider()
Set<int> mySetInteger() {
  return {0};
}

@RiverpodStateProvider()
List<int> myListInteger() {
  return [0];
}

@RiverpodStateProvider()
Map<int, int> myMapInteger() {
  return {0: 0};
}

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

@riverpod
class CounterFamily extends _$CounterFamily {
  /// Classes annotated by `@riverpod` **must** define a [build] function.
  /// This function is expected to return the initial state of your shared state.
  /// It is totally acceptable for this function to return a [Future] or [Stream] if you need to.
  /// You can also freely define parameters on this method.
  @override
  int build(String param) => 0;

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
          [
            '${ref.watch(counterProvider)}',
            '${ref.watch(myIntegerProvider)}',
            '${ref.watch(myNullableIntegerProvider)}',
            '${ref.watch(myDoubleProvider)}',
            '${ref.watch(myClassIntegerProvider).value}',
            '${ref.watch(mySetIntegerProvider)}',
            '${ref.watch(myListIntegerProvider)}',
            '${ref.watch(myMapIntegerProvider)}',
          ].join('\n'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // The read method is a utility to read a provider without listening to it
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
          ref.read(myIntegerProvider.notifier).state++;
          ref
              .read(myNullableIntegerProvider.notifier)
              .update((state) => (state ?? 0) + 1);
          ref.read(myDoubleProvider.notifier).state += 0.5;
          ref
              .read(myClassIntegerProvider.notifier)
              .update((state) => MyClass(value: state.value + 1));
          ref
              .read(mySetIntegerProvider.notifier)
              .update((state) => {state.single + 1});
          ref
              .read(myListIntegerProvider.notifier)
              .update((state) => [state.single + 1]);
          ref
              .read(myMapIntegerProvider.notifier)
              .update((state) => {0: state[0]! + 1});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
