import 'package:flutter/material.dart';

class AddRemValue extends StatefulWidget {
  const AddRemValue({
    Key? key,
    this.prefix = '',
    required this.readValue,
    required this.onChange,
  }) : super(key: key);

  final String prefix;
  final int Function() readValue;
  final void Function(int value) onChange;

  @override
  State<AddRemValue> createState() => _AddRemValueState();
}

class _AddRemValueState extends State<AddRemValue> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 48 * MediaQuery.of(context).textScaleFactor,
          child: Text(
            '${widget.prefix} ${widget.readValue()}',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Expanded(
          child: Slider(
            min: 0,
            max: 5,
            divisions: 5,
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
