import 'package:flutter/material.dart';

enum ShowState { show, hide }

typedef CustomAnimation = Widget Function({
  required Widget child,
  required Animation<double> animation,
  required ShowState state,
});
