import 'dart:async';
import 'package:flutter/material.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';

class CountQuality extends StatefulWidget {
  final int initialCounter;
  final Function(int) onCounterChanged;
  final Widget? widget;

  const CountQuality({
    Key? key,
    this.widget,
    required this.initialCounter,
    required this.onCounterChanged,
  }) : super(key: key);

  @override
  State<CountQuality> createState() => _CountQualityState();
}

class _CountQualityState extends State<CountQuality> {
  late int _counter;
  late FocusNode _focusNode;
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialCounter;
    _focusNode = FocusNode();
    _controller = TextEditingController(text: '$_counter');

    // Listener to update counter when focus is lost
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _updateCounterFromTextField();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _updateCounterFromTextField() {
    final newValue = int.tryParse(_controller.text);
    if (newValue != null) {
      setState(() {
        _counter = newValue;
      });
      widget.onCounterChanged(_counter);
    } else {
      // Reset to the last valid counter value if input is invalid
      _controller.text = '$_counter';
    }
  }

  void _handleDebounce(Function callback) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      callback();
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _controller.text = '$_counter';
    });
    _handleDebounce(() {
      widget.onCounterChanged(_counter);
    });
  }

  void _decrementCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
        _controller.text = '$_counter';
      });
      _handleDebounce(() {
        widget.onCounterChanged(_counter);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget.widget ?? space0,
        Row(
          children: [
            GestureDetector(
              onTap: _decrementCounter,
              child: const Icon(
                Icons.remove,
                color: colorGray05,
              ),
            ),
            spaceW8,
            SizedBox(
              width: 60,
              height: 30,
              child: TextField(
                focusNode: _focusNode,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                controller: _controller,
                onChanged: (newValue) {
                  final value = int.tryParse(newValue);
                  if (value != null) {
                    _counter = value;
                  }
                },
              ),
            ),
            spaceW8,
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
