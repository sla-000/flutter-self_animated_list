import 'package:flutter/material.dart';

class SliderValue extends StatefulWidget {
  const SliderValue({
    Key? key,
    this.prefix = '',
    required this.readValue,
    required this.onChange,
  }) : super(key: key);

  final String prefix;
  final int Function() readValue;
  final void Function(int value) onChange;

  @override
  State<SliderValue> createState() => _SliderValueState();
}

class _SliderValueState extends State<SliderValue> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 32,
          child: Text(
            '${widget.prefix}${widget.readValue()}',
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
