import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

import 'controller.dart';

/// The render object created from the [AnimatedLocationLeader].
class RenderAnimatedLocationLeaderLayer extends RenderProxyBox {
  /// The render object created from the [AnimatedLocationLeader].
  RenderAnimatedLocationLeaderLayer({
    required AnimatedLocationController controller,
    RenderBox? child,
  }) : super(child) {
    _controller = controller..addStatusListener(_onAnimationStatusChanged);
  }

  AnimatedLocationController get controller => _controller;
  late AnimatedLocationController _controller;
  set controller(AnimatedLocationController value) {
    if (_controller != value) {
      _controller.removeStatusListener(_onAnimationStatusChanged);
      _controller = value;
      _controller.addStatusListener(_onAnimationStatusChanged);
      markNeedsPaint();
    }
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      markNeedsPaint();
    }
  }

  @override
  bool get alwaysNeedsCompositing => true;

  @override
  bool hitTest(BoxHitTestResult result, {Offset? position}) {
    return !controller.isAnimating &&
        super.hitTest(result, position: position!);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final rect = Rect.fromPoints(offset, size.bottomRight(offset));
    _controller.animateIfNeeded(rect);

    if (layer == null) {
      layer = LeaderLayer(link: controller.link, offset: offset);
    } else {
      final leaderLayer = layer as LeaderLayer;
      leaderLayer
        ..link = controller.link
        ..offset = offset;
    }

    // We need to hide the leader when the controller is animating if we just
    // changed of position.
    final painter = controller.isAnimating
        ? (PaintingContext context, Offset offset) =>
            context.pushOpacity(offset, 0, super.paint)
        : super.paint;

    context.pushLayer(layer!, painter, Offset.zero);

    assert(layer != null);
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (!controller.isAnimating) {
      super.visitChildrenForSemantics(visitor);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<AnimatedLocationController>('controller', controller),
    );
  }
}

