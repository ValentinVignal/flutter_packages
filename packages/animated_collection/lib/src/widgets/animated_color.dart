import 'package:flutter/widgets.dart';

import 'animated_value.dart';

/// {@template animated_collection.animated_color}
/// A widget that animates a color value using [Color.lerp].
///
/// See also:
/// - [AnimatedValueWidget], which animates a value of type `T` using a custom
///   lerp function or a tween.
/// {@endtemplate}
class AnimatedColor extends StatelessWidget {
  /// {@macro animated_collection.animated_color}
  const AnimatedColor({
    required this.color,
    required this.builder,
    this.child,
    super.key,
    this.duration = AnimatedValueWidget.defaultDuration,
    this.curve = Curves.linear,
  });

  /// The color to animate.
  final Color? color;

  /// The builder that will be animated whenever the color changes.
  final Widget Function(BuildContext context, Widget? child, Color? value)
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
    return AnimatedValueWidget<_ColorWrapper>.lerp(
      value: _ColorWrapper(color),
      builder: (BuildContext context, Widget? child, _ColorWrapper value) =>
          builder(context, child, value.color),
      lerp: (a, b, t) {
        return _ColorWrapper(Color.lerp(a.color, b.color, t));
      },
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}

class _ColorWrapper {
  const _ColorWrapper(this.color);

  final Color? color;

  @override
  String toString() => 'ColorWrapper($color)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! _ColorWrapper) return false;
    return color == other.color;
  }

  @override
  int get hashCode => color?.hashCode ?? 0;
}
