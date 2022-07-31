import 'package:example/custom_animations/bounce_remove_builder.dart';
import 'package:example/logic/list_cubit.dart';
import 'package:example/model/item_model.dart';
import 'package:example/ui/item/item_builder.dart';
import 'package:example/ui/item/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_animated_list/self_animated_list.dart';

class VerticalTiles extends StatelessWidget {
  const VerticalTiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tileWidth(context),
      child: BlocBuilder<ListCubit, List<ItemModel>>(
        builder: (BuildContext context, List<ItemModel> state) {
          return SelfAnimatedList<ItemModel>(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            addDuration: const Duration(milliseconds: 2500),
            removeDuration: const Duration(milliseconds: 2500),
            initialItemCount: state.length,
            data: state,
            itemBuilder: itemBuilder,
            addBuilder: defaultAddBuilder,
            removeBuilder: bounceRemoveBuilder,
          );
        },
      ),
    );
  }
}
