import 'package:flutter/material.dart';

/// A custom [ScrollController] that enables smooth Webflow-like mouse wheel scrolling
/// on desktop and web, while keeping trackpad, touch, and scrollbar gestures native.
class SmoothScrollController extends ScrollController {
  SmoothScrollController({
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
  });

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return SmoothScrollPosition(
      physics: physics,
      context: context,
      initialPixels: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
    );
  }
}

class SmoothScrollPosition extends ScrollPositionWithSingleContext {
  SmoothScrollPosition({
    required super.physics,
    required super.context,
    super.initialPixels,
    super.keepScrollOffset,
    super.oldPosition,
    super.debugLabel,
  });

  double? _targetPixels;

  @override
  void pointerScroll(double delta) {
    if (delta == 0.0) return;

    // Distinguish between trackpad (continuous scrolling, very small deltas)
    // and mouse wheel (discrete clicks, larger deltas).
    // Under 15.0 px delta, we bypass the animation to keep trackpad scroll 100% responsive.
    if (delta.abs() < 15.0) {
      super.pointerScroll(delta);
      return;
    }

    final double startPixels = _targetPixels ?? pixels;
    
    // Sync back if direction changed or current position is far from target (e.g., scrollbar drag)
    final bool directionChanged = (delta > 0 && startPixels < pixels) || 
                                  (delta < 0 && startPixels > pixels);
    final bool outOfSync = (pixels - startPixels).abs() > 120.0;
    
    final double basePixels = (directionChanged || outOfSync) ? pixels : startPixels;
    // Multiply delta by 2.0 to give a satisfying scrolling step
    double target = basePixels + (delta * 2.0);
    target = target.clamp(minScrollExtent, maxScrollExtent);

    if (target != pixels) {
      _targetPixels = target;
      
      animateTo(
        target,
        duration: const Duration(milliseconds: 550), // Gliding duration for momentum feel
        curve: Curves.easeOutQuart, // Decelerates smoothly at the end
      ).then((_) {
        if (_targetPixels == target) {
          _targetPixels = null;
        }
      });
    }
  }

  @override
  void jumpTo(double value) {
    _targetPixels = null;
    super.jumpTo(value);
  }
}
