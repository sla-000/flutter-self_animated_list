import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'horizontal_tiles.dart';
import 'logic/list_cubit.dart';
import 'ui/controls/add_rem_value.dart';
import 'ui/controls/swap_value.dart';
import 'vertical_tiles.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ListCubit _horizontalCubit = ListCubit();
  late final ListCubit _verticalCubit = ListCubit();

  int _toRemove = 1;
  int _toAdd = 1;
  int _toSwap = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelfAnimatedList Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BlocProvider<ListCubit>(
            create: (BuildContext context) => _horizontalCubit,
            child: const HorizontalTiles(),
          ),
          const Divider(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocProvider<ListCubit>(
                  create: (BuildContext context) => _verticalCubit,
                  child: const VerticalTiles(),
                ),
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
        children: <Widget>[
          AddRemValue(
            prefix: 'Add',
            readValue: () => _toAdd,
            onChange: (int value) => _toAdd = value,
          ),
          const SizedBox(height: 16),
          AddRemValue(
            prefix: 'Rem',
            readValue: () => _toRemove,
            onChange: (int value) => _toRemove = value,
          ),
          const SizedBox(height: 16),
          SwapValue(
            prefix: 'Swp',
            readValue: () => _toSwap,
            onChange: (int value) => _toSwap = value,
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
}
