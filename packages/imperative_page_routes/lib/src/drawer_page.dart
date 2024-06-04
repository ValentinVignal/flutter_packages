import 'package:flutter/material.dart';

/// A page that looks like a drawer.
class DrawerPage extends Page<dynamic> {
  /// A page that looks like a drawer.
  const DrawerPage({
    required this.child,
    super.key,
  });

  /// The child to display.
  final Widget child;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return DrawerPageRoute(
      settings: this,
    );
  }
}

/// The route used by [DrawerPage].
class DrawerPageRoute extends TransitionRoute<dynamic> {
  /// The route used by [DrawerPage].
  DrawerPageRoute({
    required DrawerPage settings,
  }) : super(
          settings: settings,
        );
  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return [
      OverlayEntry(
        builder: (context) {
          return Row(
            children: [
              // The drawer takes 5/12 of the available space.
              const Spacer(flex: 7),
              Expanded(
                flex: 5,
                child: SlideTransition(
                  position: animation!.drive(
                    Tween(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ),
                  ),
                  child: (settings as DrawerPage).child,
                ),
              ),
            ],
          );
        },
      ),
    ];
  }

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get popGestureEnabled => false;
}
