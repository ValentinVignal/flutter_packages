import 'package:animated_collection/animated_collection.dart';
import 'package:animated_collection/src/widgets/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A widgets that appears with an animation.
class AnimatedAppearing extends StatefulWidget {
  /// A widgets that appears with an animation.
  const AnimatedAppearing({
    required this.child,
    this.axis = Axis.vertical,
    this.axisAlignment = 0,
    this.curve = Curves.easeInOut,
    this.duration = defaultDuration,
    super.key,
  });

  /// The child.
  final Widget child;

  /// The axis of the transition. The default is [Axis.vertical].
  final Axis axis;

  /// Axis alignment given to the [SizeTransition].
  final double axisAlignment;

  /// The curve given to the [AnimatedSwitcher].
  final Curve curve;

  /// The duration of the animation.
  final Duration duration;

  @override
  State<AnimatedAppearing> createState() => _AnimatedAppearingState();
}

class _AnimatedAppearingState extends State<AnimatedAppearing> {
  var _visible = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedVisibility(
      visible: _visible,
      axis: widget.axis,
      axisAlignment: widget.axisAlignment,
      curve: widget.curve,
      duration: widget.duration,
      child: widget.child,
    );
  }
}
