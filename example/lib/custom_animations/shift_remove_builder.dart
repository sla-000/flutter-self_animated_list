import 'package:flutter/material.dart';

Widget shiftRemoveBuilder({
  required Animation<double> animation,
  required Widget child,
  bool quick = false,
}) {
  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: quick ? Curves.easeInCubic : Curves.easeOutCubic,
  );

  final sizeAnimation = curvedAnimation;

  final offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
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
          child: child,
        ),
      ),
    ),
  );
}
