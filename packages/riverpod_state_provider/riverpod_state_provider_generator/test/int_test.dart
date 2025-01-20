import 'package:test/test.dart';

import 'integration/int.dart';
import 'utils.dart';

void main() {
  test('Creates an equivalent of the StateProvider for an integer', () {
    final container = createContainer();

    var value = container.read(myIntegerStateProvider);
    expect(value, 0);

    container.read(myIntegerStateProvider.notifier).state++;
    value = container.read(myIntegerStateProvider);
    expect(value, 1);

    container
        .read(myIntegerStateProvider.notifier)
        .update((state) => state + 1);
    value = container.read(myIntegerStateProvider);
    expect(value, 2);
  });

  test('The generated provider can be overridden', () {
    final container = createContainer(overrides: [
      myIntegerStateProvider.overrideWithValue(42),
    ]);

    var value = container.read(myIntegerStateProvider);
    expect(value, 42);

    container.read(myIntegerStateProvider.notifier).state++;
    value = container.read(myIntegerStateProvider);
    expect(value, 43);

    container
        .read(myIntegerStateProvider.notifier)
        .update((state) => state + 1);
    value = container.read(myIntegerStateProvider);
    expect(value, 44);
  });
}
