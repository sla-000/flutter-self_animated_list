import 'package:example/custom_animations/shift_add_builder.dart';
import 'package:example/custom_animations/shift_remove_builder.dart';
import 'package:example/logic/list_cubit.dart';
import 'package:example/model/item_model.dart';
import 'package:example/ui/item/item_builder.dart';
import 'package:example/ui/item/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_animated_list/self_animated_list.dart';

class HorizontalTiles extends StatelessWidget {
  const HorizontalTiles({
    Key? key,
  }) : super(key: key);

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
            initialItemCount: state.length,
            data: state,
            itemBuilder: itemBuilder,
            addBuilder: shiftAddBuilder,
            removeBuilder: shiftRemoveBuilder,
          );
        },
      ),
    );
  }
}
