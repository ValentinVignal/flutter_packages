import 'package:animated_collection/animated_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('It should animate between colors', (tester) async {
    Color? currentColor;
    Future<void> pumpWidget(Color color) async {
      final widget = AnimatedColor(
        color: color,
        builder: (context, child, value) {
          currentColor = value;
          return child!;
        },
        child: const SizedBox(),
      );
      await tester.pumpWidget(widget);
    }

    await pumpWidget(Color(0x00000000));
    expect(currentColor, Color(0x00000000));

    await pumpWidget(Color(0xffffffff));
    expect(currentColor, Color(0x00000000));

    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentColor, isSameColorAs(Color(0x80808080)));

    await pumpWidget(Color(0xffff0000));
    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentColor, isSameColorAs(Color(0xc0c04040)));

    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentColor, isSameColorAs(Color(0xffff0000)));

    await pumpWidget(Color(0xff00ff00));
    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentColor, isSameColorAs(Color(0xff808000)));

    await pumpWidget(Color(0xff0000ff));
    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);

    expect(currentColor, isSameColorAs(Color(0xff404080)));
    await tester.pump(AnimatedBoolean.defaultDuration * 0.5);
    expect(currentColor, isSameColorAs(Color(0xff0000ff)));
  });
}
