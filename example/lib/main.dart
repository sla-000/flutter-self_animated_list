import 'dart:math';

import 'package:animated_list_view/animated_list_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _horizontalItems = <Item>[];
  final _verticalItems = <Item>[];

  @override
  void initState() {
    super.initState();

    for (int index = 0; index < 10; ++index) {
      _horizontalItems.add(Item(index));
      _verticalItems.add(Item(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _horizontalWidgets = _horizontalItems
        .map((item) => OneItem(
              key: ValueKey(item.number),
              number: item.number,
              color: item.color,
              vertical: false,
              onDelete: () => _onDelete(_horizontalItems, item.number),
              onAddAfter: () => _onAddAfter(_horizontalItems, item.number),
              onAddBefore: () => _onAddBefore(_horizontalItems, item.number),
            ))
        .toList();

    final _verticalWidgets = _verticalItems
        .map((item) => OneItem(
              key: ValueKey(item.number),
              number: item.number,
              color: item.color,
              vertical: true,
              onDelete: () => _onDelete(_verticalItems, item.number),
              onAddAfter: () => _onAddAfter(_verticalItems, item.number),
              onAddBefore: () => _onAddBefore(_verticalItems, item.number),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Test AnimatedListView"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 100,
            child: Scrollbar(
              child: AnimatedListView(
                scrollDirection: Axis.horizontal,
                children: _horizontalWidgets,
              ),
            ),
          ),
          Container(
            height: 8,
            color: Theme.of(context).dividerColor,
          ),
          Expanded(
            child: Scrollbar(
              child: AnimatedListView(
                scrollDirection: Axis.vertical,
                children: _verticalWidgets,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onAddBefore(List<Item> lst, int currentNumber) {
    final max = _findNextNumber(lst);

    final itemIndex = lst.indexWhere((item) => item.number == currentNumber);

    lst.insert(
      itemIndex,
      Item(max),
    );

    setState(() {});
  }

  void _onAddAfter(List<Item> lst, int currentNumber) {
    final max = _findNextNumber(lst);

    final itemIndex = lst.indexWhere((item) => item.number == currentNumber);

    lst.insert(
      itemIndex + 1,
      Item(max),
    );

    setState(() {});
  }

  int _findNextNumber(List<Item> lst) {
    return 1 +
        lst.fold<int>(
          0,
          (prev, item) => (prev > item.number) ? prev : item.number,
        );
  }

  void _onDelete(List<Item> lst, int currentNumber) {
    final item = lst.firstWhere((item) => item.number == currentNumber);
    lst.remove(item);

    setState(() {});
  }
}

class OneItem extends StatelessWidget {
  OneItem({
    Key key,
    @required this.number,
    @required this.color,
    @required this.onAddBefore,
    @required this.onAddAfter,
    @required this.onDelete,
    this.vertical = true,
  }) : super(key: key);

  final int number;
  final Color color;
  final bool vertical;

  final void Function() onAddBefore;
  final void Function() onAddAfter;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: vertical ? double.infinity : 120,
      height: vertical ? 100 : double.infinity,
      color: color,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("Tile #$number"),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.plus_one),
              onPressed: () => onAddBefore(),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () => onDelete(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.plus_one),
              onPressed: () => onAddAfter(),
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  Item(this.number) : this.color = _getRandomColor();

  final int number;
  final Color color;

  static Color _getRandomColor() {
    return Color.fromARGB(
      0xFF,
      _getRandomInt(),
      _getRandomInt(),
      _getRandomInt(),
    );
  }

  static int _getRandomInt() {
    const delta = 200;
    return Random.secure().nextInt(delta) + 255 - delta;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          number == other.number;

  @override
  int get hashCode => number.hashCode;
}
