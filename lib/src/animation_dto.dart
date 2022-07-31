import 'package:flutter/material.dart';

@immutable
class AnimationData {
  const AnimationData({
    required this.context,
    required this.animation,
    required this.index,
    required this.count,
    required this.child,
  });

  final BuildContext context;
  final Animation<double> animation;
  final int index;
  final int count;
  final Widget child;
}
