import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/component/popup/alert/alert_cofirm.dart';
import 'package:haruviet/component/popup/popup.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/notification/tab/news/news_bloc.dart';
import 'package:haruviet/page/notification/tab/news/news_state.dart';
import 'package:haruviet/page/profile/models/list_profile_selection.dart';
import 'package:haruviet/page/profile/widgets/order_item.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/service/clearedStoredData.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late NewsBloc bloc;

  // variables and functions
  List<ListProfileSection> listSection = [];

  @override
  void initState() {
    super.initState();
    bloc = NewsBloc()..getData();
  }

  createSection(String title, Widget icon, Color color,
      {required void Function() onTap}) {
    return ListProfileSection(
        title: title, icon: icon, color: color, onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<NewsBloc, NewsState>(
        listenWhen: (previous, current) =>
            previous.isSubmitSuccess != current.isSubmitSuccess &&
            current.isSubmitSuccess == true,
        listener: (context, state) {
          if (state.isLoading) {
            showPopupLoading(context, text: 'Đang tải...');
          } else if (state.isSubmitSuccess) {
            // Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            return Builder(builder: (context) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 12),
                    itemCount: state.listNews!.length,
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
                            Text(state.listNews?[index].title ?? '',
                                style: textTheme.bodyMedium?.copyWith(
                                    color: colorBlack,
                                    fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 80,
                                    width: 100,
                                    padding: EdgeInsets.all(6.r),
                                    child: Image.network(
                                      state.listNews?[index].image ?? '',
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
                                                state.listNews?[index]
                                                        .description ??
                                                    '',
                                                style: textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500)),
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
                                                state.listNews?[index]
                                                        .location ??
                                                    '',
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
                                Text(state.listNews?[index].time ?? '',
                                    style: textTheme.bodySmall),
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
              );
            });
          },
        ),
      ),
    );
  }

// đơn hàng
  Widget _orderHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Đơn hàng",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: colorBlack, fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "Xem tất cả đơn hàng",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: colorGray03),
                ),
                const Icon(
                  Icons.navigate_next,
                  color: colorGray03,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ListView buildListView(NewsState state) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _item(context,
            onTap: listSection[index].onTap,
            child: listSection[index].icon,
            title: listSection[index].title);
      },
      itemCount:
          (state.userInfoLogin?.isLogin == false || state.userInfoLogin == null)
              ? listSection.length - 1
              : listSection.length,
    );
  }

  Widget _item(
    BuildContext context, {
    required Function() onTap,
    required Widget child,
    required String title,
  }) {
    return InkWell(
      splashColor: Colors.teal.shade200,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 16.w, right: 12.w),
        padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
        child: Row(
          children: <Widget>[
            child,
            spaceW12,
            Text(
              title,
            ),
            const Spacer(
              flex: 1,
            ),
            const Icon(
              Icons.navigate_next,
              color: colorGray03,
            )
          ],
        ),
      ),
    );
  }

  Widget _orderItem(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: const Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              OrderItem(
                isSelected: true,
                assetImageString: 'assets/images/user_information.png',
                itemString: "Chờ thanh toán",
                destinationWidget: null,
                notifyNumber: "0",
              ),
              OrderItem(
                isSelected: false,
                assetImageString: 'assets/images/recruitment.png',
                itemString: "Hàng mới về",
                destinationWidget: null,
                notifyNumber: "0",
              ),
              OrderItem(
                isSelected: false,
                assetImageString: 'assets/images/maneuver.png',
                itemString: "Giao 2h",
                destinationWidget: null,
                notifyNumber: "0",
              ),
              OrderItem(
                isSelected: false,
                assetImageString: 'assets/images/education.png',
                itemString: "Bảng giá",
                destinationWidget: null,
                notifyNumber: "0",
              ),
            ],
          ),
        ),
        spaceH32,
      ],
    );
  }

  // dialog widget
  Future<void> _dialogBuilderFailed(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CustomAlertDialog(
            message: 'Vui lòng xác nhận',
            onConfirmPressed: () {
              clearSharedPreferencesData();
              context.justBack();
            },
            titleConfirm: 'Xác nhận',
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 2));
  }
}
