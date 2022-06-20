import 'package:animated_list_view/animated_lists.dart';
import 'package:flutter/material.dart';

Widget customAnimation({
  required Widget child,
  required Animation<double> animation,
  required ShowState state,
}) {
  switch (state) {
    case ShowState.show:
      final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

      final opacityAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

      return SizeTransition(
        sizeFactor: curvedAnimation,
        axis: Axis.vertical,
        child: FadeTransition(
          opacity: opacityAnimation,
          child: child,
        ),
      );

    case ShowState.hide:
      final sizeAnimation = CurvedAnimation(parent: animation, curve: Curves.bounceIn);

      final opacityAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

      return SizeTransition(
        sizeFactor: sizeAnimation,
        axis: Axis.vertical,
        child: FadeTransition(
          opacity: opacityAnimation,
          child: child,
        ),
      );
  }
}
