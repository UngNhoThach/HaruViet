import 'package:haruviet/component/input/text_filed_icon.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//
class BillInfoPage extends StatefulWidget {
  const BillInfoPage({super.key});

  @override
  State<BillInfoPage> createState() => _BillInfoPageState();
}

class _BillInfoPageState extends State<BillInfoPage> {
  // variables and functions
  final TextEditingController _nameCompaNyController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  final FocusNode _focusNodeMail = FocusNode();
  final FocusNode _focusNodeNameCompany = FocusNode();
  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeTax = FocusNode();
  final FocusNode _focusNodeLocation = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNodeName.unfocus();
        _focusNodeTax.unfocus();
        _focusNodeNameCompany.unfocus();
        _focusNodeLocation.unfocus();
        _focusNodeMail.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Thông tin xuất hoá đơn'),
          backgroundColor: colorMain,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH8,
              CustomTextInput(
                onChanged: (p0) {},
                focusNode: _focusNodeMail,
                isCheckPadding: true,
                padding: const EdgeInsets.all(0),
                textEditController: _mailController,
                hintTextString: 'Email',
                inputType: InputType.Email,
                enableBorder: false,
                isNotLabelText: true,
                cornerRadius: 0,
                maxLength: 24,
                prefixIcon: const Icon(Icons.mail, color: colorGray03),
                textColor: colorBlack,
                errorMessage: 'Vui lòng nhập đúng định dạng',
                labelText: 'Nhập họ tên người nhận',
              ),
              const Divider(
                color: colorGray03,
              ),
              CustomTextInput(
                  onChanged: (p0) {},
                  focusNode: _focusNodeNameCompany,
                  isCheckPadding: true,
                  padding: const EdgeInsets.all(0),
                  textEditController: _nameCompaNyController,
                  hintTextString: 'Tên công ty',
                  inputType: InputType.Default,
                  enableBorder: false,
                  cornerRadius: 0,
                  isNotLabelText: true,
                  maxLength: 24,
                  prefixIcon: const Icon(Icons.apartment, color: colorGray03),
                  textColor: colorBlack,
                  errorMessage: 'Vui lòng nhập đúng số điện thoại'),
              const Divider(
                color: colorGray03,
              ),
              CustomTextInput(
                onChanged: (p0) {},
                focusNode: _focusNodeName,
                isNotLabelText: true,
                isCheckPadding: true,
                isNotValidate: true,
                padding: const EdgeInsets.all(0),
                hintTextString: 'Họ tên',
                inputType: InputType.Default,
                enableBorder: false,
                cornerRadius: 0,
                maxLength: 24,
                prefixIcon: const Icon(Icons.person, color: colorGray03),
                textColor: colorBlack,
              ),
              const Divider(
                color: colorGray03,
              ),
              CustomTextInput(
                onChanged: (p0) {},
                focusNode: _focusNodeTax,
                isNotLabelText: true,
                isCheckPadding: true,
                isNotValidate: true,
                padding: const EdgeInsets.all(0),
                hintTextString: 'Mã số thuế',
                inputType: InputType.Default,
                enableBorder: false,
                cornerRadius: 0,
                maxLength: 24,
                prefixIcon: const Icon(Icons.attach_money, color: colorGray03),
                textColor: colorBlack,
              ),
              const Divider(
                color: colorGray03,
              ),
              CustomTextInput(
                onChanged: (p0) {},
                focusNode: _focusNodeLocation,
                isNotLabelText: true,
                isCheckPadding: true,
                padding: const EdgeInsets.all(0),
                hintTextString: 'Nhập địa chỉ công ty',
                inputType: InputType.Default,
                enableBorder: false,
                cornerRadius: 0,
                maxLength: 24,
                prefixIcon: const Column(
                  children: [Icon(Icons.location_on, color: colorGray03)],
                ),
                textColor: colorBlack,
                errorMessage: 'Tỉnh/Thành phố, quận/Huyện, phường/Xã',
                labelText: 'Nhập địa chỉ',
                maxLines: 3,
              ),
              const Divider(
                color: colorGray03,
              ),
              spaceH32,
              Row(
                children: [
                  spaceW16,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        routeService.pushNamed(
                          Routes.writeReviewPage,
                        );
                      },
                      child: Container(
                        height: 38.h,
                        decoration: BoxDecoration(
                          color: colorMain,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colorGray02),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Xuất hoá đơn',
                              style: textTheme.bodyLarge?.copyWith(
                                  color: colorWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  spaceW12,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        routeService.pushNamed(
                          Routes.writeReviewPage,
                        );
                      },
                      child: Container(
                        height: 38.h,
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colorGray02),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lưu',
                              style: textTheme.bodyLarge?.copyWith(
                                  color: colorWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  spaceW16,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
