import 'dart:async';
import 'package:flutter/material.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';

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
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialCounter;

    _controller = TextEditingController(text: '$_counter');

    // Listener to update counter when focus is lost
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _updateCounterFromTextField();
      }
    });
  }

  @override
  void didUpdateWidget(covariant CountQuality oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the counter if the initialCounter has changed
    if (widget.initialCounter != oldWidget.initialCounter) {
      _counter = widget.initialCounter;
      _controller.text = '$_counter';
    }
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
    // newValue != widget.initialCounter check if the initialCounter has changed
    if (newValue != null && newValue != widget.initialCounter) {
      _counter = newValue;
      widget.onCounterChanged(_counter);
    } else {
      // Reset to the last valid counter value if input is invalid
      _controller.text = '$_counter';
    }
  }

  void _handleDebounce(Future<void> Function() callback) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      await callback();
    });
  }

  void _incrementCounter() {
    //   setState(() {
    _counter++;
    _controller.text = '$_counter';
    //   });
    _handleDebounce(() async {
      await widget.onCounterChanged(_counter);
    });
  }

  void _decrementCounter() {
    if (_counter > 1) {
      _counter--;
      _controller.text = '$_counter';
      //   });
      _handleDebounce(() async {
        await widget.onCounterChanged(_counter);
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
                size: 30,
                Icons.remove,
                color: colorGray05,
              ),
            ),
            spaceW8,
            SizedBox(
              width: 60,
              height: 40,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                // keyboardType: TextInputType.number,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                focusNode: _focusNode,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  //contentPadding: fix error don't show all values
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  border: OutlineInputBorder(),
                ),

                controller: _controller,
                onChanged: (newValue) {
                  final value = int.tryParse(newValue);
                  if (value != null) {
                    _counter = value;
                  }
                },
                // onFieldSubmitted: (newValue) {
                //   _updateCounterFromTextField();
                // },
              ),
            ),
            spaceW8,
            GestureDetector(
              onTap: _incrementCounter,
              child: const Icon(
                size: 30,
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
