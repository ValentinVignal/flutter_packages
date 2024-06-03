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
    return _DrawerPageRoute(
      settings: this,
    );
  }
}

class _DrawerPageRoute extends TransitionRoute<dynamic> {
  _DrawerPageRoute({
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
  bool get popGestureEnabled {
    // If there's nothing to go back to, then obviously we don't support
    // the back gesture.
    if (isFirst) {
      return false;
    }
    // If the route wouldn't actually pop if we popped it, then the gesture
    // would be really confusing (or would skip internal routes), so disallow it.
    if (willHandlePopInternally) {
      return false;
    }
    // If attempts to dismiss this route might be vetoed such as in a page
    // with forms, then do not allow the user to dismiss the route with a swipe.
    if (popDisposition == RoutePopDisposition.doNotPop) {
      return false;
    }
    // If we're in an animation already, we cannot be manually swiped.
    if (animation!.status != AnimationStatus.completed) {
      return false;
    }
    // If we're being popped into, we also cannot be swiped until the pop above
    // it completes. This translates to our secondary animation being
    // dismissed.
    if (secondaryAnimation!.status != AnimationStatus.dismissed) {
      return false;
    }
    // If we're in a gesture already, we cannot start another.
    if (navigator!.userGestureInProgress) {
      return false;
    }

    // Looks like a back gesture would be welcome!
    return true;
  }
}
