import 'package:haruviet/component/always_disabled_focus_node.dart';
import 'package:haruviet/component/required_label/required_labal.dart';
import 'package:haruviet/data/reponsitory/setting/item_base_response.dart';
import 'package:haruviet/data/reponsitory/setting/option_value_base_list_request.dart';
import 'package:haruviet/data/reponsitory/setting/select_option_value_params.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormOptionValueInput extends StatelessWidget {
  const FormOptionValueInput({
    super.key,
    required this.title,
    this.styleTitle,
    this.initialText,
    required this.onChanged,
    required this.option,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.hintText,
    this.isDisplayTitle = true,
    this.isRequired = false,
    this.isRequiredAddress = true,
    this.readOnly = false,
    this.enabled = true,
  });

  final String? hintText;
  final String title;
  final TextStyle? styleTitle;
  final String? initialText;
  final void Function(ItemBaseResponse?) onChanged;
  final OptionValueBaseListRequest option;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool isDisplayTitle;
  final bool isRequired;
  final bool isRequiredAddress;
  final bool readOnly;
  final bool? enabled;

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
                  title,
                  style: styleTitle ??
                      textTheme.bodyMedium?.copyWith(
                        color:
                            context.appColorScheme.colorExtendedTextBodyMedium,
                      ),
                ),
          spaceH8,
        ],
        InkWell(
          onTap: readOnly
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  routeService.pushNamed(
                    Routes.selectOptionValue,
                    arguments: SelectOptionValueParams(
                      option: option,
                      onChanged: (value) {
                        onChanged(value);
                      },
                      title: title,
                    ),
                  );
                },
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              TextFormField(
                focusNode: AlwaysDisabledFocusNode(),
                enabled: false,
                readOnly: true,
                initialValue: initialText,
                maxLines: maxLines ?? 2,
                minLines: minLines ?? 1,
                maxLength: maxLength,
                style: readOnly
                    ? null
                    : TextStyle(
                        color:
                            context.appColorScheme.colorExtendedTextTitleMedium,
                      ),
                decoration: InputDecoration(
                  counterText: '',
                  label: isDisplayTitle
                      ? null
                      : (isRequired ? RequiredLabel(title) : null),
                  labelText:
                      isDisplayTitle ? null : (isRequired ? null : title),
                  labelStyle: readOnly
                      ? textTheme.bodySmall
                          ?.copyWith(color: context.appColor.colorGrey)
                      : textTheme.bodySmall?.copyWith(
                          color: context.appColor.colorBlack.withOpacity(0.55)),
                  isDense: true,
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: context.appColor.colorGrey.withOpacity(0.5)),
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: context.appColor.colorGrey.withOpacity(0.5)),
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: context.appColor.colorGrey.withOpacity(0.5)),
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: context.appColor.colorGrey.withOpacity(0.5)),
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ),
                  suffixIcon: space0,
                ),
                validator: _validationText,
              ),
              Positioned(
                right: 8.w,
                child: (initialText ?? '').isNotEmpty && !readOnly
                    ? GestureDetector(
                        child: Icon(
                          Icons.clear,
                          color: context.appColor.colorBlack,
                          size: 20,
                        ),
                        onTap: () {
                          onChanged(null);
                        },
                      )
                    : Icon(
                        CupertinoIcons.chevron_down,
                        color: context.appColor.colorBlack,
                        size: 20,
                      ),
              )
            ],
          ),
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
