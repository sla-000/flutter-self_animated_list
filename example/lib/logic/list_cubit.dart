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
  }) {
    final math.Random random =
        math.Random(DateTime.now().microsecondsSinceEpoch);

    List<ItemModel> newList = List<ItemModel>.of(state);

    toRemove = math.min(toRemove, newList.length);

    for (int i = 0; i < toRemove; ++i) {
      newList.removeAt(random.nextInt(newList.length));
    }

    for (int i = 0; i < toAdd; ++i) {
      newList.insert(
        random.nextInt(newList.length + 1),
        ItemModel(getRandomKey()),
      );
    }

    emit(List<ItemModel>.unmodifiable(newList));
  }

  void addOne(int index) {
    List<ItemModel> newList = List<ItemModel>.of(state);

    newList.insert(index, ItemModel(getRandomKey()));

    emit(List<ItemModel>.unmodifiable(newList));
  }

  void removeOne(int index) {
    List<ItemModel> newList = List<ItemModel>.of(state);

    newList.removeAt(index);

    emit(List<ItemModel>.unmodifiable(newList));
  }
}
