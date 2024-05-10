import 'package:animated_collection/animated_collection.dart';
import 'package:animated_collection/src/widgets/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('It should animated the Expanded ', (tester) async {
    const key0 = Key('0');
    const key1 = Key('1');
    Widget buildWidget(int flex) {
      return MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              const Expanded(
                child: SizedBox(key: key0),
              ),
              AnimatedExpanded(
                flex: flex,
                child: const SizedBox(key: key1),
              ),
            ],
          ),
        ),
      );
    }

    await tester.pumpWidget(buildWidget(1));

    expect(tester.getSize(find.byKey(key0)).width, 400);
    expect(tester.getSize(find.byKey(key1)).width, 400);

    await tester.pumpWidget(buildWidget(3));
    await tester.pump(defaultDuration * (1 / 2));

    expect(tester.getSize(find.byKey(key0)).width, closeTo(266.6, 0.1));
    expect(tester.getSize(find.byKey(key1)).width, closeTo(533.3, 0.1));

    await tester.pump(defaultDuration * (1 / 2));

    expect(tester.getSize(find.byKey(key0)).width, 200);
    expect(tester.getSize(find.byKey(key1)).width, 600);

    await tester.pumpWidget(buildWidget(7));
    await tester.pump(defaultDuration * (1 / 2));

    expect(tester.getSize(find.byKey(key0)).width, closeTo(133.3, 0.1));
    expect(tester.getSize(find.byKey(key1)).width, closeTo(666.6, 0.1));

    await tester.pump(defaultDuration * (1 / 2));

    expect(tester.getSize(find.byKey(key0)).width, 100);
    expect(tester.getSize(find.byKey(key1)).width, 700);
  });
}
