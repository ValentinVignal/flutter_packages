import 'package:flutter/material.dart';

/// Widget to create an horizontal slide transition.
class AnimatedHorizontalSlide extends AnimatedWidget {
  /// Widget to create an horizontal slide transition.
  const AnimatedHorizontalSlide({
    required Animation<double> super.listenable,
    required this.child,
    super.key,
  });

  /// Child.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return ClipRect(
      child: Align(
        widthFactor: animation.value,
        child: child,
      ),
    );
  }
}
