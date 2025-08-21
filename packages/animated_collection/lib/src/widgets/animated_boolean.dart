import 'package:animated_collection/animated_collection.dart';
import 'package:flutter/widgets.dart';

/// {@template animated_collection.animated_boolean}
/// A widget that animates its builder whenever the value changes.
///
/// This widget is useful when you want to animate a widget whenever a boolean
/// value changes from `true` to `false` or vice versa.
///
/// Anytime the value changes, it will rebuild [builder] with a new value
/// between `0` and `1` (`1` for `true` and `0` for `false`), which can be used
/// to animate the widget. The value is passed to the builder's `value` and
/// depends on the [curve] and [duration].
/// {@endtemplate}
class AnimatedBoolean extends StatelessWidget {
  /// {@macro animated_collection.animated_boolean}
  const AnimatedBoolean({
    required this.value,
    required this.builder,
    this.child,
    this.duration = defaultDuration,
    this.curve = Curves.linear,
    super.key,
  });

  /// The boolean value to animate.
  final bool value;

  /// The builder that will be animated whenever the value changes.
  final Widget Function(BuildContext context, Widget? child, double value)
      builder;

  /// The child of the builder.
  final Widget? child;

  /// The curve to apply when animating the parameters of this container.
  final Curve curve;

  /// The duration over which to animate the parameters of this container.
  final Duration duration;

  /// Default duration of the animation.
  @visibleForTesting
  static const defaultDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return AnimatedDouble(
      value: value ? 1 : 0,
      duration: duration,
      curve: curve,
      builder: builder,
      child: child,
    );
  }
}
