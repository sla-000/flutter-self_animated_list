import 'package:flutter/material.dart';

class AddRemValue extends StatefulWidget {
  const AddRemValue({
    super.key,
    this.prefix = '',
    this.tooltip = '',
    required this.readValue,
    required this.onChange,
  });

  final String prefix;
  final String tooltip;
  final int Function() readValue;
  final void Function(int value) onChange;

  @override
  State<AddRemValue> createState() => _AddRemValueState();
}

class _AddRemValueState extends State<AddRemValue> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: Row(
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
      ),
    );
  }
}
