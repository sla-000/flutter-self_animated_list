import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_animated_list/self_animated_list.dart';

import 'custom_animations/bounce_remove_builder.dart';
import 'logic/list_cubit.dart';
import 'model/item_model.dart';
import 'ui/item/item_builder.dart';
import 'ui/item/item_tile.dart';

class VerticalTiles extends StatelessWidget {
  const VerticalTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tileWidth(context),
      child: BlocBuilder<ListCubit, List<ItemModel>>(
        builder: (BuildContext context, List<ItemModel> state) {
          return SelfAnimatedList<ItemModel>(
            physics: const BouncingScrollPhysics(),
            addDuration: const Duration(milliseconds: 2500),
            removeDuration: const Duration(milliseconds: 2500),
            data: state,
            itemBuilder: itemBuilder,
            removeBuilder: bounceRemoveBuilder,
          );
        },
      ),
    );
  }
}
