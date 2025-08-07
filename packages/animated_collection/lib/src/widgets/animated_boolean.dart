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
class AnimatedBoolean extends ImplicitlyAnimatedWidget {
  /// {@macro animated_collection.animated_boolean}
  const AnimatedBoolean({
    required this.value,
    required this.builder,
    this.child,
    super.duration = defaultDuration,
    super.curve,
    super.key,
  });

  /// The boolean value to animate.
  final bool value;

  /// The builder that will be animated whenever the value changes.
  final Widget Function(BuildContext context, Widget? child, double value)
      builder;

  /// The child of the builder.
  final Widget? child;

  /// Default duration of the animation.
  @visibleForTesting
  static const defaultDuration = Duration(milliseconds: 200);

  @override
  AnimatedWidgetBaseState<AnimatedBoolean> createState() =>
      _AnimatedBooleanState();
}

class _AnimatedBooleanState extends AnimatedWidgetBaseState<AnimatedBoolean> {
  Tween<double>? _tween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _tween = visitor(_tween, widget.value ? 1.0 : 0.0,
            (dynamic value) => Tween<double>(begin: value as double))!
        as Tween<double>;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      widget.child,
      _tween!.evaluate(animation),
    );
  }
}
