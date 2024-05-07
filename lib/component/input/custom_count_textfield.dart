import 'package:flutter/material.dart';

class CustomCountTextFormField extends StatefulWidget {
  final Function(String) onChanged;
  final Function() onChangedRight;
  final Function() onChangedLeft;

  final String initialValue;

  const CustomCountTextFormField({
    required this.onChanged,
    required this.initialValue,
    required this.onChangedRight,
    required this.onChangedLeft,
    Key? key,
  }) : super(key: key);

  @override
  _CustomCountTextFormFieldState createState() =>
      _CustomCountTextFormFieldState();
}

class _CustomCountTextFormFieldState extends State<CustomCountTextFormField> {
  late TextEditingController _controller;
  late String _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _controller = TextEditingController(text: _currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: widget.onChangedLeft, child: const Icon(Icons.remove)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: SizedBox(
            height: 36,
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                widget.onChanged.call(value);
              },
              controller: _controller,
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: widget.onChangedRight,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
