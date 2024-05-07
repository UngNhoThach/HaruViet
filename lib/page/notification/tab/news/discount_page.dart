import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 12),
            itemCount: 10,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () {
                  routeService.pushNamed(
                    Routes.newDetailPage,
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text('Tủ lạnh TOSIBA ',
                        style: textTheme.bodyMedium?.copyWith(
                            color: colorBlack, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 80,
                            width: 100,
                            padding: EdgeInsets.all(6.r),
                            child: Image.network(
                              'https://images2.thanhnien.vn/zoom/328_205/Uploaded/linhntqc/2023_01_21/picture1-7887.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                        maxLines: null,
                                        'Chi nhánh 1519 Phạm Văn Thuận TP Biên Hoà Đồng Nai, Việt Nam',
                                        style: textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                              spaceH8,
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                        maxLines: null,
                                        'CN 1519 Phạm Văn Thuận TP Biên Hoà',
                                        style: textTheme.bodySmall),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('01-12-2023', style: textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              color: Colors.grey,
              thickness: 0.4,
            ),
          ),
        ),
      ],
    );
  }
}
