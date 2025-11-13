import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Tracker that manages which RenderBoxes are allowed to receive pointer events
/// even when [SelectiveIgnorePointer] is ignoring.
class _SelectiveIgnorePointerTracker {
  final Set<RenderBox> _allowedBoxes = {};

  void register(RenderBox box) => _allowedBoxes.add(box);

  void unregister(RenderBox box) => _allowedBoxes.remove(box);

  Set<RenderBox> get allowedBoxes => _allowedBoxes;
}

/// InheritedWidget that provides the tracker to the widget tree.
class _SelectiveIgnorePointerScope extends InheritedWidget {
  const _SelectiveIgnorePointerScope({
    required this.tracker,
    required this.isInsidePassthrough,
    required super.child,
  });

  final _SelectiveIgnorePointerTracker tracker;

  /// Whether we're currently inside a [PointerPassthrough] widget.
  /// Used to detect invalid nesting of [PointerPassthrough] widgets.
  final bool isInsidePassthrough;

  @override
  bool updateShouldNotify(_SelectiveIgnorePointerScope old) =>
      tracker != old.tracker || isInsidePassthrough != old.isInsidePassthrough;

  static _SelectiveIgnorePointerScope? _maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_SelectiveIgnorePointerScope>();
  }
}

/// A widget that blocks pointer events from its children EXCEPT from those
/// wrapped with [PointerPassthrough].
class SelectiveIgnorePointer extends StatefulWidget {
  /// A widget that blocks pointer events from its children EXCEPT from those
  /// wrapped with [PointerPassthrough].
  const SelectiveIgnorePointer({
    required this.child,
    super.key,
    this.ignoring = true,
  });

  /// Whether this widget is ignoring pointer events.
  final bool ignoring;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<SelectiveIgnorePointer> createState() => _SelectiveIgnorePointerState();
}

class _SelectiveIgnorePointerState extends State<SelectiveIgnorePointer> {
  final _tracker = _SelectiveIgnorePointerTracker();

  @override
  Widget build(BuildContext context) {
    return _SelectiveIgnorePointerScope(
      tracker: _tracker,
      isInsidePassthrough: false,
      child: _SelectiveIgnorePointerRenderWidget(
        ignoring: widget.ignoring,
        tracker: _tracker,
        child: widget.child,
      ),
    );
  }
}

/// Internal widget that creates the custom RenderObject for
/// [SelectiveIgnorePointer].
class _SelectiveIgnorePointerRenderWidget
    extends SingleChildRenderObjectWidget {
  const _SelectiveIgnorePointerRenderWidget({
    required this.ignoring,
    required this.tracker,
    required super.child,
  });

  final bool ignoring;
  final _SelectiveIgnorePointerTracker tracker;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSelectiveIgnorePointer(ignoring: ignoring, tracker: tracker);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderSelectiveIgnorePointer renderObject,
  ) {
    renderObject
      ..ignoring = ignoring
      ..tracker = tracker;
  }
}

/// RenderObject that implements selective hit testing.
///
/// When [ignoring] is true, this render object will first check if any
/// registered allowed boxes (via [PointerPassthrough]) should handle the hit.
/// If none do, it blocks the hit entirely.
class _RenderSelectiveIgnorePointer extends RenderProxyBox {
  _RenderSelectiveIgnorePointer({
    required bool ignoring,
    required _SelectiveIgnorePointerTracker tracker,
  }) : _ignoring = ignoring,
       _tracker = tracker;

  bool _ignoring;

  bool get ignoring => _ignoring;

  set ignoring(bool value) {
    if (_ignoring == value) return;
    _ignoring = value;
  }

  _SelectiveIgnorePointerTracker _tracker;
  set tracker(_SelectiveIgnorePointerTracker value) {
    _tracker = value;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (!ignoring) {
      return super.hitTest(result, position: position);
    }

    // When ignoring, first check if any allowed boxes should handle this
    for (final box in _tracker.allowedBoxes) {
      if (!box.attached) continue;

      try {
        final transform = box.getTransformTo(this);
        final invertedTransform = Matrix4.tryInvert(transform);

        if (invertedTransform == null) continue;

        final localPosition = MatrixUtils.transformPoint(
          invertedTransform,
          position,
        );

        // Use BoxHitTestResult.wrap so hits are added to our result
        if (box.hitTest(
          BoxHitTestResult.wrap(result),
          position: localPosition,
        )) {
          return true;
        }
      } catch (_) {
        // If transform fails, skip this box
        continue;
      }
    }

    // If no allowed box handled it, block the hit
    return false;
  }
}

/// A widget that allows pointer events to pass through even when wrapped
/// inside a [SelectiveIgnorePointer] that is ignoring.
///
/// This widget registers itself with the nearest [SelectiveIgnorePointer]
/// ancestor, allowing it to receive pointer events even when other children
/// are blocked.
class PointerPassthrough extends StatelessWidget {
  /// A widget that allows pointer events to pass through even when wrapped
  /// inside a [SelectiveIgnorePointer] that is ignoring.
  ///
  /// This widget registers itself with the nearest [SelectiveIgnorePointer]
  /// ancestor, allowing it to receive pointer events even when other children
  /// are blocked.
  const PointerPassthrough({
    required this.child,
    super.key,
    this.allowing = true,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Whether this widget allows pointer events to pass through.
  final bool allowing;

  @override
  Widget build(BuildContext context) {
    final scope = _SelectiveIgnorePointerScope._maybeOf(context);

    assert(
      scope != null,
      'PointerPassthrough must be used inside a SelectiveIgnorePointer',
    );

    if (scope == null) {
      // Return child as-is if not inside SelectiveIgnorePointer
      // (should not happen in production due to assert above)
      return child;
    }

    assert(
      !scope.isInsidePassthrough,
      'PointerPassthrough cannot be nested inside another PointerPassthrough '
      'within the same SelectiveIgnorePointer scope. '
      'Nested PointerPassthrough widgets are redundant and indicate a logic error.',
    );

    return _SelectiveIgnorePointerScope(
      tracker: scope.tracker,
      isInsidePassthrough: true,
      child: _PointerPassthroughRenderWidget(
        allowing: allowing,
        tracker: scope.tracker,
        child: child,
      ),
    );
  }
}

/// Internal widget that creates the custom RenderObject for
/// [PointerPassthrough].
class _PointerPassthroughRenderWidget extends SingleChildRenderObjectWidget {
  const _PointerPassthroughRenderWidget({
    required this.allowing,
    required this.tracker,
    required super.child,
  });

  final bool allowing;
  final _SelectiveIgnorePointerTracker tracker;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderPointerPassthrough(allowing: allowing, tracker: tracker);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderPointerPassthrough renderObject,
  ) {
    renderObject.allowing = allowing;
  }
}

/// Custom RenderObject for [PointerPassthrough].
///
/// Registers/un-registers itself with the tracker based on [allowing] state.
class _RenderPointerPassthrough extends RenderProxyBox {
  _RenderPointerPassthrough({
    required bool allowing,
    required _SelectiveIgnorePointerTracker tracker,
  }) : _allowing = allowing,
       _tracker = tracker;

  bool _allowing;
  final _SelectiveIgnorePointerTracker _tracker;

  bool get allowing => _allowing;

  set allowing(bool value) {
    if (_allowing == value) return;
    _allowing = value;

    if (_allowing) {
      _tracker.register(this);
    } else {
      _tracker.unregister(this);
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    if (_allowing) {
      _tracker.register(this);
    }
  }

  @override
  void detach() {
    _tracker.unregister(this);
    super.detach();
  }
}
