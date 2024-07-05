import 'package:flutter/material.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/theme/typography.dart';

class CountQuality extends StatefulWidget {
  final int initialCounter;
  final Function(int) onCounterChanged;

  const CountQuality({
    Key? key,
    required this.initialCounter,
    required this.onCounterChanged,
  }) : super(key: key);

  @override
  State<CountQuality> createState() => _CountQualityState();
}

class _CountQualityState extends State<CountQuality> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialCounter;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    widget.onCounterChanged(_counter);
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
      widget.onCounterChanged(_counter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Số lượng:',
          style: textTheme.titleMedium,
        ),
        Row(
          children: [
            GestureDetector(
                onTap: _decrementCounter,
                child: const Icon(
                  Icons.remove,
                  color: colorGray05,
                )),
            spaceW16,
            SizedBox(
              width: 60,
              height: 30,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  if (int.tryParse(newValue) != null) {
                    setState(() {
                      _counter = int.parse(newValue);
                    });
                    widget.onCounterChanged(_counter);
                  }
                },
                controller: TextEditingController(text: '$_counter'),
              ),
            ),
            spaceW16,
            GestureDetector(
              onTap: _incrementCounter,
              child: const Icon(
                Icons.add,
                color: colorGray05,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
