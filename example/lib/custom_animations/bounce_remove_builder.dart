import 'package:flutter/material.dart';
import 'package:self_animated_list/self_animated_list.dart';

Widget bounceRemoveBuilder(AnimationData animationData) {
  final sizeAnimation = CurvedAnimation(
    parent: animationData.animation,
    curve: Curves.bounceIn,
  );
  final opacityAnimation = animationData.animation;

  return SizeTransition(
    sizeFactor: sizeAnimation,
    axis: Axis.vertical,
    child: FadeTransition(
      opacity: opacityAnimation,
      child: animationData.child,
    ),
  );
}
