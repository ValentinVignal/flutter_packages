import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:color_palette_example/main.dart';

void main() {
  test('Color Palette Static Fields', () {
    expect(Palette.primary, $paletteStaticJson['primary']);
    expect(Palette.secondary, $paletteStaticJson['secondary']);
    expect(Palette.error, $paletteStaticJson['error']);
    expect(Palette.light, $paletteStaticJson['light']);
    expect(Palette.dark, $paletteStaticJson['dark']);
    expect(Palette.white, $paletteStaticJson['white']);
    expect(Palette.black, $paletteStaticJson['black']);
  });

  testWidgets('It should display the colors', (tester) async {
    await tester.pumpWidget(StaticJsonSerializableExample());

    expect(
      find.byWidgetPredicate(
        (widget) => widget is Card && widget.color == Palette.primary,
      ),
      findsOne,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Card && widget.color == Palette.secondary,
      ),
      findsOne,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Card && widget.color == Palette.error,
      ),
      findsOne,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Card && widget.color == Palette.light,
      ),
      findsOne,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Card && widget.color == Palette.dark,
      ),
      findsOne,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Card && widget.color == Palette.white,
      ),
      findsOne,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Card && widget.color == Palette.black,
      ),
      findsOne,
    );
  });
}
