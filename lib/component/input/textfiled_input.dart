import 'package:haruviet/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/helper/context.dart';

class TextFiledInput extends StatefulWidget {
  const TextFiledInput({
    super.key,
    required this.onChanged,
    this.isTextFieldFocused,
    this.isClear,
    this.icon,
    this.hintext,
    this.keyboardType,
    this.validator,
    this.isValidator = true,
    this.enabled = true,
    this.autovalidateMode,
  });

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
  final TextEditingController _inputController = TextEditingController();

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
      enabled: widget.enabled,
      controller: _inputController,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefixIcon: widget.icon != null
            ? Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: widget.icon,
              )
            : null,
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
                  setState(() {});
                },
              )
            : null,
      ),
      validator: widget.isValidator ? widget.validator : null,
      onEditingComplete: () {
        if (widget.isTextFieldFocused != null) {
          setState(() {
            widget.isTextFieldFocused == false;
          });
        }
        FocusScope.of(context).unfocus();
      },
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
    this.isBorder = true,
    this.validator,
    this.contentPadding,
    this.isErrorBorder = true,
    this.readOnly = false,
  }) : super(key: key);
  final bool isErrorBorder;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final bool? isClear;
  final bool? isTextFieldFocused;
  final String? hintext;
  final Icon? icon;
  final String? initialText;
  final bool readOnly;
  final TextInputType? keyboardType;
  final bool isBorder;
  final EdgeInsetsGeometry? contentPadding;
  @override
  State<TextFiledInputText> createState() => _TextFiledInputTextState();
}

class _TextFiledInputTextState extends State<TextFiledInputText> {
  late TextEditingController _inputController;
  late String? Function(String?) combinedValidator;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: widget.initialText);
    if (widget.isClear == true) {
      _inputController.clear();
    }

    combinedValidator = (value) {
      if (widget.validator != null) {
        String? validationResult = widget.validator!(value);
        if (validationResult != null && validationResult.isNotEmpty) {
          return '${widget.hintext ?? ''} $validationResult';
        }
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      controller: _inputController,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        errorBorder: widget.isErrorBorder
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: colorGray02))
            : null,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
        prefixIcon: widget.icon != null
            ? Padding(
                padding: EdgeInsets.only(right: 8.w, left: 16),
                child: widget.icon,
              )
            : null,
        hintText: widget.hintext,
        border: widget.isBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.appColor.colorGrey.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              )
            : InputBorder.none,
        enabledBorder: widget.isBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.appColor.colorGrey.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              )
            : null,
        focusedBorder: widget.isBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.appColor.colorGrey.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              )
            : null,
        suffixIcon: _inputController.text.isNotEmpty
            ? GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.clear,
                    color: context.appColor.colorBlack,
                  ),
                ),
                onTap: () {
                  _inputController.clear();
                  setState(() {});
                },
              )
            : null,
      ),
      validator: combinedValidator,
      onEditingComplete: () {
        if (widget.isTextFieldFocused != null) {
          setState(() {
            widget.isTextFieldFocused == false;
          });
        }
        FocusScope.of(context).unfocus();
      },
    );
  }
}
