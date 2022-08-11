import 'package:flutter/material.dart';
import 'package:self_animated_list/self_animated_list.dart';

Widget shiftAddBuilder(AnimationData animationData) {
  final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animationData.animation,
    curve: Curves.easeOutCubic,
  );

  final CurvedAnimation sizeAnimation = curvedAnimation;

  final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).animate(curvedAnimation);

  final CurvedAnimation opacityAnimation = curvedAnimation;

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
