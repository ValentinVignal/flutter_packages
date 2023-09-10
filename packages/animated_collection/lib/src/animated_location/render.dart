import 'package:animated_collection/src/animated_location/layer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'controller.dart';

class AnimatedLocationFollower extends SingleChildRenderObjectWidget {
  const AnimatedLocationFollower({
    required this.controller,
    super.key,
    super.child,
  });

  final AnimatedLocationController controller;

  @override
  AnimatedLocationFollowerElement createElement() {
    return AnimatedLocationFollowerElement(this);
  }

  @override
  RenderAnimatedLocationFollowerLayer createRenderObject(BuildContext context) {
    return RenderAnimatedLocationFollowerLayer(
      controller: controller,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderAnimatedLocationFollowerLayer renderObject,
  ) {
    renderObject.controller = controller;
  }
}

class AnimatedLocationFollowerElement extends SingleChildRenderObjectElement {
  AnimatedLocationFollowerElement(AnimatedLocationFollower super.widget);

  @override
  AnimatedLocationFollower get widget =>
      super.widget as AnimatedLocationFollower;

  @override
  void debugVisitOnstageChildren(ElementVisitor visitor) {
    if (widget.controller.isAnimating) {
      super.debugVisitOnstageChildren(visitor);
    }
  }
}

class AnimatedLocationLeader extends SingleChildRenderObjectWidget {
  /// Creates a composited transform target widget.
  ///
  /// The [link] property must not be null, and must not be currently being used
  /// by any other [CompositedTransformTarget] object that is in the tree.
  const AnimatedLocationLeader({
    Key? key,
    required this.controller,
    Widget? child,
  }) : super(key: key, child: child);

  final AnimatedLocationController controller;

  @override
  AnimatedLocationLeaderElement createElement() {
    return AnimatedLocationLeaderElement(this);
  }

  @override
  RenderAnimatedLocationLeaderLayer createRenderObject(BuildContext context) {
    return RenderAnimatedLocationLeaderLayer(
      controller: controller,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderAnimatedLocationLeaderLayer renderObject,
  ) {
    renderObject.controller = controller;
  }
}

/// The element of the [AnimatedLocationLeader].
class AnimatedLocationLeaderElement extends SingleChildRenderObjectElement {
  AnimatedLocationLeaderElement(AnimatedLocationLeader widget) : super(widget);

  @override
  AnimatedLocationLeader get widget => super.widget as AnimatedLocationLeader;

  @override
  void debugVisitOnstageChildren(ElementVisitor visitor) {
    if (!widget.controller.isAnimating) {
      super.debugVisitOnstageChildren(visitor);
    }
  }
}

class RenderAnimatedLocationFollowerLayer extends RenderProxyBox {
  RenderAnimatedLocationFollowerLayer({
    required AnimatedLocationController controller,
    RenderBox? child,
  }) : super(child) {
    _controller = controller..addListener(markNeedsLayout);
  }

  AnimatedLocationController get controller => _controller;
  late AnimatedLocationController _controller;
  set controller(AnimatedLocationController value) {
    if (_controller != value) {
      _controller.removeListener(markNeedsLayout);
      _controller = value;
      _controller.addListener(markNeedsLayout);
      markNeedsPaint();
    }
  }

  @override
  void detach() {
    layer = null;
    super.detach();
  }

  @override
  bool get alwaysNeedsCompositing => true;

  /// The layer we created when we were last painted.
  @override
  AnimatedLocationLayer? get layer => super.layer as AnimatedLocationLayer?;

  /// Return the transform that was used in the last composition phase, if any.
  ///
  /// If the [FollowerLayer] has not yet been created, was never composited, or
  /// was unable to determine the transform (see
  /// [FollowerLayer.getLastTransform]), this returns the identity matrix (see
  /// [Matrix4.identity].
  Matrix4 getCurrentTransform() {
    return layer?.getLastTransform() ?? Matrix4.identity();
  }

  @override
  bool hitTest(BoxHitTestResult result, {Offset? position}) {
    // We can never interact with this follower.
    return false;
  }

  @override
  void performLayout() {
    final Size? requestedSize = controller.linkedSize;
    final BoxConstraints childConstraints = requestedSize == null
        ? constraints
        : constraints.enforce(BoxConstraints.tight(requestedSize));
    child!.layout(childConstraints, parentUsesSize: true);
    size = constraints.constrain(child!.size);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (layer == null) {
      layer = AnimatedLocationLayer(controller: controller);
    } else {
      layer!.controller = controller;
    }

    context.pushLayer(
      layer!,
      super.paint,
      Offset.zero,
      childPaintBounds: const Rect.fromLTRB(
        // We don't know where we'll end up, so we have no idea what our cull rect should be.
        double.negativeInfinity,
        double.negativeInfinity,
        double.infinity,
        double.infinity,
      ),
    );
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (controller.isAnimating) {
      super.visitChildrenForSemantics(visitor);
    }
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.multiply(getCurrentTransform());
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AnimatedLocationController>(
      'controller',
      controller,
    ));
    properties.add(TransformProperty(
      'current transform matrix',
      getCurrentTransform(),
    ));
  }
}
