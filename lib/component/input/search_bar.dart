import 'dart:async';
import 'package:haruviet/component/input/text_filed.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar(
      {super.key,
      this.readOnly = false,
      this.focusNode,
      this.onChanged,
      this.hintText = '',
      this.isClear,
      this.controller,
      this.autofocus = false,
      this.initialText});

  final void Function(String text)? onChanged;
  final FocusNode? focusNode;
  final bool readOnly;
  final String? hintText;
  final bool? isClear;
  final String? initialText;
  final bool autofocus;
  final TextEditingController?
      controller; // Nhận TextEditingController từ bên ngoài

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late Timer _debounce;
  late TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController =
        widget.controller ?? TextEditingController(text: widget.initialText);
    if (widget.isClear == true) {
      _inputController.clear();
    }
    _debounce = Timer(Duration.zero, () {});
  }

  @override
  void dispose() {
    _inputController.dispose();
    _debounce.cancel();
    super.dispose();
  }

  void _onChangeText(String text) {
    // if (_debounce.isActive) {
    //   _debounce.cancel();
    // }
    // _debounce = Timer(const Duration(milliseconds: 300), () {
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
    // Update the TextEditingController text
    _inputController.text = text;
    // Ensure the cursor is at the end of the text
    _inputController.selection = TextSelection.fromPosition(
      TextPosition(offset: _inputController.text.length),
    );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ColoredBox(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 45.h,
                child: Center(
                  child: AppTextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: widget.autofocus,
                    focusNode: widget.focusNode,
                    onChanged: _onChangeText,
                    readOnly: widget.readOnly,
                    controller: _inputController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: colorWhite,
                      focusColor: colorWhite,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: colorWhite,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      hintText: widget.hintText,
                      hintStyle: textTheme.bodyMedium?.copyWith(
                        color: context
                            .appColorScheme.colorExtendedTextBodyMedium
                            .withOpacity(0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: colorWhite,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      ),
                      suffixIcon: _inputController.text.isNotEmpty
                          ? GestureDetector(
                              child: const Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.clear,
                                  color: colorBlack,
                                ),
                              ),
                              onTap: () {
                                _inputController.clear();
                                if (widget.onChanged != null) {
                                  widget.onChanged!('');
                                }
                                setState(() {});
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
