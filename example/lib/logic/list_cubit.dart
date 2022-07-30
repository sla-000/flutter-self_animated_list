import 'dart:math' as math;

import 'package:example/model/item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCubit extends Cubit<List<ItemModel>> {
  ListCubit([int count = 5])
      : super(
          List<ItemModel>.generate(
            count,
            (_) => ItemModel(getRandomKey()),
          ),
        );

  void update({
    int toAdd = 0,
    int toRemove = 0,
    int toSwap = 0,
  }) {
    List<ItemModel> newList = List<ItemModel>.of(state);

    _remove(toRemove, newList);
    _add(toAdd, newList);
    _swap(toSwap, newList);

    emit(List<ItemModel>.unmodifiable(newList));
  }

  void _add(int toAdd, List<ItemModel> newList) {
    final math.Random random = math.Random(DateTime.now().microsecondsSinceEpoch);

    for (int i = 0; i < toAdd; ++i) {
      newList.insert(
        random.nextInt(newList.length + 1),
        ItemModel(getRandomKey()),
      );
    }
  }

  void _remove(int toRemove, List<ItemModel> newList) {
    final math.Random random = math.Random(DateTime.now().microsecondsSinceEpoch);

    toRemove = math.min(toRemove, newList.length);

    for (int i = 0; i < toRemove; ++i) {
      newList.removeAt(random.nextInt(newList.length));
    }
  }

  void _swap(int toSwap, List<ItemModel> newList) {
    if (toSwap > newList.length || toSwap.isOdd) {
      return;
    }

    final math.Random random = math.Random(DateTime.now().microsecondsSinceEpoch);

    final List<int> indexesAvailable = List<int>.generate(newList.length, (index) => index);

    while (toSwap > 0) {
      final int swapIndex0 = indexesAvailable.elementAt(random.nextInt(indexesAvailable.length));
      indexesAvailable.remove(swapIndex0);
      final int swapIndex1 = indexesAvailable.elementAt(random.nextInt(indexesAvailable.length));
      indexesAvailable.remove(swapIndex1);

      final ItemModel swapItem0 = newList.elementAt(swapIndex0);
      final ItemModel swapItem1 = newList.elementAt(swapIndex1);

      newList.removeAt(swapIndex0);
      newList.insert(swapIndex0, swapItem1);

      newList.removeAt(swapIndex1);
      newList.insert(swapIndex1, swapItem0);

      toSwap -= 2;
    }
  }
}
