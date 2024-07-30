import 'package:haruviet/component/always_disabled_focus_node.dart';
import 'package:haruviet/component/popup/popup.dart';
import 'package:haruviet/component/required_label/required_labal.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/date_time.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormDatePicker extends StatelessWidget {
  const FormDatePicker({
    super.key,
    required this.labelText,
    this.controller,
    required this.onChanged,
    this.initialDate,
    this.min,
    this.max,
    this.border,
    this.isRequired = false,
    this.validator,
  });
  final String labelText;
  final DateTime? initialDate;
  final void Function(DateTime date) onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final DateTime? min;
  final DateTime? max;
  final InputBorder? border;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      initialValue: initialDate?.format(pattern: dd_mm_yyyy),
      controller: controller,
      focusNode: AlwaysDisabledFocusNode(),
      decoration: InputDecoration(
        isDense: true,
        border: border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: context.appColor.colorGrey.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
        enabledBorder: border,
        label: isRequired ? RequiredLabel(labelText) : null,
        labelText: isRequired ? null : labelText,
        labelStyle: textTheme.bodySmall,
        hintText: 'Chọn ngày',
        suffixIcon: SizedBox(
          width: 24.r,
          height: 24.r,
          child: Center(
            child: Icon(
              Icons.calendar_today,
              color: initialDate != null
                  ? context.appColor.colorBlack
                  : context.appColor.colorBlack.withOpacity(0.5),
            ),
          ),
        ),
      ),
      readOnly: true,
      onTap: () {
        FocusScope.of(context).unfocus();
        showDialogDatePicker(
          title: labelText,
          selected: initialDate,
          context: context,
          callback: onChanged,
          min: min,
          max: max,
        );
      },
    );
  }
}
