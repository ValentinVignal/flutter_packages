import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_state_provider_annotation/riverpod_state_provider_annotation.dart';

part 'main.g.dart';
part 'main.rsp.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        child: Text(
          [
            '${ref.watch(counterProvider)}',
            '${ref.watch(myIntegerProvider)}',
          ].join('\n'),
        ),
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
