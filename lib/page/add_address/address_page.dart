import 'package:eco_app/component/button/bottom_bar_button.dart';
import 'package:eco_app/component/button/solid_button.dart';
import 'package:eco_app/component/input/text_filed_icon.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/page/cart/checkout/widgets/checkout_params.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//
class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // variables and functions
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressgHomeController = TextEditingController();
  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeSDT = FocusNode();
  final FocusNode _focusNodeDC = FocusNode();
  final FocusNode _focusNodeDCDetail = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNodeDCDetail.unfocus();
        _focusNodeDC.unfocus();
        _focusNodeSDT.unfocus();
        _focusNodeName.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Địa chỉ nhận hàng'),
          backgroundColor: colorMain,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: colorGray01,
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    Text(
                      'Liên hệ',
                      style: textTheme.bodyMedium?.copyWith(
                          color: colorMain, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: colorGray03,
              ),
              CustomTextInput(
                focusNode: _focusNodeName,
                isCheckPadding: true,
                padding: const EdgeInsets.all(0),
                textEditController: _nameController,
                hintTextString: 'Họ tên người nhận',
                inputType: InputType.Default,
                enableBorder: false,
                isNotLabelText: true,
                cornerRadius: 0,
                maxLength: 24,
                prefixIcon: const Icon(Icons.person, color: colorGray03),
                textColor: Colors.black,
                errorMessage: 'Vui lòng nhập đúng định dạng',
                labelText: 'Nhập họ tên người nhận',
              ),
              const Divider(
                color: colorGray03,
              ),
              CustomTextInput(
                focusNode: _focusNodeSDT,
                isCheckPadding: true,
                padding: const EdgeInsets.all(0),
                textEditController: _phoneNumberController,
                hintTextString: 'Số điện thoại',
                inputType: InputType.Number,
                enableBorder: false,
                cornerRadius: 0,
                isNotLabelText: true,
                maxLength: 24,
                prefixIcon: const Icon(Icons.phone, color: colorGray03),
                textColor: Colors.black,
                errorMessage: 'Vui lòng nhập đúng số điện thoại',
                labelText: 'Nhập số điện thoại',
              ),
              Container(
                color: colorGray01,
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    Text(
                      'Địa chỉ nhận hàng',
                      style: textTheme.bodyMedium?.copyWith(
                          color: colorMain, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: colorGray03,
              ),
              CustomTextInput(
                focusNode: _focusNodeDC,
                isNotLabelText: true,
                isCheckPadding: true,
                padding: const EdgeInsets.all(0),
                textEditController: _addressController,
                hintTextString: 'Địa chỉ',
                inputType: InputType.Default,
                enableBorder: false,
                cornerRadius: 0,
                maxLength: 24,
                prefixIcon: const Icon(Icons.location_on, color: colorGray03),
                textColor: Colors.black,
                errorMessage: 'Tỉnh/Thành phố, quận/Huyện, phường/Xã',
                labelText: 'Nhập địa chỉ',
              ),
              const Divider(
                color: colorGray03,
              ),
              CustomTextInput(
                focusNode: _focusNodeDCDetail,
                isCheckPadding: true,
                padding: const EdgeInsets.all(0),
                textEditController: _addressgHomeController,
                hintTextString: 'Địa chỉ cụ thể',
                inputType: InputType.Default,
                isNotLabelText: true,
                enableBorder: false,
                cornerRadius: 0,
                maxLength: 24,
                prefixIcon: const Icon(Icons.home, color: colorGray03),
                textColor: Colors.black,
                errorMessage: 'Số nhà/Tên đường',
                labelText: 'Nhập địa chỉ cụ thể',
              ),
              const Divider(
                color: colorGray03,
              ),
              Container(
                color: colorGray01,
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    Text(
                      'Cài đặt',
                      style: textTheme.bodyMedium?.copyWith(
                          color: colorMain, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: colorGray03,
              ),
              Container(
                  color: colorGray01,
                  padding: EdgeInsets.all(16.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: 36.h,
                          decoration: BoxDecoration(
                            color: colorSuccess02,
                            border: Border.all(color: colorGray02),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.home_repair_service_sharp),
                              spaceW16,
                              const Text('Công ty',
                                  style: TextStyle(color: colorBlack)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: 36.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: colorGray02),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.home),
                              spaceW16,
                              const Text('Nhà',
                                  style: TextStyle(color: colorBlack)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              const Divider(
                color: colorGray03,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBarButton(
          button1: AppSolidButton.medium(
            'Tiếp tục',
            textStyle: textTheme.bodyLarge,
            color: colorMain,
            onPressed: () {
              routeService.pushNamed(Routes.checkOutPage,
                  arguments: CheckoutParams());
            },
          ),
        ),
      ),
    );
  }
}
