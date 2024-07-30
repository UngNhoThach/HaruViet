import 'package:haruviet/component/required_label/required_labal.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.title,
    this.styleTitle,
    this.initialText,
    required this.onChanged,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.checkValidator,
    this.isDisplayTitle = true,
    this.isRequired = false,
    this.onClear,
    this.onSend,
    this.isValidate = true,
    this.isAutofocus = false,
    this.isIconSend = false,
  });

  final TextInputType? keyboardType;
  final String? hintText;
  final String title;
  final TextStyle? styleTitle;
  final String? initialText;
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final bool? checkValidator;
  final bool isDisplayTitle;
  final bool isRequired;
  final VoidCallback? onClear;
  final VoidCallback? onSend;

  final bool isIconSend;
  final bool isValidate;
  final bool isAutofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDisplayTitle) ...[
          isRequired
              ? RequiredLabel(
                  title,
                  style: styleTitle ??
                      textTheme.bodyMedium?.copyWith(
                        color:
                            context.appColorScheme.colorExtendedTextBodyMedium,
                      ),
                )
              : Text(
                  softWrap: true,
                  title,
                  style: styleTitle ??
                      textTheme.bodyMedium?.copyWith(
                        color:
                            context.appColorScheme.colorExtendedTextBodyMedium,
                      ),
                ),
          spaceH8,
        ],
        TextFormField(
          autofocus: isAutofocus,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: keyboardType,
          controller: controller,
          enabled: enabled,
          readOnly: readOnly,
          initialValue: initialText,
          maxLines: maxLines ?? 1,
          minLines: minLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            counterText: '',
            label: isDisplayTitle
                ? null
                : (isRequired ? RequiredLabel(title) : null),
            labelText: isDisplayTitle ? null : (isRequired ? null : title),
            labelStyle: !enabled
                ? textTheme.bodySmall?.copyWith(
                    color: context.appColor.colorGrey,
                    fontWeight: FontWeight.w400,
                  )
                : textTheme.bodySmall,
            isDense: true,
            hintText: hintText,
            hintStyle: textTheme.bodySmall?.copyWith(
              color: context.appColorScheme.colorExtendedButtonDisable,
              height: 1.4,
              wordSpacing: 1.2,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.appColor.colorGrey.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.appColor.colorGrey.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.appColor.colorGrey.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.appColor.colorGrey.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            suffixIcon: isIconSend
                ? GestureDetector(
                    child: const Icon(
                      Icons.add,
                      size: 26,
                      color: Colors.green,
                    ),
                    onTap: () {
                      onSend?.call();
                    },
                  )
                : (onClear != null && (initialText ?? '').isNotEmpty
                    ? GestureDetector(
                        child: Icon(
                          Icons.clear,
                          color: context.appColor.colorBlack,
                        ),
                        onTap: () {
                          onClear?.call();
                        },
                      )
                    : null),
          ),
          onChanged: onChanged,
          validator: isValidate ? _validationText : null,
        ),
      ],
    );
  }

  String? _validationText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được trống';
    }
    return null;
  }
}
