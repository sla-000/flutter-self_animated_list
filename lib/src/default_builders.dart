import 'package:flutter/material.dart';

import '../self_animated_list.dart';

Widget defaultAddBuilder(AnimationData animationData) => defaultCurveBuilder(
      animation: animationData.animation,
      axis: Scrollable.of(animationData.context)!.widget.axis,
      curve: Curves.easeOutCubic,
      child: animationData.child,
    );

Widget defaultRemoveBuilder(AnimationData animationData) => defaultCurveBuilder(
      animation: animationData.animation,
      axis: Scrollable.of(animationData.context)!.widget.axis,
      child: animationData.child,
    );

Widget defaultCurveBuilder({
  required Animation<double> animation,
  Axis axis = Axis.vertical,
  Curve curve = Curves.easeInCubic,
  required Widget child,
}) {
  final CurvedAnimation curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
  final Animation<double> opacityAnimation = animation;

  return SizeTransition(
    sizeFactor: curvedAnimation,
    axis: axis,
    child: FadeTransition(
      opacity: opacityAnimation,
      child: child,
    ),
  );
}