class RenderLocalHeroFollowerLayer extends RenderProxyBox {
  RenderLocalHeroFollowerLayer({
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

class AnimatedLocationLayer extends ContainerLayer {
  /// Creates an animated location layer.
  AnimatedLocationLayer({
    required this.controller,
  });

  /// An instance which holds the offset from the origin of the leader layer
  /// to the origin of the child layers, used when the layer is linked to a
  /// [LeaderLayer].
  ///
  /// The scene must be explicitly recomposed after this property is changed
  /// (as described in [Layer]).
  AnimatedLocationController controller;

  Offset? _lastOffset;
  Matrix4? _lastTransform;
  Matrix4? _invertedTransform;
  bool _inverseDirty = true;

  Offset? _transformOffset<S>(Offset localPosition) {
    if (_inverseDirty) {
      _invertedTransform = Matrix4.tryInvert(getLastTransform()!);
      _inverseDirty = false;
    }
    if (_invertedTransform == null) {
      return null;
    }
    final Vector4 vector = Vector4(localPosition.dx, localPosition.dy, 0, 1);
    final Vector4 result = _invertedTransform!.transform(vector);
    return Offset(
      result[0] - controller.linkedOffset.dx,
      result[1] - controller.linkedOffset.dy,
    );
  }

  @override
  @protected
  bool findAnnotations<S extends Object>(
    AnnotationResult<S> result,
    Offset localPosition, {
    required bool onlyFirst,
  }) {
    if (controller.link.leader == null) {
      return false;
    }
    final Offset? transformedOffset = _transformOffset<S>(localPosition);
    if (transformedOffset == null) {
      return false;
    }
    return super.findAnnotations<S>(
      result,
      transformedOffset,
      onlyFirst: onlyFirst,
    );
  }

  /// The transform that was used during the last composition phase.
  ///
  /// If the [link] was not linked to a [LeaderLayer], or if this layer has
  /// a degenerate matrix applied, then this will be null.
  ///
  /// This method returns a new [Matrix4] instance each time it is invoked.
  Matrix4? getLastTransform() {
    if (_lastTransform == null) {
      return null;
    }
    final Matrix4 result = Matrix4.translationValues(
      -_lastOffset!.dx,
      -_lastOffset!.dy,
      0,
    );
    result.multiply(_lastTransform!);
    return result;
  }

  /// Call [applyTransform] for each layer in the provided list.
  ///
  /// The list is in reverse order (deepest first). The first layer will be
  /// treated as the child of the second, and so forth. The first layer in the
  /// list won't have [applyTransform] called on it. The first layer may be
  /// null.
  Matrix4 _collectTransformForLayerChain(List<ContainerLayer?> layers) {
    // Initialize our result matrix.
    final Matrix4 result = Matrix4.identity();
    // Apply each layer to the matrix in turn, starting from the last layer,
    // and providing the previous layer as the child.
    for (int index = layers.length - 1; index > 0; index -= 1) {
      layers[index]!.applyTransform(layers[index - 1], result);
    }
    return result;
  }

  /// Populate [_lastTransform] given the current state of the tree.
  void _establishTransform() {
    _lastTransform = null;
    // Check to see if we are linked.
    if (controller.link.leader == null) {
      return;
    }
    // If we're linked, check the link is valid.
    assert(
      controller.link.leader!.owner == owner,
      'Linked LeaderLayer anchor is not in the same layer tree as the FollowerLayer.',
    );
    // Collect all our ancestors into a set so we can recognize them.
    final Set<Layer> ancestors = <Layer>{};
    Layer? ancestor = parent;
    while (ancestor != null) {
      ancestors.add(ancestor);
      ancestor = ancestor.parent;
    }
    // Collect all the layers from a hypothetical child (null) of the target
    // layer up to the common ancestor layer.
    ContainerLayer layer = controller.link.leader!;
    final List<ContainerLayer?> forwardLayers = <ContainerLayer?>[null, layer];
    do {
      layer = layer.parent!;
      forwardLayers.add(layer);
    } while (!ancestors.contains(layer));
    ancestor = layer;
    // Collect all the layers from this layer up to the common ancestor layer.
    layer = this;
    final List<ContainerLayer?> inverseLayers = <ContainerLayer?>[layer];
    do {
      layer = layer.parent!;
      inverseLayers.add(layer);
    } while (layer != ancestor);
    // Establish the forward and backward matrices given these lists of layers.
    final Matrix4 forwardTransform =
        _collectTransformForLayerChain(forwardLayers);
    final Matrix4 inverseTransform =
        _collectTransformForLayerChain(inverseLayers);
    if (inverseTransform.invert() == 0.0) {
      // We are in a degenerate transform, so there's not much we can do.
      return;
    }
    // Combine the matrices and store the result.
    inverseTransform.multiply(forwardTransform);
    inverseTransform.translate(
      controller.linkedOffset.dx,
      controller.linkedOffset.dy,
    );
    _lastTransform = inverseTransform;
    _inverseDirty = true;
  }

  /// {@template flutter.leaderFollower.alwaysNeedsAddToScene}
  /// This disables retained rendering.
  ///
  /// A [FollowerLayer] copies changes from a [LeaderLayer] that could be anywhere
  /// in the Layer tree, and that leader layer could change without notifying the
  /// follower layer. Therefore we have to always call a follower layer's
  /// [addToScene]. In order to call follower layer's [addToScene], leader layer's
  /// [addToScene] must be called first so leader layer must also be considered
  /// as [alwaysNeedsAddToScene].
  /// {@endtemplate}
  @override
  bool get alwaysNeedsAddToScene => true;

  @override
  void addToScene(SceneBuilder builder, [Offset layerOffset = Offset.zero]) {
    if (controller.link.leader == null) {
      _lastTransform = null;
      _lastOffset = null;
      _inverseDirty = true;
      engineLayer = null;
      return;
    }
    _establishTransform();

    if (controller.isAnimating) {
      engineLayer = builder.pushTransform(
        _lastTransform!.storage,
        oldLayer: engineLayer as TransformEngineLayer?,
      );
      addChildrenToScene(builder);
      builder.pop();
    }
    _lastOffset = layerOffset;

    _inverseDirty = true;
  }

  @override
  void applyTransform(Layer? child, Matrix4 transform) {
    assert(child != null);
    transform.multiply(_lastTransform!);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AnimatedLocationController>(
      'controller',
      controller,
    ));
    properties.add(TransformProperty(
      'transform',
      getLastTransform(),
      defaultValue: null,
    ));
  }
}
