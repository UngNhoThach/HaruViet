import 'package:eco_app/component/button/bottom_bar_button.dart';
import 'package:eco_app/component/button/solid_button.dart';
import 'package:eco_app/component/input/text_filed_icon.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//
class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  // variables and functions

  // List of items in our dropdown menu
  String? selectedGender; // Sử dụng kiểu String? cho biến selectedGender

  final FocusNode _focusVouCher = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusVouCher.unfocus();
      },
      child: Scaffold(
        backgroundColor: colorGray02,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Nhập mã - Phiếu mua hàng'),
          backgroundColor: colorMain,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorWhite,
                  border: Border.all(color: colorWhite),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorWhite,
                              border: Border.all(color: colorGray02),
                            ),
                            height: 46,
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            child: ClipRRect(
                              child: Expanded(
                                child: Row(
                                  children: [
                                    spaceW10,
                                    const Icon(Icons.discount,
                                        color: colorGray03),
                                    Expanded(
                                        child: TextFormField(
                                      focusNode: _focusVouCher,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.only(left: 10.w)),
                                    )),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                      ),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: InkWell(
                                          onTap: () {},
                                          child: Text(
                                            'Sử dụng',
                                            style:
                                                textTheme.bodyMedium?.copyWith(
                                              color: colorWhite,
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 8,
                    //       child: CustomTextInput(
                    //         themeColor: colorBlueGray02,
                    //         focusNode: _focusVouCher,
                    //         isNotLabelText: true,
                    //         isCheckPadding: true,
                    //         suffixIcon: Container(
                    //             color: colorGray01,
                    //             width: 80,
                    //             child: const Text(
                    //               'Sử dụng',
                    //               textAlign: TextAlign.center,
                    //             )),
                    //         isNotValidate: true,
                    //         padding: const EdgeInsets.all(0),
                    //         hintTextString: 'Nhập mã giảm giá/ đổi quà',
                    //         inputType: InputType.Default,
                    //         enableBorder: true,
                    //         cornerRadius: 6,
                    //         maxLength: 24,
                    //         prefixIcon:
                    //             const Icon(Icons.discount, color: colorGray03),
                    //         textColor: colorBlack,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              spaceH16,
              Container(
                decoration: BoxDecoration(
                  color: colorWhite,
                  border: Border.all(color: colorWhite),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        spaceW6,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              spaceH6,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Bạn có phiếu mua hàng ?",
                                    style: textTheme.bodyLarge?.copyWith(
                                      color: colorBlack,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              spaceH10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InputDecorator(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedGender ??
                                            "", // Sử dụng toán tử ?? để xác định giá trị mặc định
                                        isDense: true,
                                        isExpanded: true,
                                        items: const [
                                          DropdownMenuItem(
                                            child: Text("Chọn loại phiếu"),
                                            value: "",
                                          ),
                                          DropdownMenuItem(
                                            child:
                                                Text("Giảm 50%  đơn hàng 3km"),
                                            value: "Male",
                                          ),
                                          DropdownMenuItem(
                                            child: Text(
                                                "Giảm 70% cho đơn hàng 3km"),
                                            value: "Female",
                                          ),
                                        ],
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedGender = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              spaceH12,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              spaceH32,
            ],
          ),
        ),
        bottomNavigationBar: BottomBarButton(
          widgetOnButton: Column(
            children: [
              spaceH6,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thành tiền (đã VAT)",
                    style: textTheme.titleMedium?.copyWith(color: colorBlack),
                  ),
                  Text(
                    "4.700.000 đ",
                    style: textTheme.titleLarge?.copyWith(
                        color: colorMain, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              spaceH6,
            ],
          ),
          button1: AppSolidButton.medium(
            'Áp dụng',
            textStyle: textTheme.bodyLarge,
            color: colorMain,
            onPressed: () {
              routeService.pushNamed(
                Routes.checkOutPage,
              );
            },
          ),
        ),
      ),
    );
  }
}
