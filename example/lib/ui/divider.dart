import 'package:flutter/material.dart';

class Divider extends StatelessWidget {
  const Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      color: Theme.of(context).dividerColor,
    );
  }
}
