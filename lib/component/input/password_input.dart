import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/helper/colors.dart';

class PasswordInputV2 extends StatefulWidget {
  const PasswordInputV2({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.isClear,
    this.validator,
    this.enabled = true,
  });

  final String hintText;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final bool? isClear;

  @override
  State<PasswordInputV2> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInputV2> {
  final _inputController = TextEditingController();

  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();

    if (widget.isClear == true) {
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      controller: _inputController,
      onChanged: (value) {
        widget.onChanged(value);
      },
      keyboardType: TextInputType.multiline,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: const Icon(Icons.lock_outline),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
        ),
        hintText: widget.hintText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
        suffixIcon: GestureDetector(
          child: Icon(
            _passwordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: colorBlack,
          ),
          onTap: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 0,
          maxHeight: 16.h,
        ),
      ),
      validator: widget.validator,
    );
    // );
  }
}
