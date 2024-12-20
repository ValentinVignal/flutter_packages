## `riverpod_state_provider_generator`.

This project is a wrapper around [`riverpod_generator`](https://pub.dev/packages/riverpod_generator).

`StateProvider` from [`riverpod`](https://pub.dev/packages/riverpod) is not currently supported with `riverpod_generator`.

- https://github.com/rrousselGit/riverpod/issues/3610
- https://github.com/rrousselGit/riverpod/discussions/3608
- https://github.com/rrousselGit/riverpod/discussions/1725
- https://github.com/rrousselGit/riverpod/discussions/2253
- https://github.com/rrousselGit/riverpod/discussions/2239

This allows to generate the equivalent of `StateProvider`s from `riverpod`:

Long story short:

```dart
// main.dart

part 'main.g.dart';
part 'main.rsp.dart';

@RiverpodStateProvider()
int myInteger() {
  return 0;
}
```

Add `riverpod_state_provider_generator`, `riverpod_generator` and `build_runner` to your `dev_dependencies` and run

```shell
dart run build_runner build -d
```
