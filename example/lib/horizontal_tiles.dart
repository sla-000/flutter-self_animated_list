import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_animated_list/self_animated_list.dart';

import 'custom_animations/rotate_remove_builder.dart';
import 'custom_animations/shift_add_builder.dart';
import 'logic/list_cubit.dart';
import 'model/item_model.dart';
import 'ui/item/item_builder.dart';
import 'ui/item/item_tile.dart';

class HorizontalTiles extends StatelessWidget {
  const HorizontalTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tileHeight(context),
      child: BlocBuilder<ListCubit, List<ItemModel>>(
        builder: (BuildContext context, List<ItemModel> state) {
          return SelfAnimatedList<ItemModel>(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            addDuration: const Duration(milliseconds: 1500),
            removeDuration: const Duration(milliseconds: 1500),
            data: state,
            itemBuilder: itemBuilder,
            addBuilder: shiftAddBuilder,
            removeBuilder: rotateRemoveBuilder,
          );
        },
      ),
    );
  }
}
