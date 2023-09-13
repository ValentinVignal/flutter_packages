import 'dart:math' as math;

import 'package:flutter/material.dart';

/// {@template animated_collection.TightSizeTransition}
/// This is a copy of [SizeTransition] with the extra parameter []
/// {@endtemplate}
class TightSizeTransition extends AnimatedWidget {
  /// {@macro animated_collection.TightSizeTransition}
  const TightSizeTransition({
    super.key,
    this.axis = Axis.vertical,
    required Animation<double> sizeFactor,
    this.axisAlignment = 0.0,
    this.crossAxisSizeFactor = 1,
    this.child,
  }) : super(listenable: sizeFactor);

  /// [Axis.horizontal] if [sizeFactor] modifies the width, otherwise
  /// [Axis.vertical].
  final Axis axis;

  /// The animation that controls the (clipped) size of the child.
  ///
  /// The width or height (depending on the [axis] value) of this widget will be
  /// its intrinsic width or height multiplied by [sizeFactor]'s value at the
  /// current point in the animation.
  ///
  /// If the value of [sizeFactor] is less than one, the child will be clipped
  /// in the appropriate axis.
  Animation<double> get sizeFactor => listenable as Animation<double>;

  /// Describes how to align the child along the axis that [sizeFactor] is
  /// modifying.
  ///
  /// A value of -1.0 indicates the top when [axis] is [Axis.vertical], and the
  /// start when [axis] is [Axis.horizontal]. The start is on the left when the
  /// text direction in effect is [TextDirection.ltr] and on the right when it
  /// is [TextDirection.rtl].
  ///
  /// A value of 1.0 indicates the bottom or end, depending upon the [axis].
  ///
  /// A value of 0.0 (the default) indicates the center for either [axis] value.
  final double axisAlignment;

  /// The factor to multiply the cross axis size of the child by.
  ///
  /// If the value of [crossAxisSizeFactor] is less than one, the child will be
  /// clipped in the appropriate axis.
  final double? crossAxisSizeFactor;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final AlignmentDirectional alignment;
    if (axis == Axis.vertical) {
      alignment = AlignmentDirectional(-1.0, axisAlignment);
    } else {
      alignment = AlignmentDirectional(axisAlignment, -1.0);
    }
    return ClipRect(
      child: Align(
        alignment: alignment,
        heightFactor: axis == Axis.vertical
            ? math.max(sizeFactor.value, 0.0)
            : crossAxisSizeFactor,
        widthFactor: axis == Axis.horizontal
            ? math.max(sizeFactor.value, 0.0)
            : crossAxisSizeFactor,
        child: child,
      ),
    );
  }
}
