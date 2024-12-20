import 'package:test/test.dart';

import 'integration/list.dart';
import 'utils.dart';

void main() {
  test('Creates an equivalent of the StateProvider for an list of integer', () {
    final container = createContainer();

    var value = container.read(myListProvider);
    expect(value, const [0]);

    container.read(myListProvider.notifier).state = const [0, 1];
    value = container.read(myListProvider);
    expect(value, const [0, 1]);

    container.read(myListProvider.notifier).update((state) => [...state, 2]);
    value = container.read(myListProvider);
    expect(value, const [0, 1, 2]);
  });

  test('The generated provider can be overridden', () {
    final container = createContainer(overrides: [
      myListProvider.overrideWithValue(const [42]),
    ]);

    var value = container.read(myListProvider);
    expect(value, const [42]);

    container.read(myListProvider.notifier).state = const [42, 1];
    value = container.read(myListProvider);
    expect(value, const [42, 1]);

    container.read(myListProvider.notifier).update((state) => [...state, 2]);
    value = container.read(myListProvider);
    expect(value, const [42, 1, 2]);
  });
}
