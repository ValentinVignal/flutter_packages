import 'package:animated_collection/src/widgets/duration.dart';
import 'package:flutter/material.dart';

import 'animated_size_transition.dart';

/// Displays the child when [visible] is `true` and a [SizedBox.shrink] when
/// [visible] is `false`, but does it with a size transition.
class AnimatedVisibility extends StatelessWidget {
  /// Displays the child when [visible] is `true` and a [SizedBox.shrink] when
  /// [visible] is `false`, but does it with a size transition.
  const AnimatedVisibility({
    required this.visible,
    required this.child,
    this.axis = Axis.vertical,
    this.axisAlignment = 0,
    this.curve = Curves.easeInOut,
    this.duration = defaultDuration,
    super.key,
  });

  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// If `true`, it displays the [child], else if displays a [SizedBox.shrink].
  final bool visible;

  /// The axis of the transition. The default is [Axis.vertical].
  final Axis axis;

  /// Axis alignment given to the [SizeTransition].
  final double axisAlignment;

  /// The curve given to the [AnimatedSwitcher].
  final Curve curve;

  /// The duration of the animation.
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSizeTransition(
      axis: axis,
      axisAlignment: axisAlignment,
      curve: curve,
      fixedCrossAxisSizeFactor: 1,
      duration: duration,
      child: visible ? child : const SizedBox.shrink(),
    );
  }
}
