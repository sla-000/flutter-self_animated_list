import 'package:animated_list_view/animated_lists.dart';
import 'package:example/logic/list_cubit.dart';
import 'package:example/model/item_model.dart';
import 'package:example/ui/item_tile.dart';
import 'package:example/ui/slider_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  late final ListCubit _horizontalCubit =
      ListCubit(MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 3);
  late final ListCubit _verticalCubit =
      ListCubit(MediaQuery.of(context).orientation == Orientation.portrait ? 4 : 3);
  int _toRemove = 1;
  int _toAdd = 1;

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
        title: const Text("Test AnimatedListView"),
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
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SliderValue(
            prefix: '+',
            readValue: () => _toAdd,
            onChange: (int value) => _toAdd = value.round(),
          ),
          const SizedBox(height: 16),
          SliderValue(
            prefix: '-',
            readValue: () => _toRemove,
            onChange: (int value) => _toRemove = value.round(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _horizontalCubit.update(
                toAdd: _toAdd,
                toRemove: _toRemove,
              );

              _verticalCubit.update(
                toAdd: _toAdd,
                toRemove: _toRemove,
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
            addBuilder: (BuildContext context, ItemModel item, Animation<double> animation) =>
                defaultAddBuilder(
              context: context,
              item: item,
              animation: animation,
              builder: (_) => ItemTile(
                key: ValueKey(item.value),
                color: item.color,
              ),
            ),
            removeBuilder: (BuildContext context, ItemModel item, Animation<double> animation) =>
                _bounceRemoveAnimation(animation, item),
          );
        },
      ),
    );
  }

  SizeTransition _bounceRemoveAnimation(Animation<double> animation, ItemModel item) {
    final sizeAnimation = CurvedAnimation(parent: animation, curve: Curves.bounceIn);
    final opacityAnimation = animation;

    return SizeTransition(
      sizeFactor: sizeAnimation,
      axis: Axis.vertical,
      child: FadeTransition(
        opacity: opacityAnimation,
        child: ItemTile(
          key: ValueKey(item.value),
          color: item.color,
        ),
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
            addBuilder: (BuildContext context, ItemModel item, Animation<double> animation) =>
                defaultAddBuilder(
              context: context,
              item: item,
              animation: animation,
              axis: Axis.horizontal,
              builder: (_) => ItemTile(
                key: ValueKey(item.value),
                color: item.color,
              ),
            ),
            removeBuilder: (BuildContext context, ItemModel item, Animation<double> animation) =>
                defaultRemoveBuilder(
              context: context,
              item: item,
              animation: animation,
              axis: Axis.horizontal,
              builder: (_) => ItemTile(
                key: ValueKey(item.value),
                color: item.color,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      color: Theme.of(context).dividerColor,
    );
  }
}

Widget defaultAddBuilder({
  required BuildContext context,
  required ItemModel item,
  required Animation<double> animation,
  required WidgetBuilder builder,
  Axis axis = Axis.vertical,
}) =>
    defaultCurveBuilder(
      context: context,
      item: item,
      animation: animation,
      axis: axis,
      curve: Curves.easeOutCubic,
      builder: builder,
    );

Widget defaultRemoveBuilder({
  required BuildContext context,
  required ItemModel item,
  required Animation<double> animation,
  required WidgetBuilder builder,
  Axis axis = Axis.vertical,
}) =>
    defaultCurveBuilder(
      context: context,
      item: item,
      animation: animation,
      axis: axis,
      curve: Curves.easeInCubic,
      builder: builder,
    );

Widget defaultCurveBuilder({
  required BuildContext context,
  required ItemModel item,
  required Animation<double> animation,
  required WidgetBuilder builder,
  Axis axis = Axis.vertical,
  Curve curve = Curves.easeInCubic,
}) {
  final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
  final opacityAnimation = animation;

  return SizeTransition(
    sizeFactor: curvedAnimation,
    axis: axis,
    child: FadeTransition(
      opacity: opacityAnimation,
      child: builder(context),
    ),
  );
}
