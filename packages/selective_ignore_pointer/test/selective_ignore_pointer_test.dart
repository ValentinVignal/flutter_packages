import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selective_ignore_pointer/selective_ignore_pointer.dart';

void main() {
  testWidgets(
    'SelectiveIgnorePointer allows PointerPassthrough to receive events',
    (WidgetTester tester) async {
      bool pointerReceived = false;

      await tester.pumpWidget(
        SelectiveIgnorePointer(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  pointerReceived = true;
                },
                child: Container(
                  key: Key('1'),
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),
              PointerPassthrough(
                child: GestureDetector(
                  onTap: () {
                    pointerReceived = true;
                  },
                  child: Container(
                    key: Key('2'),
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      // Tap on the red box (should be ignored)
      await tester.tap(find.byKey(Key('1')), warnIfMissed: false);
      expect(pointerReceived, isFalse);

      // Reset the flag
      pointerReceived = false;

      // Tap on the blue box (should receive the event)
      await tester.tap(find.byKey(Key('2')));
      expect(pointerReceived, isTrue);
    },
  );

  testWidgets('SelectiveIgnorePointer can toggle ignoring state', (
    WidgetTester tester,
  ) async {
    bool pointerReceived = false;

    Future<void> pumpIgnoringState(bool ignoring) async {
      await tester.pumpWidget(
        SelectiveIgnorePointer(
          ignoring: ignoring,
          child: GestureDetector(
            onTap: () {
              pointerReceived = true;
            },
            child: Container(
              key: Key('1'),
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
        ),
      );
    }

    await pumpIgnoringState(true);

    // Tap on the red box (should be ignored)
    await tester.tap(find.byKey(Key('1')), warnIfMissed: false);
    expect(pointerReceived, isFalse);

    // Change ignoring state
    await pumpIgnoringState(false);

    // Tap on the red box (should now receive the event)
    await tester.tap(find.byKey(Key('1')));
    expect(pointerReceived, isTrue);
  });

  testWidgets('SelectiveIgnorePointer can toggle ignoring state', (
    WidgetTester tester,
  ) async {
    bool pointerReceived = false;

    Future<void> pumpAllowingState(bool allowing) async {
      await tester.pumpWidget(
        SelectiveIgnorePointer(
          child: PointerPassthrough(
            allowing: allowing,
            child: GestureDetector(
              onTap: () {
                pointerReceived = true;
              },
              child: Container(
                key: Key('1'),
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
          ),
        ),
      );
    }

    await pumpAllowingState(false);

    // Tap on the red box (should be ignored)
    await tester.tap(find.byKey(Key('1')), warnIfMissed: false);
    expect(pointerReceived, isFalse);

    // Change ignoring state
    await pumpAllowingState(true);

    // Tap on the red box (should now receive the event)
    await tester.tap(find.byKey(Key('1')));
    expect(pointerReceived, isTrue);
  });
}
