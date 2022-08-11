import 'dart:math';

import 'package:flutter/material.dart';

@immutable
class ItemModel {
  ItemModel() : color = _getRandomColor();

  final Color color;

  static Color _getRandomColor() {
    return Color.fromARGB(
      0xFF,
      _getRandomColorComponent(),
      _getRandomColorComponent(),
      _getRandomColorComponent(),
    );
  }

  static int _getRandomColorComponent() {
    const int delta = 200;
    return Random.secure().nextInt(delta) + 255 - delta;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModel && runtimeType == other.runtimeType && color == other.color;

  @override
  int get hashCode => color.hashCode;

  @override
  String toString() {
    return 'ItemModel{color: $color}';
  }
}
