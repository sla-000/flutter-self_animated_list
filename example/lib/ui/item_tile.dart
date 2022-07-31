import 'package:flutter/material.dart';

double tileWidth(BuildContext context) => 110 * MediaQuery.of(context).textScaleFactor;
double tileHeight(BuildContext context) => 80 * MediaQuery.of(context).textScaleFactor;

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.color,
    required this.index,
  }) : super(key: key);

  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tileWidth(context),
      height: tileHeight(context),
      child: ColoredBox(
        color: color,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                "#$index",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "0x${color.value.toRadixString(16).toUpperCase().substring(2).padLeft(6, '0')}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
