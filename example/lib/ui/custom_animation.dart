import 'package:flutter/material.dart';

Widget customAnimation({
  required Widget child,
  required Animation<double> animation,
  required bool appearing,
}) {
  if (appearing) {
    final curvedAnimation =
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

    return SizeTransition(
      sizeFactor: curvedAnimation,
      axis: Axis.vertical,
      child: child,
    );
  } else {
    final sizeAnimation =
        CurvedAnimation(parent: animation, curve: Curves.bounceOut.flipped);

    final opacityAnimation =
        CurvedAnimation(parent: animation, curve: Curves.easeInExpo.flipped);

    return SizeTransition(
      sizeFactor: sizeAnimation,
      axis: Axis.vertical,
      child: Opacity(
        opacity: opacityAnimation.value,
        child: child,
      ),
    );
  }
}
