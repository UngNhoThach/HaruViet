import 'dart:math';

import 'package:eco_app/component/always_disabled_focus_node.dart';
import 'package:eco_app/component/required_label/required_labal.dart';
import 'package:eco_app/component/select_address/models/select_address_params.dart';
import 'package:eco_app/data/reponsitory/customers/models/address_response.dart';
import 'package:eco_app/helper/context.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormAddressInput extends StatelessWidget {
  const FormAddressInput({
    super.key,
    required this.title,
    this.styleTitle,
    this.initialText,
    required this.onChanged,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.hintText,
    this.isDisplayTitle = true,
    this.isRequired = false,
    this.isRequiredAddress = true,
    this.isNotAddress = false,
  });

  final String? hintText;
  final String title;
  final TextStyle? styleTitle;
  final String? initialText;
  final void Function(AddressResponse?) onChanged;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool isDisplayTitle;
  final bool isRequired;
  final bool isRequiredAddress;
  final bool isNotAddress;

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
                      textTheme.titleMedium?.copyWith(
                        color:
                            context.appColorScheme.colorExtendedTextTitleMedium,
                        fontWeight: FontWeight.w600,
                      ),
                )
              : Text(
                  title,
                  style: styleTitle ??
                      textTheme.titleMedium?.copyWith(
                        color:
                            context.appColorScheme.colorExtendedTextTitleMedium,
                        fontWeight: FontWeight.w600,
                      ),
                ),
          spaceH8,
        ],
        InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            routeService.pushNamed(
              Routes.selectAddress,
              arguments: SelectAddressParams(
                onChange: (value) {
                  onChanged(value);
                },
                isRequiredAddress: isRequiredAddress,
                isNotAddress: isNotAddress,
              ),
            );
          },
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              TextFormField(
                focusNode: AlwaysDisabledFocusNode(),
                enabled: (initialText ?? '').isNotEmpty,
                readOnly: (initialText ?? '').isNotEmpty,
                initialValue: initialText,
                maxLines: maxLines ?? 2,
                minLines: minLines ?? 1,
                maxLength: maxLength,
                style: TextStyle(
                  color: context.appColorScheme.colorExtendedTextTitleMedium,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  label: isDisplayTitle
                      ? null
                      : (isRequired ? RequiredLabel(title) : null),
                  labelText:
                      isDisplayTitle ? null : (isRequired ? null : title),
                  labelStyle: textTheme.bodySmall,
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
                  child: (initialText ?? '').isNotEmpty
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
                      : Transform.rotate(
                          angle: pi / 2, // Góc quay 90 độ
                          child: Icon(
                            Icons.chevron_right,
                            color: context.appColor
                                .colorBlack, // Sử dụng Theme để truy cập context
                            size: 20,
                          ),
                        )

                  //  Icon(
                  //     CupertinoIcons.battery_full,
                  //     //Icons.chevron_left_rounded,

                  //     color: context.appColor.colorBlack,
                  //     size: 20,
                  //   )

                  ),
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
