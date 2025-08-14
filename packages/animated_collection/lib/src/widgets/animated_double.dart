import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'animated_value.dart';

/// {@template animated_collection.animated_double}
/// A widget that animates a double
///
/// See also:
/// - [AnimatedValueWidget], which animates a value of type `T` using a custom
///   lerp function or a tween.
/// {@endtemplate}
class AnimatedDouble extends StatelessWidget {
  /// {@macro animated_collection.animated_double}
  const AnimatedDouble({
    required this.value,
    required this.builder,
    this.child,
    super.key,
    this.duration = AnimatedValueWidget.defaultDuration,
    this.curve = Curves.linear,
  });

  /// The double to animate.
  final double value;

  /// The builder that will be animated whenever the color changes.
  final Widget Function(BuildContext context, Widget? child, double value)
      builder;

  /// The child of the builder.
  final Widget? child;

  /// The duration of the animation.
  final Duration duration;

  /// The curve of the animation.
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    // ImplicitAnimatedWidget handles `null` value as absent and does not
    // animate to it, so we can use a custom wrapper to handle null values.
    return AnimatedValueWidget<double>.lerp(
      value: value,
      builder: builder,
      lerp: (a, b, t) => lerpDouble(a, b, t)!,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}
