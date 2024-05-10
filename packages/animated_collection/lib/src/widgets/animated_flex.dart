import 'package:animated_collection/src/widgets/duration.dart';
import 'package:flutter/material.dart';

/// An animated version of [Flexible] that animates its flex value.
///
/// As long as https://github.com/flutter/flutter/issues/22512 in not fixed, we
/// need high number to make it smooth.
///
/// See also:
/// - [AnimatedExpanded], which is an animated version of [Expanded].
/// - [AnimatedSpacer], which is an animated version of [Spacer].
class AnimatedFlexible extends ImplicitlyAnimatedWidget {
  const AnimatedFlexible({
    required this.child,
    this.flex = 1,
    this.fit = FlexFit.loose,
    super.duration = defaultDuration,
    super.curve,
    super.key,
  }) : assert(flex == null || flex >= 0);

  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// The flex factor to use in determining how much space to take up.
  final num? flex;

  /// How a flexible child is inscribed into the available space.
  final FlexFit fit;

  @override
  AnimatedWidgetBaseState<AnimatedFlexible> createState() =>
      _AnimatedExpandedState();
}

class _AnimatedExpandedState extends AnimatedWidgetBaseState<AnimatedFlexible> {
  Tween<num?>? _tween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _tween = visitor(_tween, widget.flex, (dynamic value) {
      return Tween<num?>(begin: value as num?);
    })! as Tween<num?>;
  }

  @override
  Widget build(BuildContext context) {
    final flex = _tween!.evaluate(animation);
    final intFlex = flex?.toInt() ?? 0;
    if (flex != null && intFlex == 0) {
      return const SizedBox.shrink();
    }
    return Flexible(
      flex: intFlex,
      fit: widget.fit,
      child: widget.child,
    );
  }
}

/// An animated version of [Expanded] that animates its flex value.
///
/// As long as https://github.com/flutter/flutter/issues/22512 in not fixed, we
/// need high number to make it smooth.
///
/// See also:
/// - [AnimatedFlexible], which is an animated version of [Flexible].
/// - [AnimatedSpacer], which is an animated version of [Spacer].
class AnimatedExpanded extends AnimatedFlexible {
  const AnimatedExpanded({
    super.key,
    required super.child,
    super.flex = 1,
    super.duration,
    super.curve,
  }) : super(fit: FlexFit.tight);
}

/// An animated version of [Spacer] that animates its flex value.
///
/// As long as https://github.com/flutter/flutter/issues/22512 in not fixed, we
/// need high number to make it smooth.
///
/// See also:
/// - [AnimatedFlexible], which is an animated version of [Flexible].
/// - [AnimatedExpanded], which is an animated version of [Expanded].
class AnimatedSpacer extends StatelessWidget {
  const AnimatedSpacer({
    super.key,
    this.flex = 1,
    this.duration = defaultDuration,
    this.curve = Curves.linear,
  });

  /// The flex factor to use in determining how much space to take up.
  final num? flex;

  /// The curve to apply when animating the parameters of this container.
  final Curve curve;

  /// The duration over which to animate the parameters of this container.
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedExpanded(
      flex: flex,
      curve: curve,
      duration: duration,
      child: const SizedBox.shrink(),
    );
  }
}
