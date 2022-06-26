import 'package:flutter/material.dart';

import 'utils/calc_change_type.dart';

typedef SelfAnimatedListBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  Animation<double> animation,
);

class SelfAnimatedList<T> extends StatefulWidget {
  const SelfAnimatedList({
    Key? key,
    required this.data,
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
  }) : super(key: key);

  final List<T> data;
  final SelfAnimatedListBuilder<T> addBuilder;
  final SelfAnimatedListBuilder<T> removeBuilder;
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

  @override
  State<SelfAnimatedList<T>> createState() => _SelfAnimatedListState<T>();
}

class _SelfAnimatedListState<T> extends State<SelfAnimatedList<T>> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  late final List<T> _lastData = List<T>.of(widget.data);

  @override
  void didUpdateWidget(SelfAnimatedList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    for (int index = 0; index < widget.data.length; ++index) {
      final ChangeType changeType = calcChangeType(index, _lastData, widget.data);

      switch (changeType) {
        case ChangeType.add:
          _key.currentState!.insertItem(
            index,
            duration: widget.addDuration,
          );
          break;

        case ChangeType.remove:
          _key.currentState!.removeItem(
            index,
            (BuildContext context, Animation<double> animation) =>
                widget.removeBuilder(context, widget.data.elementAt(index), animation),
            duration: widget.removeDuration,
          );
          break;

        case ChangeType.none:
      }
    }

    _lastData.clear();
    _lastData.addAll(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _key,
      itemBuilder: (BuildContext context, int index, Animation<double> animation) =>
          widget.addBuilder(context, _lastData.elementAt(index), animation),
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
