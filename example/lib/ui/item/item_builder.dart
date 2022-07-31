import 'package:example/model/item_model.dart';
import 'package:example/ui/item/item_tile.dart';
import 'package:flutter/material.dart';

Widget itemBuilder(_, int index, ItemModel item) => ItemTile(
      color: item.color,
      index: index,
    );
