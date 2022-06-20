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
  final List<Widget> _mergedChildren = <Widget>[];
  final List<Key> _keysToRemove = <Key>[];
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

  void _updateMerged() {
    final List<Key> mergedChildrenKeys =
        _mergedChildren.map((Widget child) => child.key!).toList();

    final List<Key> currentChildrenKeys =
        widget.children.map((Widget child) => child.key!).toList();

    for (final Key key in currentChildrenKeys) {
      if (!mergedChildrenKeys.contains(key)) {
        if (_keysToRemove.contains(key)) {
          _keysToRemove.remove(key);
        }
      }
    }

    for (final Key key in mergedChildrenKeys) {
      if (!currentChildrenKeys.contains(key)) {
        if (!_keysToRemove.contains(key)) {
          _keysToRemove.add(key);
        }
      }
    }

    final List<Widget> merged = mergeChanges<Widget>(
      _mergedChildren,
      widget.children,
      isEqual: (Widget a, Widget b) => a.key == b.key,
    );

    _mergedChildren.clear();
    _mergedChildren.addAll(merged);

    print('@@@@@@@@@ children=${widget.children.map((Widget e) => e.key)}');
    print('@@@@@@@@@ merged=${merged.map((Widget e) => e.key)}');
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
    _updateMerged();

    final List<Widget> wrappedChildren = _mergedChildren
        .map((Widget child) => _buildAnimatedItem(child))
        .toList();

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

    if (mustDelete) {
      return ShowAnimated(
        key: child.key,
        customAnimation: _animation,
        duration: widget.duration,
        state: ShowState.hide,
        onAnimationComplete: () {
          setState(() {
            if (_keysToRemove.contains(child.key)) {
              _keysToRemove.remove(child.key);
              print('@@@@@@@@@ toRemove, remove=${child.key}');
            }
            if (!widget.children
                .map((Widget child) => child.key)
                .contains(child.key)) {
              _mergedChildren.remove(child);
              print('@@@@@@@@@ merged remove=${child.key}');
            }
          });
        },
        child: child,
      );
    }

    return ShowAnimated(
      key: child.key,
      customAnimation: _animation,
      duration: widget.duration,
      state: ShowState.show,
      child: child,
    );
  }
}
