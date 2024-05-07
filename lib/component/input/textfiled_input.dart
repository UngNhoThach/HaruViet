import 'package:eco_app/helper/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFiledInput extends StatefulWidget {
  const TextFiledInput(
      {super.key,
      required this.onChanged,
      this.isTextFieldFocused,
      this.isClear,
      this.icon,
      this.hintext,
      this.keyboardType,
      this.validator,
      this.isValidator = true,
      this.enabled = true,
      this.autovalidateMode});
  final String? Function(String?)? validator;
  final bool isValidator;
  final void Function(String) onChanged;
  final bool? isClear;
  final AutovalidateMode? autovalidateMode;
  final bool? isTextFieldFocused;
  final String? hintext;
  final bool enabled;

  final Icon? icon;
  final TextInputType? keyboardType;
  @override
  State<TextFiledInput> createState() => _TextFiledInputState();
}

class _TextFiledInputState extends State<TextFiledInput> {
  final _inputController = TextEditingController();

  String inputText = '';

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
      autovalidateMode: widget.autovalidateMode,

      // key: ,
      enabled: widget.enabled,
      onEditingComplete: () {
        // Khi hoàn thành chỉnh sửa trong TextField, hủy focus.
        setState(() {
          widget.isTextFieldFocused == false;
        });
        // Ẩn bàn phím.
        FocusScope.of(context).unfocus();
      },
      controller: _inputController,
      onChanged: (value) {
        widget.onChanged(value);
        setState(() {
          inputText = value;
        });
      },
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefixIcon:
            Padding(padding: EdgeInsets.only(right: 8.w), child: widget.icon),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
        ),
        hintText: widget.hintext,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
        suffixIcon: inputText.isNotEmpty
            ? GestureDetector(
                child: Icon(
                  Icons.clear,
                  color: context.appColor.colorBlack,
                ),
                onTap: () {
                  _inputController.clear();
                  setState(() {
                    inputText = '';
                  });
                },
              )
            : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: 0,
          maxHeight: 16.h,
        ),
      ),
      validator: widget.isValidator ? widget.validator : null,
    );
  }
}

class TextFiledInputText extends StatefulWidget {
  const TextFiledInputText({
    Key? key,
    required this.onChanged,
    this.isTextFieldFocused,
    this.isClear,
    this.icon,
    this.hintext,
    this.initialText,
    this.keyboardType,
    this.validator,
    this.readOnly = false,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final bool? isClear;
  final bool? isTextFieldFocused;
  final String? hintext;
  final Icon? icon;
  final String? initialText;
  final bool readOnly;
  final TextInputType? keyboardType;

  @override
  State<TextFiledInputText> createState() => _TextFiledInputTextState();
}

class _TextFiledInputTextState extends State<TextFiledInputText> {
  late TextEditingController _inputController;

  @override
  void initState() {
    super.initState();

    _inputController = TextEditingController(text: widget.initialText);
    if (widget.isClear == true) {
      _inputController.clear();
    }
    // Set initialText as the initial value of the controller
    _inputController.text = widget.initialText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      onEditingComplete: () {
        setState(() {
          widget.isTextFieldFocused == false;
        });
        FocusScope.of(context).unfocus();
      },
      controller: _inputController,
      onChanged: (value) {
        widget.onChanged(value);
      },
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: widget.icon,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
        ),
        hintText: widget.hintext,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
        suffixIcon: _inputController.text.isNotEmpty
            ? GestureDetector(
                child: Icon(
                  Icons.clear,
                  color: context.appColor.colorBlack,
                ),
                onTap: () {
                  _inputController.clear();
                },
              )
            : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: 0,
          maxHeight: 16.h,
        ),
      ),
      validator: widget.validator,
    );
  }
}
