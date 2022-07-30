import 'package:flutter/material.dart';

const double kTileWidth = 120;
const double kTileHeight = 100;

class ItemTile extends StatelessWidget {
  ItemTile({
    Key? key,
    required this.color,
    required this.index,
  })  : _key = key.toString(),
        super(key: key);

  final String _key;
  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    final paddedKey = _key.padLeft(25);

    return SizedBox(
      width: kTileWidth,
      height: kTileHeight,
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
                "Key: ${paddedKey.substring(paddedKey.length - 8, paddedKey.length - 2)}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
