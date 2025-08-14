import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

typedef RectTweenSupplier = Tween<Rect?> Function(Rect begin, Rect end);

/// A controller for an [AnimatedLocation].
class AnimatedLocationController {
  /// A controller for an [AnimatedLocation].
  AnimatedLocationController({
    required TickerProvider vsync,
    required this.tag,
    required Duration duration,
    required this.curve,
    required this.createRectTween,
  })  : _vsync = vsync,
        _initialDuration = duration;

  final TickerProvider _vsync;

  /// The tag associated to the [AnimatedLocation] this controller is tracking.
  final Object tag;

  Curve curve;
  RectTweenSupplier createRectTween;
  final Duration _initialDuration;

  /// [true] if the controller is currently animating.
  bool get isAnimating => _isAnimating;
  bool _isAnimating = false;

  /// The animation.
  Animation<Rect?>? _animation;

  /// The last rectangle.
  Rect? _lastRect;

  /// The link.
  final link = LayerLink();

  /// The current top left offset of the [AnimatedLocation].
  Offset get linkedOffset => _animation?.value?.topLeft ?? _lastRect!.topLeft;

  /// The current size of the `AnimatedLocation`.
  Size? get linkedSize => _animation?.value?.size ?? _lastRect?.size;

  late final AnimationController _controller =
      AnimationController(vsync: _vsync, duration: _initialDuration)
        ..addStatusListener(_onAnimationStatusChanged);

  /// Adds a listener to status changes.
  void addStatusListener(AnimationStatusListener listener) {
    _controller.addStatusListener(listener);
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _isAnimating = false;
      _animation = null;
      _controller.value = 0;
    }
  }

  /// Removes a listener to status changes.
  void removeStatusListener(AnimationStatusListener listener) {
    _controller.removeStatusListener(listener);
  }

  /// Animates the location of the [AnimatedLocation] if needed.
  void animateIfNeeded(Rect rect) {
    if (_lastRect != null && _lastRect != rect) {
      final bool inAnimation = isAnimating;
      Rect from = Rect.fromLTWH(
        _lastRect!.left - rect.left,
        _lastRect!.top - rect.top,
        _lastRect!.width,
        _lastRect!.height,
      );
      if (inAnimation) {
        // We need to recompute the from.
        final Rect currentRect = _animation!.value!;
        from = Rect.fromLTWH(
          currentRect.left + _lastRect!.left - rect.left,
          currentRect.top + _lastRect!.top - rect.top,
          currentRect.width,
          currentRect.height,
        );
      }
      _isAnimating = true;

      _animation = _controller.drive(CurveTween(curve: curve)).drive(
            createRectTween(
              from,
              Rect.fromLTWH(
                0,
                0,
                rect.width,
                rect.height,
              ),
            ),
          );

      if (!inAnimation) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _controller.forward();
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          final Duration duration =
              _controller.duration! * (1 - _controller.value);
          _controller.reset();
          _controller.animateTo(
            1,
            duration: duration,
          );
        });
      }
    }
    _lastRect = rect;
  }

  void dispose() {
    _controller.stop();
    _controller.removeStatusListener(_onAnimationStatusChanged);
    _controller.dispose();
  }

  void addListener(VoidCallback listener) {
    _controller.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    _controller.removeListener(listener);
  }
}
