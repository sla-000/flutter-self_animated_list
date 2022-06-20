import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'custom_animation.dart';
import 'utils/merge.dart';
import 'widgets/animated_widget.dart';

class AnimatedListView extends StatefulWidget {
  const AnimatedListView({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.children = const <Widget>[],
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.customAnimation,
    this.duration,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  }) : super(key: key);

  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final Widget? prototypeItem;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final List<Widget> children;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final CustomAnimation? customAnimation;
  final Duration? duration;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  @override
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  final List<Widget> _mergedChildren = <Widget>[];
  final List<Key> _keysToRemove = <Key>[];
  late CustomAnimation _animation;

  @override
  void initState() {
    super.initState();

    _animation = widget.customAnimation ?? _defaultAnimation;

    _updateMerged();
  }

  @override
  void didUpdateWidget(AnimatedListView oldWidget) {
    super.didUpdateWidget(oldWidget);

    _animation = widget.customAnimation ?? _defaultAnimation;

    _updateMerged();
  }

  void _updateMerged() {
    final List<Key> mergedChildrenKeys = _mergedChildren.map((Widget child) => child.key!).toList();

    final List<Key> currentChildrenKeys = widget.children.map((Widget child) => child.key!).toList();

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
  }

  Widget _defaultAnimation({
    required Widget child,
    required Animation<double> animation,
    required ShowState state,
  }) {
    final CurvedAnimation sizeAnimation = state == ShowState.show
        ? CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)
        : CurvedAnimation(parent: animation, curve: Curves.easeInCubic);

    final CurvedAnimation opacityAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOut);

    return SizeTransition(
      sizeFactor: sizeAnimation,
      axis: widget.scrollDirection,
      child: FadeTransition(
        opacity: opacityAnimation,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> animatedChildren = _mergedChildren.map((Widget child) => _buildAnimatedItem(child)).toList();

    return ListView(
      key: widget.key,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      itemExtent: widget.itemExtent,
      prototypeItem: widget.prototypeItem,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      cacheExtent: widget.cacheExtent,
      semanticChildCount: widget.semanticChildCount,
      dragStartBehavior: widget.dragStartBehavior,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      restorationId: widget.restorationId,
      clipBehavior: widget.clipBehavior,
      children: animatedChildren,
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
        onShrink: () {
          setState(() {
            if (_keysToRemove.contains(child.key)) {
              _keysToRemove.remove(child.key);
            }
            if (!widget.children.map((Widget child) => child.key).contains(child.key)) {
              _mergedChildren.remove(child);
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
