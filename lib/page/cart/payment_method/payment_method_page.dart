import 'package:eco_app/component/button/bottom_bar_button.dart';
import 'package:eco_app/component/button/solid_button.dart';
import 'package:eco_app/component/radio_button/radio_button.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/material.dart';

//
class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  // variables and functions

  var currentIndexRadio = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Phương thức thanh toán'),
          backgroundColor: colorMain,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH8,
                RadioListSelect(
                  items: const [
                    'Thanh toán tiền mặt khi nhận hàng (COD)',
                    'Thẻ ATM nội địa/Internet Banking (Hỗ trợ Internet Banking)',
                    'Thanh toán bằng Momo',
                  ],
                  currentIndex: currentIndexRadio,
                  onSelectedIndex: (index) {
                    if (index != null) {
                      setState(() {
                        currentIndexRadio = index;
                      });
                      // bloc.onChangeInsuranceAndTax(socialInsuranceStatus: index);
                    }
                  },
                ),
                spaceH72,
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBarButton(
          button1: AppSolidButton.medium(
            'Tiếp tục',
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
