library animated_list_view;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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

  @override
  _AnimatedListViewState createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  final _previousChildren = <Widget>[];
  final _toRemove = <Key>[];
  final _toAdd = <Key>[];

  @override
  void initState() {
    super.initState();
    debugPrint("initState:");
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
    debugPrint(
        "merged: ${_previousChildren.map((child) => child.key).toList()}");

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
      debugPrint("_buildAnimated: _toRemove=$_toRemove");

      return ShowAnimated(
        key: child.key,
        axis: widget.scrollDirection,
        child: child,
        appearing: false,
        onAnimationComplete: () {
          debugPrint("onAnimationComplete: _toRemove.remove=${child.key}");
          _previousChildren.remove(child);
          _toRemove.remove(child.key);
          setState(() {});
        },
      );
    } else if (mustAdd) {
      debugPrint("_buildAnimated: _toAdd=$_toAdd");
      return ShowAnimated(
        key: child.key,
        axis: widget.scrollDirection,
        child: child,
        appearing: true,
        onAnimationComplete: () {
          debugPrint("onAnimationComplete: _toAdd.remove=${child.key}");
          _toAdd.remove(child.key);
          setState(() {});
        },
      );
    } else {
      return child;
    }
  }
}

class ShowAnimated extends StatefulWidget {
  ShowAnimated({
    Key key,
    @required this.child,
    @required this.axis,
    this.onAnimationComplete,
    this.appearing = true,
  }) : super(key: key);

  final Widget child;
  final bool appearing;
  final Axis axis;
  final void Function() onAnimationComplete;

  @override
  _ShowAnimatedState createState() => _ShowAnimatedState();
}

class _ShowAnimatedState extends State<ShowAnimated>
    with TickerProviderStateMixin {
  Animation<double> _sizeFactorAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _sizeFactorAnimation = widget.appearing
        ? Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeOutQuad))
        : Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeOutQuad));

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
    return SizeTransition(
      sizeFactor: _sizeFactorAnimation,
      axis: widget.axis,
      child: widget.child,
    );
  }
}

bool _isEqualDefault(a, b) => a.runtimeType == b.runtimeType && a == b;

List<T> mergeChanges<T>(
  List<T> list1,
  List<T> list2, {
  bool Function(T x1, T x2) isEqual = _isEqualDefault,
}) {
  assert(list1 != null);
  assert(list2 != null);

  list1 = copyOnlyUnique(list1, isEqual: isEqual);
  list2 = copyOnlyUnique(list2, isEqual: isEqual);

  final rez = <T>[];

  var index1 = 0;
  var index2 = 0;

  while (index1 < list1.length && index2 < list2.length) {
    if (isEqual(list2[index2], list1[index1])) {
      rez.add(list1[index1]);
      ++index1;
      ++index2;
    } else {
      final find2in1index =
          list1.indexWhere((value) => isEqual(value, list2[index2]));

      final find1in2index =
          list2.indexWhere((value) => isEqual(value, list1[index1]));

      if (find2in1index != -1 && find1in2index == -1) {
        rez.addAll(list1.sublist(index1, find2in1index));
        index1 = find2in1index;
      } else if (find2in1index == -1 && find1in2index != -1) {
        rez.addAll(list2.sublist(index2, find1in2index));
        index2 = find1in2index;
      } else if (find2in1index != -1 && find1in2index != -1) {
        debugPrint(
            "mergeChanges: Found collision,\nlist1=$list1,\nlist2=$list2");
        ++index1;
        ++index2;
      } else {
        debugPrint("mergeChanges: Unique chunk,\nlist1=$list1,\nlist2=$list2");
        rez.add(list1[index1++]);
        rez.add(list2[index2++]);
      }
    }
  }

  if (index1 < list1.length) {
    rez.addAll(list1.sublist(index1));
  }

  if (index2 < list2.length) {
    rez.addAll(list2.sublist(index2));
  }

  return rez;
}

List<T> copyOnlyUnique<T>(
  List<T> inList, {
  bool Function(T x1, T x2) isEqual = _isEqualDefault,
}) {
  final havingValues = Set<T>();

  final rez = <T>[];

  inList.forEach((inListValue) {
    final checkRepeated = havingValues.firstWhere(
        (havingValue) => isEqual(inListValue, havingValue),
        orElse: () => null);

    if (checkRepeated == null) {
      rez.add(inListValue);
      havingValues.add(inListValue);
    } else {
      debugPrint(
          "copyOnlyUnique: Repeating inListValue=$inListValue, inList=$inList");
    }
  });

  return rez;
}
