import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  ItemTile({
    Key? key,
    required this.value,
    required this.color,
    required this.onAddBefore,
    required this.onAddAfter,
    required this.onDelete,
    this.vertical = true,
  })  : _key = key.toString(),
        super(key: key);

  final String _key;
  final int value;
  final Color color;
  final bool vertical;

  final void Function() onAddBefore;
  final void Function() onAddAfter;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("Tile #$value\nKey: ${_key.substring(2, 10)}"),
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
    );
  }
}
