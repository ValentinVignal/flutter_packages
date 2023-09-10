import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'animated_location.dart';
import 'controller.dart';
import 'render.dart';

/// The state of an [AnimatedLocationScope].
abstract class AnimatedLocationScopeState {
  const AnimatedLocationScopeState();

  /// Starts tracking an [AnimatedLocation] in the sub-widget tree and return
  /// its controller.
  AnimatedLocationController track(
      BuildContext context, AnimatedLocation animatedLocation);

  /// Stops tracking an [AnimatedLocation] in the sub-widget tree.
  void untrack(AnimatedLocation localHero);
}

/// {@template animated_collection.AnimatedLocationScope}
/// A scope for [AnimatedLocation]s. This widget is responsible for track and
/// animate the [AnimatedLocation]s in it sub-widget tree.
/// {@endtemplate}
///
/// From [`local_hero`](https://pub.dev/packages/local_hero).
class AnimatedLocationScope extends StatefulWidget {
  /// {@macro animated_collection.AnimatedLocationScope}
  const AnimatedLocationScope({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
    this.createRectTween = _defaultCreateTweenRect,
    super.key,
  });

  /// The duration of the animation.
  final Duration duration;

  /// The curve for the hero animation.
  final Curve curve;

  /// Defines how the destination hero's bounds change as it flies from the
  /// starting position to the destination position.
  ///
  /// The default value creates a [MaterialRectArcTween].
  final CreateRectTween createRectTween;

  final Widget child;

  static RectTween _defaultCreateTweenRect(Rect? begin, Rect? end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  @override
  State<AnimatedLocationScope> createState() => _AnimatedLocationScopeState();
}

class _AnimatedLocationScopeState extends State<AnimatedLocationScope>
    with TickerProviderStateMixin
    implements AnimatedLocationScopeState {
  /// Tracks all the [AnimatedLocation]s in the sub-widget tree.
  final _trackers = <Object, _AnimatedLocationTracker>{};

  @override
  AnimatedLocationController track(
      BuildContext context, AnimatedLocation animatedLocation) {
    final _AnimatedLocationTracker tracker = _trackers.putIfAbsent(
      animatedLocation.tag,
      () => _createTracker(context, animatedLocation),
    );
    tracker.count++;
    return tracker.controller;
  }

  /// Creates a tracker for an [AnimatedLocation].
  _AnimatedLocationTracker _createTracker(
    BuildContext context,
    AnimatedLocation animatedLocation,
  ) {
    final AnimatedLocationController controller = AnimatedLocationController(
      tag: animatedLocation.tag,
      duration: widget.duration,
      createRectTween: widget.createRectTween,
      curve: widget.curve,
      vsync: this,
    );
    final Widget shuttle = animatedLocation.child;

    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedLocationFollower(
          controller: controller,
          child: shuttle,
        );
      },
    );

    final _AnimatedLocationTracker tracker = _AnimatedLocationTracker(
      controller: controller,
      overlayEntry: overlayEntry,
    );

    tracker.addOverlay(context);
    return tracker;
  }

  @override
  void untrack(AnimatedLocation animatedLocation) {
    final tracker = _trackers[animatedLocation.tag];
    if (tracker != null) {
      tracker.count--;
      if (tracker.count == 0) {
        _trackers.remove(animatedLocation.tag);
        _disposeTracker(tracker);
      }
    }
  }

  void _disposeTracker(_AnimatedLocationTracker tracker) {
    tracker.controller.dispose();
    tracker.removeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedAnimatedLocationScope(
      state: this,
      child: widget.child,
    );
  }
}

/// The tracker for an [AnimatedLocation].
class _AnimatedLocationTracker {
  _AnimatedLocationTracker({
    required this.overlayEntry,
    required this.controller,
  });

  /// The overlay entry.
  final OverlayEntry overlayEntry;

  /// The linked [AnimatedLocationController].
  final AnimatedLocationController controller;

  /// How many times the [AnimatedLocation] is tracked.
  var count = 0;

  bool _removeRequested = false;
  bool _overlayInserted = false;

  void addOverlay(BuildContext context) {
    final overlayState = Overlay.of(context);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!_removeRequested) {
        overlayState.insert(overlayEntry);
        _overlayInserted = true;
      }
    });
  }

  void removeOverlay() {
    _removeRequested = true;
    if (_overlayInserted) {
      overlayEntry.remove();
    }
  }
}

/// Provides an access to [AnimatedLocationScopeState] to the widgets of the
/// sub-widget tree.
class InheritedAnimatedLocationScope extends InheritedWidget {
  const InheritedAnimatedLocationScope({
    super.key,
    required this.state,
    required super.child,
  });

  final AnimatedLocationScopeState state;

  /// Returns the [AnimatedLocationScopeState] of the closest
  /// [InheritedAnimatedLocationScope].
  static AnimatedLocationScopeState of(BuildContext context) {
    final inherited =
        context.getInheritedWidgetOfExactType<InheritedAnimatedLocationScope>();

    assert(() {
      if (inherited == null) {
        throw FlutterError(
          'No AnimatedLocationScope for an AnimatedLocation\n'
          'When creating an AnimatedLocation, you must ensure there'
          'is an AnimatedLocationScope above the AnimatedLocation.\n',
        );
      }
      return true;
    }());

    return inherited!.state;
  }

  @override
  bool updateShouldNotify(InheritedAnimatedLocationScope oldWidget) {
    return false;
  }
}
