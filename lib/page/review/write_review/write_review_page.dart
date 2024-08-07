import 'package:haruviet/component/button/bottom_bar_button.dart';
import 'package:haruviet/component/button/solid_button.dart';
import 'package:haruviet/component/input/text_filed_icon.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WriteReviewPage extends StatefulWidget {
  const WriteReviewPage({super.key});

  @override
  _WriteReviewPageState createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  int? replyId;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  double _rating = 0.0;
  IconData? _selectedIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Viết đánh giá'),
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
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.16,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 3,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: Image.network(
                                    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
                                    height: MediaQuery.of(context).size.height *
                                        0.16,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 16.h, left: 4.w, right: 4.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '900.000 đ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: colorMain,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            '1.200.000 đ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: colorItemCover,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                          ),
                                        ],
                                      ),
                                      spaceH6,
                                      Text(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        'Tủ lạnh Samsung Inverter 599 lít ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: colorSecondary04,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      spaceH6,
                                      Text(
                                        'Thương hiệu: Samsung',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: colorBlackTileItem,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      spaceH6,
                                    ],
                                  ),
                                ),
                              ),
                              spaceW16,
                            ],
                          ),
                        ],
                      )),
                  spaceH12,
                  const Divider(
                    color: colorGray03,
                  ),

                  // make ratting
                  Column(
                    children: [
                      spaceH12,
                      Text(
                        'Chạm vào ngôi sao để đánh giá',
                        style: textTheme.bodyMedium?.copyWith(
                          color: context
                              .appColorScheme.colorExtendedTextBodyMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      spaceH12,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RatingBar.builder(
                          initialRating: _rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 40,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          itemBuilder: (context, _) => Icon(
                            _selectedIcon ?? Icons.star,
                            color: colorMainCover,
                          ),
                          onRatingUpdate: (rating) {
                            _rating = rating;
                            setState(() {});
                          },
                        ),
                      ),
                      spaceH16,
                      Container(
                        color: colorGray02,
                        padding: EdgeInsets.all(16.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 40,
                                    )),
                                spaceH16,
                                Text(
                                  'Thêm hình ảnh thực tế (không bắt buộc)',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorGray04,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                spaceH8,
                              ],
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        color: colorGray03,
                      ),
                      CustomTextInput(
                        onChanged: (p0) {},
                        focusNode: _focusNode,
                        isNotLabelText: true,
                        isNotValidate: true,
                        isNotPrefixIcon: true,
                        isCheckPadding: true,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        textEditController: _nameController,
                        hintTextString: 'Hãy để lại nhận xét của bạn',
                        inputType: InputType.Default,
                        enableBorder: false,
                        cornerRadius: 0,
                        maxLength: 24,
                        textColor: Colors.black,
                        errorMessage: 'Vui lòng nhập đúng định dạng',
                        // labelText: 'Hãy để lại nhận xét của bạn',
                      ),
                      const Divider(
                        color: colorGray03,
                      ),
                    ],
                  ),
                  spaceH72,
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBarButton(
          button1: AppSolidButton.medium(
            color: colorPrimary,
            'Gửi đánh giá',
            onPressed: _rating == 0.0 ? null : () {},
          ),
        ),
      ),
    );
  }
}
