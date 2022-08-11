import 'package:flutter/material.dart';

class SwapValue extends StatefulWidget {
  const SwapValue({
    super.key,
    this.prefix = '',
    required this.readValue,
    required this.onChange,
  });

  final String prefix;
  final int Function() readValue;
  final void Function(int value) onChange;

  @override
  State<SwapValue> createState() => _SwapValueState();
}

class _SwapValueState extends State<SwapValue> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 64 * MediaQuery.of(context).textScaleFactor,
          child: Text(
            '${widget.prefix} ${widget.readValue()}',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
          child: Slider(
            max: 6,
            divisions: 3,
            value: widget.readValue().toDouble(),
            onChanged: (double value) {
              setState(() {
                widget.onChange(value.round());
              });
            },
          ),
        ),
      ],
    );
  }
}
