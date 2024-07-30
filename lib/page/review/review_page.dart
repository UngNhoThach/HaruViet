import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/review_file.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int? replyId;
  final List<String> imageUrls = [
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
  ];

  final List<String> imageUrls2Item = [
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
  ];
  int currentIndex = 0;
  bool checkIsImageUrls = false;
  final FocusNode _focusNode = FocusNode();
  final List<String> reviewTotal = [
    '1',
    '23',
    '10',
    '323',
    '21',
  ];

  List<Widget> getFormattedReviews() {
    return reviewTotal.map((value) {
      return Text(value);
    }).toList();
  }

  bool isSetting = false;

  bool listenBox = false;

  int length = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool showAllComments = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Đánh giá'),
          backgroundColor: colorMain,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  spaceH16,
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              const Text(
                                '4.5',
                                style: TextStyle(
                                    fontSize: 36,
                                    color: colorMainCover,
                                    fontWeight: FontWeight.bold),
                              ),
                              RatingBar.builder(
                                itemSize: 16,
                                initialRating: 4.5,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: colorMainCover,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              spaceH8,
                              Text(
                                '123 đánh giá',
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: colorSuccess03),
                              ),
                            ],
                          )),
                      spaceW16,
                      Expanded(
                          flex: 7,
                          child: Column(
                            children: [
                              ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    final formattedReview =
                                        getFormattedReviews()[index];
                                    final perCentReview =
                                        int.tryParse(reviewTotal[index]);
                                    return Row(
                                      children: [
                                        Text('${index + 1}'),
                                        spaceW6,
                                        const Icon(
                                          Icons.star,
                                          size: 16,
                                          color: colorMainCover,
                                        ),
                                        spaceW4,
                                        LinearPercentIndicator(
                                          barRadius: const Radius.circular(6),
                                          width: 160.0,
                                          lineHeight: 6.0,
                                          percent: perCentReview! / 378,
                                          progressColor: colorMainCover,
                                        ),
                                        spaceW6,
                                        formattedReview,
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      spaceH8),
                            ],
                          ))
                    ],
                  ),
                  spaceH16,
                  GestureDetector(
                    onTap: () {
                      routeService.pushNamed(
                        Routes.writeReviewPage,
                      );
                    },
                    child: Container(
                      height: 36.h,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colorGray02),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Viết đánh giá',
                              style: TextStyle(
                                  color: colorWhite,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  spaceH12,
                  const Divider(
                    color: colorGray03,
                  ),
                  spaceH12,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Hình ảnh thực tế của khách hàng',
                                  style: textTheme.bodyMedium
                                      ?.copyWith(color: colorSuccess03),
                                ),
                              ],
                            ),
                            spaceH12,
                            index == 9 || index == 3 || index == 5 || index == 1
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          child: ListView.separated(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: index == 3 || index == 1
                                                ? imageUrls2Item.length
                                                : imageUrls.length,
                                            separatorBuilder: (_, __) =>
                                                spaceW4,
                                            itemBuilder: (_, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  ReviewFiles.show(
                                                    context,
                                                    filesUrl: (index == 3 ||
                                                            index == 1)
                                                        ? imageUrls2Item
                                                        : imageUrls,
                                                    initIndex: index,
                                                    onDelete: (index) {
                                                      // uploader.removeFileAtValue(
                                                      //     imageFiles[index], state.domainApi);
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.h),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: colorGray03),
                                                  ),
                                                  child: Image.network(
                                                    imageUrls[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : space0,
                            Row(
                              children: [
                                RatingBar.builder(
                                  itemSize: 14,
                                  initialRating: 4,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  // itemPadding: const EdgeInsets.symmetric(
                                  //     horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: colorMainCover,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                spaceW8,
                                Text(
                                  'Nguyen van thanh dat',
                                  style: textTheme.bodySmall
                                      ?.copyWith(color: colorSuccess03),
                                ),
                                spaceW8,
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: colorMainCover,
                                  size: 16,
                                ),
                                spaceW2,
                                Text(
                                  'Đã mua online',
                                  style: textTheme.bodySmall
                                      ?.copyWith(color: colorMainCover),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('01-12-2023', style: textTheme.bodySmall),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                                maxLines: null,
                                'Kem dưỡng ẩm hàng ngày với khả năng làm mờ vết nhờn cung cấp bảo vệ chống nắng SPF 30, ẩm hàng ngày với khả năng làm mờ vết nhờn cung cấp bảo vệ chống nắng SPF 30,',
                                style: textTheme.bodySmall),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      'Sản phẩm tốt đáng để sử dụng, Sản phẩm tốt đáng để sử dụng, Sản phẩm tốt đáng để sử dụng',
                                      style: textTheme.bodyMedium),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Column(
                          children: [
                            spaceH6,
                            const Divider(
                              color: colorGray03,
                            ),
                            spaceH6
                          ],
                        );
                      },
                    ),
                  ),
                  spaceH72,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
