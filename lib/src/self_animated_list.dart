import 'package:flutter/material.dart';

import 'utils/search_changes.dart';

class SelfAnimatedList<T> extends StatefulWidget {
  const SelfAnimatedList({
    super.key,
    required this.data,
    required this.itemBuilder,
    required this.addBuilder,
    required this.removeBuilder,
    this.addDuration = const Duration(milliseconds: 800),
    this.removeDuration = const Duration(milliseconds: 800),
    this.initialItemCount = 0,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.clipBehavior = Clip.hardEdge,
    this.isEqual,
  });

  final List<T> data;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final Widget Function(Animation<double> animation, Widget child) addBuilder;
  final Widget Function(Animation<double> animation, Widget child) removeBuilder;
  final Duration addDuration;
  final Duration removeDuration;
  final int initialItemCount;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final Clip clipBehavior;
  final bool Function(T a, T b)? isEqual;

  @override
  State<SelfAnimatedList<T>> createState() => _SelfAnimatedListState<T>();
}

class _SelfAnimatedListState<T> extends State<SelfAnimatedList<T>> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  @override
  void didUpdateWidget(SelfAnimatedList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final List<T> mutableData = List<T>.of(oldWidget.data);

    searchChanges(
      initial: mutableData,
      target: widget.data,
      isEqual: widget.isEqual,
      onAdd: (int index, T item) {
        _key.currentState?.insertItem(
          index,
          duration: widget.addDuration,
        );
      },
      onRemove: (int index, T item) {
        _key.currentState?.removeItem(
          index,
          (BuildContext context, Animation<double> animation) =>
              widget.removeBuilder(animation, widget.itemBuilder(context, index, item)),
          duration: widget.removeDuration,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _key,
      itemBuilder: (BuildContext context, int index, Animation<double> animation) => widget
          .addBuilder(animation, widget.itemBuilder(context, index, widget.data.elementAt(index))),
      initialItemCount: widget.initialItemCount,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      clipBehavior: widget.clipBehavior,
    );
  }
}
