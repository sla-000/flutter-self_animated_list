import 'package:flutter/material.dart';

import '../custom_animation.dart';

class ShowAnimated extends StatefulWidget {
  const ShowAnimated({
    Key? key,
    required this.child,
    this.onShrink,
    required this.state,
    Duration? duration,
    required this.customAnimation,
  })  : _duration = duration ?? const Duration(milliseconds: 800),
        super(key: key);

  final Widget child;
  final ShowState state;
  final void Function()? onShrink;
  final Duration _duration;
  final CustomAnimation customAnimation;

  @override
  State<ShowAnimated> createState() => _ShowAnimatedState();
}

class _ShowAnimatedState extends State<ShowAnimated> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(vsync: this, duration: widget._duration);

  @override
  void initState() {
    super.initState();

    if (widget.state == ShowState.hide) {
      _animationController.value = 1.0;
    }

    _updateAnimation();
  }

  void _updateAnimation() {
    if (widget.state == ShowState.show) {
      _animationController.forward();
    } else {
      _animationController.reverse().whenCompleteOrCancel(() {
        widget.onShrink?.call();
      });
    }
  }

  @override
  void didUpdateWidget(ShowAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.state != oldWidget.state) {
      _updateAnimation();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.customAnimation(
      child: widget.child,
      animation: _animationController,
      state: widget.state,
    );
  }
}
