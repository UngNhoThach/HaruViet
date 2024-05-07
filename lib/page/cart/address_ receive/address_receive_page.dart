import 'package:eco_app/component/button/bottom_bar_button.dart';
import 'package:eco_app/component/button/solid_button.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//
class AddressReceivePage extends StatefulWidget {
  const AddressReceivePage({super.key});

  @override
  State<AddressReceivePage> createState() => _AddressReceivePageState();
}

class _AddressReceivePageState extends State<AddressReceivePage> {
  // variables and functions

  final List<bool> values = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGray02,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Địa chỉ nhận hàng'),
        backgroundColor: colorMain,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    itemCount: values.length,
                    separatorBuilder: (context, index) => const Divider(
                          color: colorGray02,
                          height: 1,
                          thickness: 10,
                        ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: colorWhite,
                          border: Border.all(color: colorWhite),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            spaceW6,
                            Checkbox(
                              value: values[index],
                              onChanged: (bool? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    for (int i = 0; i < values.length; i++) {
                                      if (i == index) {
                                        values[i] = newValue;
                                      } else {
                                        values[i] = false;
                                      }
                                    }
                                  });
                                }
                              },
                            ),
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
                                        "Địa chỉ (mặc định)",
                                        style: textTheme.bodyLarge?.copyWith(
                                          color: colorBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.grey.shade300,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                        ),
                                        child: const Text(
                                          "Nhà riêng",
                                          style: TextStyle(
                                              fontSize: 12, color: colorBlack),
                                        ),
                                      )
                                    ],
                                  ),
                                  spaceH6,
                                  Row(
                                    children: [
                                      Text(
                                        '090 9333 9999',
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: colorBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  spaceH6,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '431, Trần Hưng Đạo, P9, Q1 TPHCM 431, Trần Hưng Đạo, P9, Q1 TPHCM 431, Trần Hưng Đạo, P9, Q1 TPHCM',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: colorGray04,
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
                      );
                    }),
              ],
            ),
          ),
          spaceH20,
          InkWell(
            onTap: () {
              routeService.pushNamed(
                Routes.addressPage,
              );
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add,
                      color: colorWhite,
                    ),
                    spaceW4,
                    Text(
                      'Thêm địa chỉ',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    spaceW4,
                  ],
                ),
              ),
            ),
          ),
          spaceH72,
        ],
      ),
      bottomNavigationBar: BottomBarButton(
        button1: AppSolidButton.medium(
          'Tiếp tục',
          textStyle: textTheme.bodyLarge,
          color: colorMain,
          onPressed: () {
            // routeService.pushNamed(
            //   Routes.checkOutPage,
            // );
          },
        ),
      ),
    );
  }
}
