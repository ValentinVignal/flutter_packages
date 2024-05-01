import 'package:animated_collection/animated_collection.dart';
import 'package:animated_collection/src/widgets/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'It should build the child when visible is true',
    (tester) async {
      const key = Key('key');
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: AnimatedVisibility(
            visible: true,
            child: SizedBox(key: key),
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    },
  );

  testWidgets(
    'It should no build the child when visible is false',
    (tester) async {
      const key = Key('key');
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: AnimatedVisibility(
            visible: false,
            child: SizedBox(key: key),
          ),
        ),
      );

      expect(find.byKey(key), findsNothing);
    },
  );

  testWidgets(
    'It should show and hide the child when visible changes',
    (tester) async {
      const key = Key('key');
      Future<void> pumpWidget(bool visible) async {
        final widget = Directionality(
          textDirection: TextDirection.ltr,
          child: AnimatedVisibility(
            visible: visible,
            curve: Curves.linear,
            child: const ColoredBox(
              color: Colors.red,
              child: SizedBox.square(
                dimension: 50,
                key: key,
              ),
            ),
          ),
        );
        await tester.pumpWidget(widget);
      }

      await pumpWidget(true);

      final actualPositionedBox = tester.renderObject<RenderPositionedBox>(
        find.byType(Align),
      );
      expect(find.byKey(key), findsOneWidget);
      expect(actualPositionedBox.heightFactor, 1);
      expect(actualPositionedBox.widthFactor, 1);

      await pumpWidget(false);
      await tester.pump(defaultDuration * 0.5);
      expect(find.byKey(key), findsOneWidget);
      expect(actualPositionedBox.heightFactor, 0.5);
      expect(actualPositionedBox.widthFactor, 1);

      await tester.pump(defaultDuration * 0.5);
      expect(find.byKey(key), findsOneWidget);
      expect(actualPositionedBox.heightFactor, 0.0);
      expect(actualPositionedBox.widthFactor, 1);

      await tester.pumpAndSettle();
      expect(find.byKey(key), findsNothing);
    },
  );

  testWidgets(
    'It should use the 1s duration',
    (tester) async {
      const key = Key('key');
      const duration = Duration(seconds: 1);
      Future<void> pumpWidget(bool visible) async {
        final widget = Directionality(
          textDirection: TextDirection.ltr,
          child: AnimatedVisibility(
            visible: visible,
            duration: duration,
            curve: Curves.linear,
            child: const ColoredBox(
              color: Colors.red,
              child: SizedBox.square(
                dimension: 50,
                key: key,
              ),
            ),
          ),
        );
        await tester.pumpWidget(widget);
      }

      await pumpWidget(true);

      final actualPositionedBox = tester.renderObject<RenderPositionedBox>(
        find.byType(Align),
      );
      expect(find.byKey(key), findsOneWidget);
      expect(actualPositionedBox.heightFactor, 1);
      expect(actualPositionedBox.widthFactor, 1);

      await pumpWidget(false);
      await tester.pump(duration * 0.5);
      expect(find.byKey(key), findsOneWidget);
      expect(actualPositionedBox.heightFactor, 0.5);
      expect(actualPositionedBox.widthFactor, 1);

      await tester.pump(duration * 0.5);
      expect(find.byKey(key), findsOneWidget);
      expect(actualPositionedBox.heightFactor, 0.0);
      expect(actualPositionedBox.widthFactor, 1);

      await tester.pumpAndSettle();
      expect(find.byKey(key), findsNothing);
    },
  );
}
