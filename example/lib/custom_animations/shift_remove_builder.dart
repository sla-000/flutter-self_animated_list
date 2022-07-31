import 'package:flutter/material.dart';
import 'package:self_animated_list/self_animated_list.dart';

Widget shiftRemoveBuilder(AnimationData animationData) {
  final curvedAnimation = CurvedAnimation(
    parent: animationData.animation,
    curve: Curves.easeInCubic,
  );

  final sizeAnimation = curvedAnimation;

  final rotationAnimation = Tween<double>(
    begin: _calcRotation(animationData.index, animationData.count),
    end: 0,
  ).animate(animationData.animation);

  final opacityAnimation = animationData.animation;

  return SizeTransition(
    sizeFactor: sizeAnimation,
    axis: Axis.horizontal,
    child: RotationTransition(
      turns: rotationAnimation,
      child: FadeTransition(
        opacity: opacityAnimation,
        child: animationData.child,
      ),
    ),
  );
}

double _calcRotation(int index, int count) {
  final offset = count / 2;
  return (index - offset) / offset * 0.5;
}
