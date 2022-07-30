import 'package:example/logic/list_cubit.dart';
import 'package:example/model/item_model.dart';
import 'package:example/ui/add_rem_value.dart';
import 'package:example/ui/item_tile.dart';
import 'package:example/ui/swap_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_animated_list/self_animated_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SelfAnimatedList Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ListCubit _horizontalCubit = ListCubit(5);
  late final ListCubit _verticalCubit = ListCubit(5);
  int _toRemove = 1;
  int _toAdd = 1;
  int _toSwap = 0;

  @override
  void dispose() {
    _horizontalCubit.close();
    _verticalCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SelfAnimatedList Demo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _horizontalTiles(),
          const Divider(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _verticalTiles(),
                Expanded(
                  child: Center(
                    child: _controls(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _controls() {
    return SizedBox(
      width: 250,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AddRemValue(
            prefix: 'Add',
            readValue: () => _toAdd,
            onChange: (int value) => _toAdd = value.round(),
          ),
          const SizedBox(height: 16),
          AddRemValue(
            prefix: 'Rem',
            readValue: () => _toRemove,
            onChange: (int value) => _toRemove = value.round(),
          ),
          const SizedBox(height: 16),
          SwapValue(
            prefix: 'Swp',
            readValue: () => _toSwap,
            onChange: (int value) => _toSwap = value.round(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _horizontalCubit.update(
                toAdd: _toAdd,
                toRemove: _toRemove,
                toSwap: _toSwap,
              );

              _verticalCubit.update(
                toAdd: _toAdd,
                toRemove: _toRemove,
                toSwap: _toSwap,
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Widget _verticalTiles() {
    return SizedBox(
      width: kTileWidth,
      child: BlocBuilder<ListCubit, List<ItemModel>>(
        bloc: _verticalCubit,
        builder: (BuildContext context, List<ItemModel> state) {
          return SelfAnimatedList<ItemModel>(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            addDuration: const Duration(milliseconds: 2000),
            removeDuration: const Duration(milliseconds: 3000),
            initialItemCount: _verticalCubit.state.length,
            data: _verticalCubit.state,
            itemBuilder: _buildItem,
            addBuilder: (Animation<double> animation, Widget child) => defaultAddBuilder(
              animation: animation,
              child: child,
            ),
            removeBuilder: _bounceRemoveBuilder,
          );
        },
      ),
    );
  }

  Widget _horizontalTiles() {
    return SizedBox(
      height: kTileHeight,
      child: BlocBuilder<ListCubit, List<ItemModel>>(
        bloc: _horizontalCubit,
        builder: (BuildContext context, List<ItemModel> state) {
          return SelfAnimatedList<ItemModel>(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            addDuration: const Duration(milliseconds: 1500),
            removeDuration: const Duration(milliseconds: 1500),
            initialItemCount: _horizontalCubit.state.length,
            data: _horizontalCubit.state,
            itemBuilder: _buildItem,
            addBuilder: (Animation<double> animation, Widget child) => defaultAddBuilder(
              animation: animation,
              axis: Axis.horizontal,
              child: child,
            ),
            removeBuilder: (Animation<double> animation, Widget child) => defaultRemoveBuilder(
              animation: animation,
              axis: Axis.horizontal,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

Widget _buildItem(_, int index, ItemModel item) => ItemTile(
      key: ValueKey(item.value),
      color: item.color,
      index: index,
    );

SizeTransition _bounceRemoveBuilder(Animation<double> animation, Widget child) {
  final sizeAnimation = CurvedAnimation(parent: animation, curve: Curves.bounceIn);
  final opacityAnimation = animation;

  return SizeTransition(
    sizeFactor: sizeAnimation,
    axis: Axis.vertical,
    child: FadeTransition(
      opacity: opacityAnimation,
      child: child,
    ),
  );
}
