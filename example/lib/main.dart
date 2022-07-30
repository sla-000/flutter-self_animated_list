import 'package:example/logic/list_cubit.dart';
import 'package:example/ui/add_rem_value.dart';
import 'package:example/ui/horizontal_tiles.dart';
import 'package:example/ui/swap_value.dart';
import 'package:example/ui/vertical_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SelfAnimatedList Demo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BlocProvider<ListCubit>(
            create: (context) => _horizontalCubit,
            child: const HorizontalTiles(),
          ),
          const Divider(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocProvider<ListCubit>(
                  create: (context) => _verticalCubit,
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
}
