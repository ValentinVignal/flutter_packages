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
    required T Function(T, T, double) this.lerp,
    super.key,
    this.child,
    super.duration = defaultDuration,
    super.curve,
  }) : tweenBuilder = null;

  /// {@macro animated_collection.animated_value_widget}
  ///
  /// Use [AnimatedValueWidget.lerp] to animate a value using a custom [Tween].
  const AnimatedValueWidget.tween({
    required this.builder,
    required Tween<T> Function(T) this.tweenBuilder,
    required this.value,
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
  final T Function(T, T, double)? lerp;

  /// The default duration for the animation.
  static const defaultDuration = Duration(milliseconds: 200);

  @override
  AnimatedWidgetBaseState<AnimatedValueWidget<T>> createState() =>
      _AnimatedValueWidgetState<T>();
}

class _AnimatedValueWidgetState<T>
    extends AnimatedWidgetBaseState<AnimatedValueWidget<T>> {
  Tween<_ValueWrapper<T>>? _tween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _tween = visitor(
      _tween,
      _ValueWrapper(widget.value),
      (dynamic value) {
        if (widget.tweenBuilder != null) {
          return _ValueWrapperTween<T>(
            parent: widget.tweenBuilder!((value as _ValueWrapper<T>).value),
          );
        } else {
          return TweenWithLerp<_ValueWrapper<T>>(
            lerp: (a, b, t) => _ValueWrapper(widget.lerp!(a.value, b.value, t)),
            begin: value,
            end: _ValueWrapper(widget.value),
          );
        }
      },
    ) as Tween<_ValueWrapper<T>>?;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      widget.child,
      _tween!.evaluate(animation).value,
    );
  }
}

/// Creates a tween with a custom lerp function.
class TweenWithLerp<T> extends Tween<T> {
  /// Creates a tween with a custom lerp function.
  TweenWithLerp({
    required T Function(T begin, T end, double t) lerp,
    required T super.begin,
    required T super.end,
  }) : _lerp = lerp;

  /// The custom lerp function to interpolate between [begin] and [end].
  final T Function(T begin, T end, double t) _lerp;

  @override
  T get begin => super.begin as T;

  @override
  T get end => super.end as T;

  /// Returns the value this variable has at the given animation clock value.
  @override
  T lerp(double t) => _lerp(begin, end, t);
}

/// A wrapper to handle nullable values.
class _ValueWrapper<T> {
  const _ValueWrapper(this.value);

  final T value;

  @override
  String toString() => '_ValueWrapper($value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! _ValueWrapper<T>) return false;
    return value == other.value;
  }

  @override
  int get hashCode => value?.hashCode ?? 0;
}

class _ValueWrapperTween<T> extends Tween<_ValueWrapper<T?>> {
  _ValueWrapperTween({
    required this.parent,
  }) : super(
          begin: _ValueWrapper<T?>(parent.begin),
          end: _ValueWrapper<T?>(parent.end),
        );

  final Tween<T> parent;

  @override
  set begin(_ValueWrapper<T?>? value) {
    parent.begin = value?.value;
    super.begin = value;
  }

  @override
  set end(_ValueWrapper<T?>? value) {
    parent.end = value?.value;
    super.end = value;
  }

  @override
  _ValueWrapper<T> lerp(double t) {
    return _ValueWrapper(
      parent.lerp(t),
    );
  }
}
