import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:counter/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: const MyApp()));

    expect(find.text('0\n0'), findsOne);
    expect(find.text('1\n1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0\n0'), findsNothing);
    expect(find.text('1\n1'), findsOne);
  });
}
