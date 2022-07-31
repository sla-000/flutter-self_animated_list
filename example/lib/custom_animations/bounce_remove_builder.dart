import 'package:flutter/material.dart';

Widget bounceRemoveBuilder(
    BuildContext context, Animation<double> animation, int index, Widget child) {
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
