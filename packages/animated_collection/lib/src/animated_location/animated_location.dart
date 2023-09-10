import 'package:animated_collection/src/animated_location/render.dart';
import 'package:flutter/widgets.dart';

import 'animated_location_scope.dart';
import 'controller.dart';

/// {@template animated_collection.AnimatedLocation}
/// Tracks its [child] and animates its location when it changes.
/// {@endtemplate}
///
/// From [`local_hero`](https://pub.dev/packages/local_hero).
class AnimatedLocation extends StatefulWidget {
  /// {@macro animated_collection.AnimatedLocation}
  const AnimatedLocation({
    required this.child,
    required this.tag,
    super.key,
  });

  /// The child to animate when the location changes.
  final Widget child;

  /// The identifier for this particular animated location. If the tag of this
  /// animated location matches the tag of a animated location on another
  /// location, then an animation will be triggered.
  final Object tag;

  @override
  State<AnimatedLocation> createState() => _AnimatedLocationState();
}

class _AnimatedLocationState extends State<AnimatedLocation> {
  late final AnimatedLocationController _controller;
  late final AnimatedLocationScopeState _scope;
  @override
  void initState() {
    super.initState();
    _scope = InheritedAnimatedLocationScope.of(context);
    _controller = _scope.track(context, widget);
  }

  @override
  void dispose() {
    _scope.untrack(widget);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLocationLeader(
      controller: _controller,
      child: widget.child,
    );
  }
}
