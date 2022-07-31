import 'package:flutter/material.dart';
import 'package:self_animated_list/self_animated_list.dart';

Widget shiftAddBuilder(AnimationData animationData) {
  final curvedAnimation = CurvedAnimation(
    parent: animationData.animation,
    curve: Curves.easeOutCubic,
  );

  final sizeAnimation = curvedAnimation;

  final offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: const Offset(0.0, 0.0),
  ).animate(curvedAnimation);

  final opacityAnimation = curvedAnimation;

  return ClipRect(
    child: SlideTransition(
      position: offsetAnimation,
      child: SizeTransition(
        sizeFactor: sizeAnimation,
        axis: Axis.horizontal,
        child: FadeTransition(
          opacity: opacityAnimation,
          child: animationData.child,
        ),
      ),
    ),
  );
}
