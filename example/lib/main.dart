import 'package:animated_list_view/animated_lists.dart';
import 'package:collection/collection.dart';
import 'package:example/logic/list_cubit.dart';
import 'package:example/model/item_model.dart';
import 'package:example/ui/item_tile.dart';
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
  final ListCubit _horizontalCubit = ListCubit();
  final ListCubit _verticalCubit = ListCubit();

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
                  duration: const Duration(milliseconds: 1500),
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
              children: <Widget>[
                SizedBox(
                  width: kTileWidth,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: BlocBuilder<ListCubit, List<ItemModel>>(
                      bloc: _verticalCubit,
                      builder: (BuildContext context, List<ItemModel> state) {
                        return AnimatedFlex(
                          direction: Axis.vertical,
                          customAnimation: _customAnimation,
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '+X',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Expanded(
                                child: Slider(
                                  min: 0,
                                  max: 5,
                                  divisions: 5,
                                  value: 0,
                                  onChanged: (double value) {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '-X',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Expanded(
                                child: Slider(
                                  min: 0,
                                  max: 5,
                                  divisions: 5,
                                  value: 0,
                                  onChanged: (double value) {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {},
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

  Widget _customAnimation({
    required Widget child,
    required Animation<double> animation,
    required bool appearing,
  }) {
    if (appearing) {
      final curvedAnimation =
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

      return SizeTransition(
        sizeFactor: curvedAnimation,
        axis: Axis.vertical,
        child: child,
      );
    } else {
      final sizeAnimation =
          CurvedAnimation(parent: animation, curve: Curves.bounceOut.flipped);

      final opacityAnimation =
          CurvedAnimation(parent: animation, curve: Curves.easeInExpo.flipped);

      return SizeTransition(
        sizeFactor: sizeAnimation,
        axis: Axis.vertical,
        child: Opacity(
          opacity: opacityAnimation.value,
          child: child,
        ),
      );
    }
  }
}

List<Widget> buildWidgets(Iterable<ItemModel> items) {
  return items
      .mapIndexed(
        (index, item) => ItemTile(
          key: ValueKey(item.value),
          value: index + 1,
          color: item.color,
          vertical: false,
          onDelete: () {
            // setState(() {
            //   items.removeAt(index);
            // });
          },
          onAddAfter: () {
            // setState(() {
            //   items.insert(index + 1, ItemModel(getRandomKey()));
            // });
          },
          onAddBefore: () {
            // setState(() {
            //   items.insert(index, ItemModel(getRandomKey()));
            // });
          },
        ),
      )
      .toList();
}
