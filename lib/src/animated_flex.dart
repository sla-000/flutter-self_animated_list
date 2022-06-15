import 'package:flutter/material.dart';

import 'custom_animation.dart';
import 'utils/merge.dart';
import 'widgets/animated_widget.dart';

class AnimatedFlex extends StatefulWidget {
  const AnimatedFlex({
    Key? key,
    required this.direction,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline, // NO DEFAULT: we don't know what the text's baseline should be
    this.clipBehavior = Clip.none,
    this.customAnimation,
    this.duration,
    this.children = const <Widget>[],
  }) : super(key: key);

  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final Clip clipBehavior;
  final CustomAnimation? customAnimation;
  final Duration? duration;
  final List<Widget> children;

  @override
  State<AnimatedFlex> createState() => _AnimatedFlexState();
}

class _AnimatedFlexState extends State<AnimatedFlex> {
  final List<Widget> _previousChildren = <Widget>[];
  final List<Key> _keysToRemove = <Key>[];
  final List<Key> _keysToAdd = <Key>[];
  late CustomAnimation _animation;

  @override
  void initState() {
    super.initState();

    _animation = widget.customAnimation ?? _defaultAnimation;
  }

  @override
  void didUpdateWidget(AnimatedFlex oldWidget) {
    super.didUpdateWidget(oldWidget);

    _animation = widget.customAnimation ?? _defaultAnimation;
  }

  Widget _defaultAnimation({
    required Widget child,
    required Animation<double> animation,
    required ShowState state,
  }) {
    final CurvedAnimation curvedAnimation = state == ShowState.show
        ? CurvedAnimation(parent: animation, curve: Curves.linear)
        : CurvedAnimation(parent: animation, curve: Curves.linear.flipped);

    return SizeTransition(
      sizeFactor: curvedAnimation,
      axis: widget.direction,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Key> lastChildrenKeys =
        _previousChildren.map((Widget child) => child.key!).toList();

    final List<Key> currentChildrenKeys =
        widget.children.map((Widget child) => child.key!).toList();

    for (final Key key in currentChildrenKeys) {
      if (!lastChildrenKeys.contains(key)) {
        if (!_keysToAdd.contains(key)) {
          _keysToAdd.add(key);
        }
      }
    }

    for (final Key key in lastChildrenKeys) {
      if (!currentChildrenKeys.contains(key)) {
        if (!_keysToRemove.contains(key)) {
          _keysToRemove.add(key);
        }
      }
    }

    final List<Widget> merged = mergeChanges<Widget>(
      _previousChildren,
      widget.children,
      isEqual: (Widget a, Widget b) => a.key == b.key,
    );

    _previousChildren.clear();
    _previousChildren.addAll(merged);

    final List<Widget> wrappedChildren =
        merged.map((Widget child) => _buildAnimatedItem(child)).toList();

    return Flex(
      key: widget.key,
      direction: widget.direction,
      mainAxisAlignment: widget.mainAxisAlignment,
      mainAxisSize: widget.mainAxisSize,
      crossAxisAlignment: widget.crossAxisAlignment,
      textDirection: widget.textDirection,
      verticalDirection: widget.verticalDirection,
      textBaseline: widget.textBaseline,
      clipBehavior: widget.clipBehavior,
      children: wrappedChildren,
    );
  }

  Widget _buildAnimatedItem(Widget child) {
    final bool mustDelete = _keysToRemove.contains(child.key);
    final bool mustAdd = _keysToAdd.contains(child.key);

    if (mustDelete) {
      return ShowAnimated(
        key: child.key,
        customAnimation: _animation,
        duration: widget.duration,
        state: ShowState.hide,
        onAnimationComplete: () {
          _previousChildren.remove(child);
          _keysToRemove.remove(child.key);
          setState(() {});
        },
        child: child,
      );
    } else if (mustAdd) {
      return ShowAnimated(
        key: child.key,
        customAnimation: _animation,
        duration: widget.duration,
        state: ShowState.show,
        onAnimationComplete: () {
          _keysToAdd.remove(child.key);
          setState(() {});
        },
        child: child,
      );
    } else {
      return child;
    }
  }
}
