import 'dart:ui';

import 'package:animated_collection/animated_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('It should lerp from a null value - double - lerp',
      (tester) async {
    double? currentValue;

    final lerpCalls = <({double? a, double? b, double t})>[];

    Future<void> pumpWidget(double? value) async {
      final widget = AnimatedValueWidget<double?>.lerp(
        lerp: (a, b, t) {
          lerpCalls.add((a: a, b: b, t: t));
          return lerpDouble(a, b, t);
        },
        value: value,
        builder: (context, child, value) {
          currentValue = value;
          return Container(
            height: value,
          );
        },
        child: const SizedBox(),
      );
      await tester.pumpWidget(widget);
    }

    await pumpWidget(null);
    expect(currentValue, null);
    expect(lerpCalls, isEmpty);

    await pumpWidget(1);

    await tester.pump(AnimatedValueWidget.defaultDuration * 0.25);
    expect(currentValue, 0.25);
    expect(lerpCalls, const [(a: null, b: 1, t: 0.25)]);

    await tester.pump(AnimatedValueWidget.defaultDuration * 0.25);
    expect(currentValue, 0.5);
    expect(
        lerpCalls, const [(a: null, b: 1, t: 0.25), (a: null, b: 1, t: 0.5)]);

    await tester.pump(AnimatedValueWidget.defaultDuration * 0.5);
    expect(currentValue, 1);
    expect(
        lerpCalls, const [(a: null, b: 1, t: 0.25), (a: null, b: 1, t: 0.5)]);
  });
  testWidgets('It should lerp from a null value - color - lerp',
      (tester) async {
    Color? currentColor;

    final lerpCalls = <({Color? a, Color? b, double t})>[];

    Future<void> pumpWidget(Color? color) async {
      final widget = AnimatedValueWidget<Color?>.lerp(
        lerp: (a, b, c) {
          lerpCalls.add((a: a, b: b, t: c));
          return Color.lerp(a, b, c);
        },
        value: color,
        builder: (context, child, color) {
          currentColor = color;
          return child!;
        },
        child: const SizedBox(),
      );
      await tester.pumpWidget(widget);
    }

    await pumpWidget(null);
    expect(currentColor, null);
    expect(lerpCalls, isEmpty);

    await pumpWidget(Color(0xffffffff));

    await tester.pump(AnimatedValueWidget.defaultDuration * 0.25);
    expect(currentColor, isSameColorAs(Color(0x40ffffff)));
    expect(lerpCalls, const [(a: null, b: Color(0xffffffff), t: 0.25)]);

    await tester.pump(AnimatedValueWidget.defaultDuration * 0.25);
    expect(currentColor, isSameColorAs(Color(0x80ffffff)));
    expect(lerpCalls, const [
      (a: null, b: Color(0xffffffff), t: 0.25),
      (a: null, b: Color(0xffffffff), t: 0.5)
    ]);

    await tester.pump(AnimatedValueWidget.defaultDuration * 0.5);
    expect(currentColor, isSameColorAs(Color(0xffffffff)));
    expect(lerpCalls, const [
      (a: null, b: Color(0xffffffff), t: 0.25),
      (a: null, b: Color(0xffffffff), t: 0.5),
    ]);
  });

  testWidgets('It should lerp from a null value - color - tween',
      (tester) async {
    Color? currentColor;

    Future<void> pumpWidget(Color? color) async {
      final widget = AnimatedValueWidget<Color?>.tween(
        value: color,
        tweenBuilder: (value) => ColorTween(
          begin: value,
          end: color,
        ),
        builder: (context, child, color) {
          currentColor = color;
          return child!;
        },
        child: const SizedBox(),
      );
      await tester.pumpWidget(widget);
    }

    await pumpWidget(null);
    expect(currentColor, null);

    await pumpWidget(Color(0xffffffff));

    await tester.pump(AnimatedValueWidget.defaultDuration * 0.25);
    expect(currentColor, isSameColorAs(Color(0x40ffffff)));

    await tester.pump(AnimatedValueWidget.defaultDuration * 0.25);
    expect(currentColor, isSameColorAs(Color(0x80ffffff)));

    await tester.pump(AnimatedValueWidget.defaultDuration * 0.5);
    expect(currentColor, isSameColorAs(Color(0xffffffff)));
  });
}
