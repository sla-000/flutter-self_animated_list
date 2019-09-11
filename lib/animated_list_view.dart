library animated_list_view;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'utils/merge.dart';
import 'widgets/animated_widget.dart';

class AnimatedListView extends StatefulWidget {
  AnimatedListView({
    this.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.children = const <Widget>[],
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.customAnimation,
    this.duration,
  });

  final Key key;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController controller;
  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;
  final double itemExtent;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double cacheExtent;
  final List<Widget> children;
  final int semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final CustomAnimation customAnimation;
  final Duration duration;

  @override
  _AnimatedListViewState createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  final _previousChildren = <Widget>[];
  final _toRemove = <Key>[];
  final _toAdd = <Key>[];
  CustomAnimation _customAnimation;

  @override
  void initState() {
    super.initState();

    _customAnimation = widget.customAnimation ?? _defaultAnimation;
  }

  Widget _defaultAnimation({
    @required Widget child,
    @required Animation<double> animation,
    @required bool appearing,
  }) {
    final _curvedAnimation = appearing
        ? CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)
        : CurvedAnimation(parent: animation, curve: Curves.easeInCubic.flipped);

    return SizeTransition(
      sizeFactor: _curvedAnimation,
      axis: widget.scrollDirection,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Key> _lastChildrenKeys =
        _previousChildren.map((child) => child.key).toList();

    List<Key> _currentChildrenKeys =
        widget.children.map((child) => child.key).toList();

    _currentChildrenKeys.forEach((key) {
      if (!_lastChildrenKeys.contains(key)) {
        if (!_toAdd.contains(key)) {
          _toAdd.add(key);
        }
      }
    });

    _lastChildrenKeys.forEach((key) {
      if (!_currentChildrenKeys.contains(key)) {
        if (!_toRemove.contains(key)) {
          _toRemove.add(key);
        }
      }
    });

    final merged = mergeChanges<Widget>(
      _previousChildren,
      widget.children,
      isEqual: (a, b) => a.key == b.key,
    );

    _previousChildren.clear();
    _previousChildren.addAll(merged);

    final wrappedChildren =
        merged.map((child) => _buildAnimated(child)).toList();

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
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      cacheExtent: widget.cacheExtent,
      children: wrappedChildren,
      semanticChildCount: widget.semanticChildCount,
      dragStartBehavior: widget.dragStartBehavior,
    );
  }

  Widget _buildAnimated(Widget child) {
    final mustDelete = _toRemove.contains(child.key);
    final mustAdd = _toAdd.contains(child.key);

    if (mustDelete) {
      return ShowAnimated(
        key: child.key,
        customAnimation: _customAnimation,
        duration: widget.duration,
        appearing: false,
        onAnimationComplete: () {
          _previousChildren.remove(child);
          _toRemove.remove(child.key);
          setState(() {});
        },
        child: child,
      );
    } else if (mustAdd) {
      return ShowAnimated(
        key: child.key,
        customAnimation: _customAnimation,
        duration: widget.duration,
        appearing: true,
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
