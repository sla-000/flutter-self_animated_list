import 'package:animated_list_view/animated_lists.dart';
import 'package:collection/collection.dart';
import 'package:example/item_model.dart';
import 'package:example/item_tile.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const double kTileWidth = 150;
const double kTileHeight = 120;

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

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
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _horizontalItems =
      List<ItemModel>.generate(10, (_) => ItemModel(getRandomKey()));
  final _verticalItems =
      List<ItemModel>.generate(10, (_) => ItemModel(getRandomKey()));

  List<Widget> _buildWidgets(List<ItemModel> items) => items
      .mapIndexed(
        (index, item) => SizedBox(
          width: kTileWidth,
          height: kTileHeight,
          child: ItemTile(
            key: ValueKey(item.value),
            value: index + 1,
            color: item.color,
            vertical: false,
            onDelete: () {
              setState(() {
                items.removeAt(index);
              });
            },
            onAddAfter: () {
              setState(() {
                items.insert(index + 1, ItemModel(getRandomKey()));
              });
            },
            onAddBefore: () {
              setState(() {
                items.insert(index, ItemModel(getRandomKey()));
              });
            },
          ),
        ),
      )
      .toList();

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
            child: AnimatedListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              duration: const Duration(milliseconds: 1500),
              children: _buildWidgets(_horizontalItems),
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
                  child: AnimatedListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    customAnimation: _customAnimation,
                    children: _buildWidgets(_verticalItems),
                  ),
                ),
                const Expanded(
                  child: Center(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customAnimation({
    @required Widget child,
    @required Animation<double> animation,
    @required bool appearing,
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
