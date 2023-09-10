import 'package:flutter/material.dart';

/// {@template animated_collection.animated_boolean_state}
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
class AnimatedBooleanState extends ImplicitlyAnimatedWidget {
  /// {@macro animated_collection.animated_boolean_state}
  const AnimatedBooleanState({
    required this.value,
    required this.builder,
    this.child,
    super.duration = const Duration(milliseconds: 200),
    super.key,
  });

  /// The boolean value to animate.
  final bool value;

  /// The builder that will be animated whenever the value changes.
  final Widget Function(BuildContext context, Widget? child, double value)
      builder;

  /// The child of the builder.
  final Widget? child;

  @override
  AnimatedWidgetBaseState<AnimatedBooleanState> createState() =>
      _AnimatedBooleanState();
}

class _AnimatedBooleanState
    extends AnimatedWidgetBaseState<AnimatedBooleanState> {
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
