import 'package:flutter/material.dart';

const double kTileWidth = 150;
const double kTileHeight = 120;

class ItemTile extends StatelessWidget {
  ItemTile({
    Key? key,
    required this.color,
    required this.onAddBefore,
    required this.onAddAfter,
    required this.onDelete,
    this.vertical = true,
  })  : _key = key.toString(),
        super(key: key);

  final String _key;
  final Color color;
  final bool vertical;

  final void Function() onAddBefore;
  final void Function() onAddAfter;
  final void Function() onDelete;

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
                  "Key: ${paddedKey.substring(paddedKey.length - 8, paddedKey.length - 2)}"),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.plus_one),
                onPressed: onAddBefore,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: onDelete,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.plus_one),
                onPressed: onAddAfter,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
