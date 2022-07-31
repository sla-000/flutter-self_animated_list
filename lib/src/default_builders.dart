import 'package:flutter/material.dart';

Widget defaultAddBuilder(
  BuildContext context,
  Animation<double> animation,
  int index,
  Widget child,
) =>
    defaultCurveBuilder(
      animation: animation,
      axis: Scrollable.of(context)!.widget.axis,
      curve: Curves.easeOutCubic,
      child: child,
    );

Widget defaultRemoveBuilder(
  BuildContext context,
  Animation<double> animation,
  int index,
  Widget child,
) =>
    defaultCurveBuilder(
      animation: animation,
      axis: Scrollable.of(context)!.widget.axis,
      child: child,
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
