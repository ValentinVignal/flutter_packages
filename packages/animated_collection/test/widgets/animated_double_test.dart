import 'package:animated_collection/animated_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('It should animate between doubles', (tester) async {
    late double currentValue;
    Future<void> pumpWidget(double value) async {
      final widget = AnimatedDouble(
        value: value,
        builder: (context, child, value) {
          currentValue = value;
          return child!;
        },
        child: const SizedBox(),
      );
      await tester.pumpWidget(widget);
    }

    await pumpWidget(0);
    expect(currentValue, 0);

    await pumpWidget(1);
    expect(currentValue, 0);

    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentValue, 0.5);

    await pumpWidget(5.5);
    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentValue, 3);

    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentValue, 5.5);

    await pumpWidget(15);
    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentValue, 10.25);

    await pumpWidget(0);
    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);

    expect(currentValue, 5.125);
    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentValue, 0);
  });
}
