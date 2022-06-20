import 'package:animated_list_view/animated_lists.dart';
import 'package:example/logic/list_cubit.dart';
import 'package:example/model/item_model.dart';
import 'package:example/ui/custom_animation.dart';
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
  late final ListCubit _verticalCubit = ListCubit(MediaQuery.of(context).orientation == Orientation.portrait ? 4 : 3);
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
          SizedBox(
            height: kTileHeight,
            child: BlocBuilder<ListCubit, List<ItemModel>>(
              bloc: _horizontalCubit,
              builder: (BuildContext context, List<ItemModel> state) {
                return AnimatedListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  duration: const Duration(milliseconds: 1000),
                  children: buildWidgets(state),
                );
              },
            ),
          ),
          Container(
            height: 8,
            color: Theme.of(context).dividerColor,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: kTileWidth,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: BlocBuilder<ListCubit, List<ItemModel>>(
                      bloc: _verticalCubit,
                      builder: (BuildContext context, List<ItemModel> state) {
                        return AnimatedFlex(
                          mainAxisSize: MainAxisSize.min,
                          direction: Axis.vertical,
                          customAnimation: customAnimation,
                          duration: const Duration(milliseconds: 2000),
                          children: buildWidgets(state),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> buildWidgets(Iterable<ItemModel> items) {
  return items
      .map(
        (ItemModel item) => ItemTile(
          key: ValueKey(item.value),
          color: item.color,
        ),
      )
      .toList();
}
