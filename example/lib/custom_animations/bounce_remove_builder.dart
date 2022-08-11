import 'package:flutter/material.dart';
import 'package:self_animated_list/self_animated_list.dart';

Widget bounceRemoveBuilder(AnimationData animationData) {
  final CurvedAnimation sizeAnimation = CurvedAnimation(
    parent: animationData.animation,
    curve: Curves.bounceIn,
  );
  final Animation<double> opacityAnimation = animationData.animation;

  return SizeTransition(
    sizeFactor: sizeAnimation,
    child: FadeTransition(
      opacity: opacityAnimation,
      child: animationData.child,
    ),
  );
}
