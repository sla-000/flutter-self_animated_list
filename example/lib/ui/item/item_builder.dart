import 'package:flutter/material.dart';
import 'package:self_animated_list/self_animated_list.dart';

import '../../model/item_model.dart';
import 'item_tile.dart';

Widget itemBuilder<T>(ItemData<ItemModel> data) => ItemTile(
      color: data.item.color,
      index: data.index,
    );
