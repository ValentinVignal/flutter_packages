import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperative_page_routes/imperative_page_routes.dart';

void main() {
  testWidgets("It should push a dialog page", (tester) async {
    final pages = [
      const MaterialPage(child: Text('Home')),
      const BottomSheetPage(child: Text('Bottom sheet')),
    ];
    final navigator = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        home: Navigator(
          key: navigator,
          pages: pages,
          onDidRemovePage: (_) {
            pages.removeLast();
          },
        ),
      ),
    );
    expect(find.text('Home'), findsOne);
    expect(find.text('Bottom sheet'), findsOne);

    navigator.currentState!.pop();

    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOne);
    expect(find.text('DiaBottom sheet'), findsNothing);
    expect(pages, hasLength(1));
  });
}
