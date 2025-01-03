import 'package:test/test.dart';

import 'integration/family.dart';
import 'utils.dart';

void main() {
  group('Positional parameters', () {
    test('Can read and update the provider', () {
      final container = createContainer();

      var value = container.read(myFamilyPositionalParametersProvider(
        'a',
        2,
        true,
        3.0,
        const [4],
      ));
      expect(value, 0);

      container
          .read(myFamilyPositionalParametersProvider(
            'a',
            2,
            true,
            3.0,
            const [4],
          ).notifier)
          .state++;
      value = container.read(myFamilyPositionalParametersProvider(
        'a',
        2,
        true,
        3.0,
        const [4],
      ));
      expect(value, 1);

      container
          .read(myFamilyPositionalParametersProvider(
            'a',
            2,
            true,
            3.0,
            const [4],
          ).notifier)
          .update((state) => state + 1);
      value = container.read(myFamilyPositionalParametersProvider(
        'a',
        2,
        true,
        3.0,
        const [4],
      ));
      expect(value, 2);
    });

    test('The providers are independent', () {
      final container = createContainer();

      var value0 = container.read(myFamilyPositionalParametersProvider(
        'a',
        2,
        true,
        3.0,
        const [4],
      ));
      expect(value0, 0);
      var value1 = container.read(myFamilyPositionalParametersProvider(
        'b',
        3,
        false,
        4.0,
        const [5],
      ));
      expect(value1, 0);

      container
          .read(myFamilyPositionalParametersProvider(
            'a',
            2,
            true,
            3.0,
            const [4],
          ).notifier)
          .state++;

      container
          .read(myFamilyPositionalParametersProvider(
            'b',
            3,
            false,
            4.0,
            const [5],
          ).notifier)
          .state += 2;
      value0 = container.read(myFamilyPositionalParametersProvider(
        'a',
        2,
        true,
        3.0,
        const [4],
      ));
      expect(value0, 1);
      value1 = container.read(myFamilyPositionalParametersProvider(
        'b',
        3,
        false,
        4.0,
        const [5],
      ));
      expect(value1, 2);

      container
          .read(myFamilyPositionalParametersProvider(
            'a',
            2,
            true,
            3.0,
            const [4],
          ).notifier)
          .update((state) => state + 1);
      container
          .read(myFamilyPositionalParametersProvider(
            'b',
            3,
            false,
            4.0,
            const [5],
          ).notifier)
          .update((state) => state + 2);
      value0 = container.read(myFamilyPositionalParametersProvider(
        'a',
        2,
        true,
        3.0,
        const [4],
      ));
      expect(value0, 2);
      value1 = container.read(myFamilyPositionalParametersProvider(
        'b',
        3,
        false,
        4.0,
        const [5],
      ));
      expect(value1, 4);
    });

    test('The generated provider can be overridden', () {
      final container = createContainer(overrides: [
        myFamilyPositionalParametersProvider(
          'a',
          2,
          true,
          3.0,
          const [4],
        ).overrideWithValue(42),
      ]);

      var value = container.read(myFamilyPositionalParametersProvider(
        'a',
        2,
        true,
        3.0,
        const [4],
      ));
      expect(value, 42);

      container
          .read(myFamilyPositionalParametersProvider(
            'a',
            2,
            true,
            3.0,
            const [4],
          ).notifier)
          .state++;
      value = container.read(myFamilyPositionalParametersProvider(
        'a',
        2,
        true,
        3.0,
        const [4],
      ));
      expect(value, 43);

      container
          .read(myFamilyPositionalParametersProvider(
            'a',
            2,
            true,
            3.0,
            const [4],
          ).notifier)
          .update((state) => state + 1);
      value = container.read(myFamilyPositionalParametersProvider(
        'a',
        2,
        true,
        3.0,
        const [4],
      ));
      expect(value, 44);
    });
  });
  group('Mixed parameters', () {
    test('Can read and update the provider', () {
      final container = createContainer();

      var value = container.read(myFamilyMixedParametersProvider(
        'a',
        2,
        param3: true,
        param4: 3.0,
        param5: const [4],
      ));
      expect(value, const [true]);

      container
          .read(myFamilyMixedParametersProvider(
            'a',
            2,
            param3: true,
            param4: 3.0,
            param5: const [4],
          ).notifier)
          .state = const [false, true];
      value = container.read(myFamilyMixedParametersProvider(
        'a',
        2,
        param3: true,
        param4: 3.0,
        param5: const [4],
      ));
      expect(value, const [false, true]);

      container
          .read(myFamilyMixedParametersProvider(
            'a',
            2,
            param3: true,
            param4: 3.0,
            param5: const [4],
          ).notifier)
          .update((state) => const [true, false]);
      value = container.read(myFamilyMixedParametersProvider(
        'a',
        2,
        param3: true,
        param4: 3.0,
        param5: const [4],
      ));
      expect(value, const [true, false]);
    });

    test('The providers are independent', () {
      final container = createContainer();

      var value0 = container.read(myFamilyMixedParametersProvider(
        'a',
        2,
        param3: true,
        param4: 3.0,
        param5: const [4],
      ));
      expect(value0, const [true]);
      var value1 = container.read(myFamilyMixedParametersProvider(
        'b',
        3,
        param3: false,
        param4: 4.0,
        param5: const [0, 1],
      ));
      expect(value1, const [true]);

      container
          .read(myFamilyMixedParametersProvider(
            'a',
            2,
            param3: true,
            param4: 3.0,
            param5: const [4],
          ).notifier)
          .state = const [false, true];

      container
          .read(myFamilyMixedParametersProvider(
            'b',
            3,
            param3: false,
            param4: 4.0,
            param5: const [0, 1],
          ).notifier)
          .state = const [];
      value0 = container.read(myFamilyMixedParametersProvider(
        'a',
        2,
        param3: true,
        param4: 3.0,
        param5: const [4],
      ));
      expect(value0, const [false, true]);
      value1 = container.read(myFamilyMixedParametersProvider(
        'b',
        3,
        param3: false,
        param4: 4.0,
        param5: const [0, 1],
      ));
      expect(value1, const []);

      container
          .read(myFamilyMixedParametersProvider(
            'a',
            2,
            param3: true,
            param4: 3.0,
            param5: const [4],
          ).notifier)
          .update((state) => const [true, false]);
      container
          .read(myFamilyMixedParametersProvider(
            'b',
            3,
            param3: false,
            param4: 4.0,
            param5: const [0, 1],
          ).notifier)
          .update((state) => const [true, true]);
      value0 = container.read(myFamilyMixedParametersProvider(
        'a',
        2,
        param3: true,
        param4: 3.0,
        param5: const [4],
      ));
      expect(value0, const [true, false]);
      value1 = container.read(myFamilyMixedParametersProvider(
        'b',
        3,
        param3: false,
        param4: 4.0,
        param5: const [0, 1],
      ));
      expect(value1, const [true, true]);
    });

    test('The generated provider can be overridden', () {
      final container = createContainer(overrides: [
        myFamilyMixedParametersProvider(
          'a',
          2,
          param3: true,
          param4: 3.0,
          param5: const [4],
        ).overrideWithValue(const [true, false]),
      ]);

      var value = container.read(myFamilyMixedParametersProvider(
        'a',
        2,
        param3: true,
        param4: 3.0,
        param5: const [4],
      ));
      expect(value, const [true, false]);

      container
          .read(myFamilyMixedParametersProvider(
            'a',
            2,
            param3: true,
            param4: 3.0,
            param5: const [4],
          ).notifier)
          .state = const [];
      value = container.read(myFamilyMixedParametersProvider(
        'a',
        2,
        param3: true,
        param4: 3.0,
        param5: const [4],
      ));
      expect(value, const []);

      container
          .read(myFamilyMixedParametersProvider(
            'a',
            2,
            param3: true,
            param4: 3.0,
            param5: const [4],
          ).notifier)
          .update((state) => const [false, false]);
      value = container.read(myFamilyMixedParametersProvider(
        'a',
        2,
        param3: true,
        param4: 3.0,
        param5: const [4],
      ));
      expect(value, const [false, false]);
    });
  });
}
