import 'package:animated_collection/src/widgets/duration.dart';
import 'package:flutter/material.dart';

import 'animated_size_transition.dart';

/// Conditionally renders the child with an animated size transition when
/// [visible] is `true`; otherwise renders a [SizedBox.shrink].
class AnimatedVisibility extends StatelessWidget {
  /// Conditionally renders the child with an animated size transition when
  /// [visible] is `true`; otherwise renders a [SizedBox.shrink].
  const AnimatedVisibility({
    required this.visible,
    this.child,
    this.axis = Axis.vertical,
    this.axisAlignment = 0,
    this.curve = Curves.easeInOut,
    this.duration = defaultDuration,
    super.key,
  }) : builder = null;

  /// Shows the widget returned by [builder] when [visible] is `true`, and a
  /// [SizedBox.shrink] when [visible] is `false`, with a smooth size
  /// transition.
  ///
  /// This constructor is helpful when the widget relies on data that’s only
  /// available when [visible] is `true`.
  ///
  /// For instance, the following example would throw an error:
  ///
  /// ```dart
  /// String? text;
  /// AnimatedVisibility(
  ///   visible: text != null,
  ///   child: Text(text!), // Throws if text is null
  /// )
  /// ```
  ///
  /// To prevent that, you’d need to handle the null case explicitly:
  ///
  /// ```dart
  /// String? text;
  /// AnimatedVisibility(
  ///   visible: text != null,
  ///   child: Text(text ?? ''),
  /// )
  /// ```
  ///
  /// With [AnimatedVisibility.builder], you can safely access the non-null data
  /// inside the builder without extra null checks:
  ///
  /// ```dart
  /// String? text;
  /// AnimatedVisibility.builder(
  ///   visible: text != null,
  ///   builder: (context) => Text(text!),
  /// )
  /// ```

  const AnimatedVisibility.builder({
    required this.visible,
    this.builder,
    this.axis = Axis.vertical,
    this.axisAlignment = 0,
    this.curve = Curves.easeInOut,
    this.duration = defaultDuration,
    super.key,
  }) : child = null;

  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// Called to obtain the child widget.
  final WidgetBuilder? builder;

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
      child: visible ? child ?? builder!(context) : const SizedBox.shrink(),
    );
  }
}
