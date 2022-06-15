library animated_list_view;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
  final List<Widget> _previousChildren = <Widget>[];
  final List<Key> _keysToRemove = <Key>[];
  final List<Key> _toAdd = <Key>[];
  late CustomAnimation _customAnimation;

  @override
  void initState() {
    super.initState();

    _customAnimation = widget.customAnimation ?? _defaultAnimation;
  }

  Widget _defaultAnimation({
    required Widget child,
    required Animation<double> animation,
    required bool appearing,
  }) {
    final CurvedAnimation curvedAnimation = appearing
        ? CurvedAnimation(parent: animation, curve: Curves.linear)
        : CurvedAnimation(parent: animation, curve: Curves.linear.flipped);

    return SizeTransition(
      sizeFactor: curvedAnimation,
      axis: widget.scrollDirection,
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
        if (!_toAdd.contains(key)) {
          _toAdd.add(key);
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
        merged.map((Widget child) => buildAnimatedItem(child)).toList();

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
      children: wrappedChildren,
    );
  }

  Widget buildAnimatedItem(Widget child) {
    final bool mustDelete = _keysToRemove.contains(child.key);
    final bool mustAdd = _toAdd.contains(child.key);

    if (mustDelete) {
      return ShowAnimated(
        key: child.key,
        customAnimation: _customAnimation,
        duration: widget.duration,
        appearing: false,
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
        customAnimation: _customAnimation,
        duration: widget.duration,
        onAnimationComplete: () {
          _toAdd.remove(child.key);
          setState(() {});
        },
        child: child,
      );
    } else {
      return child;
    }
  }
}
