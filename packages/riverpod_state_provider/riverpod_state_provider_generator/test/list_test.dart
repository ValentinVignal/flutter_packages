import 'package:test/test.dart';

import 'integration/list.dart';
import 'utils.dart';

void main() {
  test('Creates an equivalent of the StateProvider for an list of integer', () {
    final container = createContainer();

    var value = container.read(myListStateProvider);
    expect(value, const [0]);

    container.read(myListStateProvider.notifier).state = const [0, 1];
    value = container.read(myListStateProvider);
    expect(value, const [0, 1]);

    container
        .read(myListStateProvider.notifier)
        .update((state) => [...state, 2]);
    value = container.read(myListStateProvider);
    expect(value, const [0, 1, 2]);
  });

  test('The generated provider can be overridden', () {
    final container = createContainer(overrides: [
      myListStateProvider.overrideWithValue(const [42]),
    ]);

    var value = container.read(myListStateProvider);
    expect(value, const [42]);

    container.read(myListStateProvider.notifier).state = const [42, 1];
    value = container.read(myListStateProvider);
    expect(value, const [42, 1]);

    container
        .read(myListStateProvider.notifier)
        .update((state) => [...state, 2]);
    value = container.read(myListStateProvider);
    expect(value, const [42, 1, 2]);
  });
}
