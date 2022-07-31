import 'package:example/model/item_model.dart';
import 'package:example/ui/item/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:self_animated_list/self_animated_list.dart';

Widget itemBuilder<T>(ItemData<ItemModel> data) => ItemTile(
      color: data.item.color,
      index: data.index,
    );
