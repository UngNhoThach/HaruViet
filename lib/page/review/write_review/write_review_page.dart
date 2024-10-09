import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/component/button/bottom_bar_button.dart';
import 'package:haruviet/component/button/solid_button.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/review/write_review/widgets/write_review_params.dart';
import 'package:haruviet/page/review/write_review/write_review_bloc.dart';
import 'package:haruviet/page/review/write_review/write_review_state.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WriteReviewPage extends StatefulWidget {
  final WriteReviewParams? params;
  const WriteReviewPage({super.key, this.params});

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  int? replyId;
  late WriteReviewBloc bloc;
  late String domain;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    domain = context.read<UserBloc>().state.subDomain ?? '';
    bloc = WriteReviewBloc(params: widget.params)..getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  IconData? _selectedIcon;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<WriteReviewBloc, WriteReviewState>(
        listenWhen: (previous, current) {
          return previous.isSubmitted != current.isSubmitted &&
              current.isSubmitted == true;
        },
        listener: (context, state) {
          if (state.isSuccess == true) {
            context.justBack();
            CustomSnackBar.showTop(context, state.messsage ?? '');
          } else {
            CustomSnackBar.showTop(context, state.messsage ?? '');
          }
        },
        child: BlocBuilder<WriteReviewBloc, WriteReviewState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Viết đánh giá'),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                body: state.isLoading
                    ? const LoadingLogo()
                    : Stack(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                spaceH16,
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.16,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            spaceW12,
                                            Expanded(
                                              flex: 4,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                                child: Image.network(
                                                  '$domain${state.dataProduct?.image ?? ''}',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.16,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            spaceW12,
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 16.h,
                                                    left: 4.w,
                                                    right: 4.w),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          state.dataProduct
                                                                      ?.promotionPrice ==
                                                                  null
                                                              ? '${state.dataProduct?.price?.priceStr}'
                                                              : '${state.dataProduct?.promotionPrice?.pricePromotion?.priceStr}',
                                                          style: textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        state.dataProduct
                                                                    ?.promotionPrice !=
                                                                null
                                                            ? Text(
                                                                '${state.dataProduct?.price?.priceStr}',
                                                                style: textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                  color:
                                                                      colorItemCover,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                ),
                                                              )
                                                            : space0,
                                                      ],
                                                    ),
                                                    spaceH6,
                                                    Text(
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      state
                                                              .dataProduct
                                                              ?.descriptions
                                                              ?.name ??
                                                          '',
                                                      style: textTheme
                                                          .titleSmall
                                                          ?.copyWith(
                                                        color: colorBlack,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    spaceH6,
                                                    Text(
                                                      state.dataProduct?.brand
                                                              ?.name ??
                                                          '',
                                                      style: textTheme
                                                          .titleSmall
                                                          ?.copyWith(
                                                        color: colorGray03,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                spaceH8,

                                const Divider(
                                  color: colorGray03,
                                  thickness: 2,
                                ),
                                spaceH12,

                                Text(
                                  getRatingText(state.rating),
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: context.appColorScheme
                                        .colorExtendedTextBodyMedium,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                // make ratting
                                Column(
                                  children: [
                                    spaceH12,
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: RatingBar.builder(
                                        initialRating: state.rating ?? 0.0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: 40,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        itemBuilder: (context, _) => Icon(
                                          _selectedIcon ?? Icons.star,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                        onRatingUpdate: (rating) {
                                          bloc.onChangeRating(rating: rating);
                                          // _rating = rating;
                                          // setState(() {});
                                        },
                                      ),
                                    ),
                                    spaceH16,
                                    const Divider(
                                      color: colorGray03,
                                      thickness: 2,
                                      height: 2,
                                    ),
                                    Container(
                                      color: colorGray02,
                                      padding: EdgeInsets.all(16.r),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                  color: colorGray04,
                                                  fontWeight: FontWeight.w500,
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
                                      thickness: 2,
                                      height: 2,
                                    ),
                                    TextFormField(
                                      minLines: 4, // Set this
                                      maxLines: 100, // and this
                                      key: _formKey,
                                      enabled: true,
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(16),
                                          hintText: "Để lại đánh giá chi tiết"),
                                      onChanged: (value) {
                                        bloc.onChangeComment(comment: value);
                                      },
                                      onFieldSubmitted: (value) {
                                        bloc.onChangeComment(comment: value);
                                      },
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
                    context: context,
                    color: Theme.of(context).primaryColor,
                    'Gửi đánh giá',
                    onPressed: bloc.state.isValid
                        ? () {
                            bloc.onSubmitReview();
                          }
                        : null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

// rating case
  String getRatingText(double rating) {
    switch (rating.toInt()) {
      case 0:
        return 'Chạm vào để đánh giá';
      case 1:
        return 'Rất tệ';
      case 2:
        return 'Tệ';
      case 3:
        return 'Bình thường';
      case 4:
        return 'Tốt';
      default:
        return 'Rất tốt';
    }
  }
}
