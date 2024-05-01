import 'package:animated_collection/animated_collection.dart';
import 'package:animated_collection/src/widgets/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('It should build the widget with an animation', (tester) async {
    const key = Key('key');
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: AnimatedAppearing(
          curve: Curves.linear,
          child: ColoredBox(
            color: Colors.red,
            child: SizedBox.square(
              dimension: 50,
              key: key,
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(key), findsNothing);

    await tester.pump();
    expect(find.byKey(key), findsOne);
    final actualPositionedBox = tester.renderObject<RenderPositionedBox>(
      find.byType(Align).last,
    );
    expect(actualPositionedBox.heightFactor, 0);
    expect(actualPositionedBox.widthFactor, 1);

    await tester.pump(defaultDuration * 0.5);
    expect(find.byKey(key), findsOne);
    expect(actualPositionedBox.heightFactor, 0.5);
    expect(actualPositionedBox.widthFactor, 1);

    await tester.pump(defaultDuration * 0.5);
    expect(find.byKey(key), findsOne);
    expect(actualPositionedBox.heightFactor, 1);
    expect(actualPositionedBox.widthFactor, 1);
  });
}
