import 'package:flutter/widgets.dart';

import 'animated_boolean.dart';
import 'animated_color.dart';

/// @docImport 'animated_boolean.dart';

/// {@template animated_collection.animated_value_widget}
/// A widget that animates a value of type [T] using a custom lerp function or a
/// tween.
///
/// See also:
/// - [AnimatedBoolean], which animates a boolean value.
/// - [AnimatedColor], which animates a color value.
/// {@endtemplate}
class AnimatedValueWidget<T> extends ImplicitlyAnimatedWidget {
  /// {@macro animated_collection.animated_value_widget}
  ///
  /// Use [AnimatedValueWidget.lerp] to animate a value using a custom lerp.
  const AnimatedValueWidget.lerp({
    required this.value,
    required this.builder,
    required T Function(T?, T?, double) this.lerp,
    super.key,
    this.child,
    super.duration = defaultDuration,
    super.curve,
  }) : tweenBuilder = null;

  /// {@macro animated_collection.animated_value_widget}
  ///
  /// Use [AnimatedValueWidget.lerp] to animate a value using a custom [Tween].
  const AnimatedValueWidget.tween({
    required this.value,
    required this.builder,
    required Tween<T> Function(T) this.tweenBuilder,
    super.key,
    this.child,
    super.duration = defaultDuration,
    super.curve,
  }) : lerp = null;

  /// The value to animate.
  final T value;

  /// The child of the builder.
  final Widget? child;

  /// The builder that will be animated whenever the value changes.
  final Widget Function(BuildContext context, Widget? child, T value) builder;

  /// The tween builder function to create a tween for the value.
  final Tween<T> Function(T)? tweenBuilder;

  /// The custom lerp function to interpolate between [begin] and [end].
  final T Function(T?, T?, double)? lerp;

  /// The default duration for the animation.
  static const defaultDuration = Duration(milliseconds: 200);

  @override
  AnimatedWidgetBaseState<AnimatedValueWidget<T>> createState() =>
      _AnimatedValueWidgetState<T>();
}

class _AnimatedValueWidgetState<T>
    extends AnimatedWidgetBaseState<AnimatedValueWidget<T>> {
  Tween<T>? _tween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _tween = visitor(
      _tween,
      widget.value,
      (dynamic value) => widget.tweenBuilder != null
          ? widget.tweenBuilder!(value as T)
          : TweenWithLerp<T>(
              lerp: widget.lerp!,
              begin: value as T?,
              end: widget.value,
            ),
    ) as Tween<T>?;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.child, _tween!.evaluate(animation));
  }
}

/// Creates a tween with a custom lerp function.
///
/// The [begin] and [end] properties may be null; the null value
/// is treated as meaning the center.
class TweenWithLerp<T> extends Tween<T> {
  /// Creates a tween with a custom lerp function.
  ///
  /// The [begin] and [end] properties may be null; the null value
  /// is treated as meaning the center.
  TweenWithLerp({
    required T Function(T? begin, T? end, double t) lerp,
    super.begin,
    super.end,
  }) : _lerp = lerp;

  /// The custom lerp function to interpolate between [begin] and [end].
  final T Function(T? begin, T? end, double t) _lerp;

  /// Returns the value this variable has at the given animation clock value.
  @override
  T lerp(double t) => _lerp(begin, end, t);
}
