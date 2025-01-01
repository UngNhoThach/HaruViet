import 'package:flutter/material.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';

class CustomCountTextFormField extends StatefulWidget {
  final Function(String) onChanged;
  final Function() onChangedRight;
  final Function() onChangedLeft;
  final bool isSpaceSmall;
  final String initialValue;

  const CustomCountTextFormField({
    required this.onChanged,
    required this.initialValue,
    required this.onChangedRight,
    required this.onChangedLeft,
    this.isSpaceSmall = false,
    Key? key,
  }) : super(key: key);

  @override
  _CustomCountTextFormFieldState createState() =>
      _CustomCountTextFormFieldState();
}

class _CustomCountTextFormFieldState extends State<CustomCountTextFormField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late String _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _controller = TextEditingController(text: _currentValue);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomCountTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

  void _handleOnChanged(String value) {
    setState(() {
      _currentValue = value;
      widget.onChanged(value);
    });
  }

  void _handleLeftTap() {
    widget.onChangedLeft();
  }

  void _handleRightTap() {
    widget.onChangedRight();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colorGray03,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: _handleLeftTap,
              child: const Icon(Icons.remove),
            ),
            widget.isSpaceSmall
                ? const SizedBox(width: 4)
                : const SizedBox(width: 20),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: colorGray03),
                    left: BorderSide(color: colorGray03),
                  ),
                ),
                height: 36,
                child: TextFormField(
                  focusNode: _focusNode,
                  style: TextStyle(color: context.colorScheme.primary),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                    border: InputBorder.none,
                  ),
                  onChanged: _handleOnChanged,
                  controller: _controller,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            widget.isSpaceSmall
                ? const SizedBox(width: 12)
                : const SizedBox(width: 20),
            GestureDetector(
              onTap: _handleRightTap,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
