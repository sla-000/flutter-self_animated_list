import 'package:flutter/material.dart';

@immutable
class ItemData<T> {
  const ItemData({
    required this.context,
    required this.index,
    required this.count,
    required this.item,
  });

  final BuildContext context;
  final int index;
  final int count;
  final T item;
}
