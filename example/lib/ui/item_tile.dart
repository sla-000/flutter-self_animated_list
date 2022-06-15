import 'package:flutter/material.dart';

const double kTileWidth = 120;
const double kTileHeight = 100;

class ItemTile extends StatelessWidget {
  ItemTile({
    Key? key,
    required this.color,
  })  : _key = key.toString(),
        super(key: key);

  final String _key;
  final Color color;

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
