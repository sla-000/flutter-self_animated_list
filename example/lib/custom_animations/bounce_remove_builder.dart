import 'package:flutter/material.dart';

Widget bounceRemoveBuilder(Animation<double> animation, Widget child) {
  final sizeAnimation = CurvedAnimation(parent: animation, curve: Curves.bounceIn);
  final opacityAnimation = animation;

  return SizeTransition(
    sizeFactor: sizeAnimation,
    axis: Axis.vertical,
    child: FadeTransition(
      opacity: opacityAnimation,
      child: child,
    ),
  );
}
