import 'package:example/model/item_model.dart';
import 'package:example/ui/item_tile.dart';
import 'package:flutter/material.dart';

Widget buildItem(_, int index, ItemModel item) => ItemTile(
      key: ValueKey(item.value),
      color: item.color,
      index: index,
    );
