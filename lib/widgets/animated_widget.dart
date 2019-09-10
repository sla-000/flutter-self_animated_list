import 'package:flutter/material.dart';

typedef Widget CustomAnimation({
  @required Widget child,
  @required Animation<double> animation,
  @required bool appearing,
});

class ShowAnimated extends StatefulWidget {
  ShowAnimated({
    Key key,
    @required this.child,
    this.onAnimationComplete,
    this.appearing = true,
    this.duration = const Duration(milliseconds: 500),
    @required this.customAnimation,
  }) : super(key: key);

  final Widget child;
  final bool appearing;
  final void Function() onAnimationComplete;
  final Duration duration;
  final CustomAnimation customAnimation;

  @override
  _ShowAnimatedState createState() => _ShowAnimatedState();
}

class _ShowAnimatedState extends State<ShowAnimated>
    with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: widget.duration);

    _animation = widget.appearing
        ? Tween(begin: 0.0, end: 1.0).animate(_animationController)
        : Tween(begin: 1.0, end: 0.0).animate(_animationController);

    _animationController.addListener(() {
      if (mounted) setState(() {});
    });

    _animationController.forward(from: 0.0).whenCompleteOrCancel(() {
      widget.onAnimationComplete?.call();
    });
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
