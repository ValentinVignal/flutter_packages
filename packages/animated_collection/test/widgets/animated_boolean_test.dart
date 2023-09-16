import 'package:animated_collection/animated_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('It should animate between 2 states', (tester) async {
    late double currentValue;
    Future<void> pumpWidget(bool state) async {
      final widget = AnimatedBoolean(
        value: state,
        builder: (context, child, value) {
          currentValue = value;
          return child!;
        },
        child: const SizedBox(),
      );
      await tester.pumpWidget(widget);
    }

    await pumpWidget(false);
    expect(currentValue, 0);

    await pumpWidget(true);
    expect(currentValue, 0);

    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentValue, 0.5);

    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentValue, 1);

    await pumpWidget(false);
    expect(currentValue, 1);

    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentValue, 0.5);

    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentValue, 0);
  });
}
