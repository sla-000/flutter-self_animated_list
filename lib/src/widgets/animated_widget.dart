import 'package:flutter/material.dart';

typedef CustomAnimation = Widget Function({
  required Widget child,
  required Animation<double> animation,
  required bool appearing,
});

class ShowAnimated extends StatefulWidget {
  const ShowAnimated({
    Key? key,
    required this.child,
    this.onAnimationComplete,
    this.appearing = true,
    Duration? duration,
    required this.customAnimation,
  })  : _duration = duration ?? const Duration(milliseconds: 800),
        super(key: key);

  final Widget child;
  final bool appearing;
  final void Function()? onAnimationComplete;
  final Duration _duration;
  final CustomAnimation customAnimation;

  @override
  State<ShowAnimated> createState() => _ShowAnimatedState();
}

class _ShowAnimatedState extends State<ShowAnimated>
    with TickerProviderStateMixin {
  late final Animation<double> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: widget._duration);

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (widget.appearing) {
      _animationController.forward(from: 0.0).whenCompleteOrCancel(() {
        widget.onAnimationComplete?.call();
      });
    } else {
      _animationController.reverse(from: 1.0).whenCompleteOrCancel(() {
        widget.onAnimationComplete?.call();
      });
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
        animation: _animation,
        appearing: widget.appearing);
  }
}
