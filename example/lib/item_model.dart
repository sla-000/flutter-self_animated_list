import 'dart:math';

import 'package:flutter/material.dart';

class ItemModel {
  ItemModel(this.value) : this.color = _getRandomColor();

  final int value;
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
    const delta = 200;
    return Random.secure().nextInt(delta) + 255 - delta;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModel &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'ItemModel{value: $value, color: $color}';
  }
}

int getRandomKey() {
  return Random.secure().nextInt(1 << 32) * Random.secure().nextInt(1 << 16) +
      Random.secure().nextInt(1 << 16);
}
