import 'package:flutter/material.dart';

/// A widget that by default does a size transition between a new widget and the
/// widget previously set on the [AnimatedSizeTransition] as a [child].
class AnimatedSizeTransition extends StatelessWidget {
  /// A widget that by default does a size transition between a new widget and
  /// the widget previously set on the [AnimatedSizeTransition] as a [child].
  const AnimatedSizeTransition({
    required this.child,
    this.axis = Axis.vertical,
    this.axisAlignment = 0,
    this.curve = Curves.easeInOut,
    this.duration = defaultDuration,
    this.fixedCrossAxisSizeFactor,
    super.key,
  });

  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// The axis of the transition. The default is [Axis.vertical].
  final Axis axis;

  /// Axis alignment given to the [SizeTransition].
  final double axisAlignment;

  /// The curve given to the [AnimatedSwitcher].
  final Curve curve;

  /// The duration of the animation.
  final Duration duration;

  /// The size factor on the cross axis.
  final double? fixedCrossAxisSizeFactor;

  /// The duration of the transition.
  @visibleForTesting
  static const defaultDuration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          axis: axis,
          axisAlignment: axisAlignment,
          fixedCrossAxisSizeFactor: fixedCrossAxisSizeFactor,
          child: child,
        );
      },
      switchInCurve: curve,
      switchOutCurve: curve,
      child: child,
    );
  }
}
