import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/component/popup/alert/alert_cofirm.dart';
import 'package:haruviet/component/popup/popup.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/account/phone_authen/widgets/phone_authen_params.dart';
import 'package:haruviet/page/notification/tab/notification/history_notification_bloc.dart';
import 'package:haruviet/page/notification/tab/notification/history_notification_state.dart';
import 'package:haruviet/page/profile/models/list_profile_selection.dart';
import 'package:haruviet/page/profile/widgets/order_item.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/service/clearedStoredData.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryNotificationPage extends StatefulWidget {
  const HistoryNotificationPage({super.key});

  @override
  State<HistoryNotificationPage> createState() =>
      _HistoryNotificationPageState();
}

class _HistoryNotificationPageState extends State<HistoryNotificationPage> {
  late HistoryNotificationBloc bloc;

  // variables and functions
  List<ListProfileSection> listSection = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = HistoryNotificationBloc()..getData();

    createListItem();
  }

  void createListItem(
      // HistoryNotificationState state
      ) {
    listSection.add(createSection(
      "Lịch sử mua hàng",
      const Icon(
        Icons.history,
        color: colorGray03,
      ),
      colorGray03,
      onTap: () {
        routeService.pushNamed(
          Routes.paymentMethodPage,
        );
      },
    ));
    listSection.add(createSection(
      "Thông báo",
      const Image(
        image: AssetImage('assets/icons/ic_notification.png'),
        width: 20,
        height: 20,
        color: colorGray03,
      ),
      Colors.blue.shade800,
      onTap: () {
        routeService.pushNamed(
          Routes.notificationPage,
        );
      },
    ));
    listSection.add(createSection(
      "Phương thức thanh toán",
      const Image(
        image: AssetImage('assets/icons/ic_payment.png'),
        width: 20,
        height: 20,
        color: colorGray03,
      ),
      Colors.teal.shade800,
      onTap: () {
        routeService.pushNamed(
          Routes.paymentMethodPage,
        );
      },
    ));

    listSection.add(createSection(
      "Thêm địa chỉ",
      const Icon(
        Icons.location_on_rounded,
        color: colorGray03,
      ),
      colorMain.withOpacity(0.7),
      onTap: () {
        routeService.pushNamed(
          Routes.addressPage,
        );
      },
    ));
    listSection.add(createSection(
      "Về chúng tôi",
      const Image(
        image: AssetImage('assets/icons/ic_about_us.png'),
        width: 20,
        height: 20,
        color: colorGray03,
      ),
      Colors.black.withOpacity(0.8),
      onTap: () {
        routeService.pushNamed(
          Routes.aboutPage,
        );
      },
    ));
    listSection.add(createSection(
      "Chính sách đổi trả",
      const Icon(
        Icons.repeat_rounded,
        color: colorGray03,
      ),
      colorGray03,
      onTap: () {
        routeService.pushNamed(
          Routes.notificationPage,
        );
      },
    ));
    listSection.add(createSection(
      "Hỏi đáp",
      const Icon(
        Icons.question_mark,
        color: colorGray03,
      ),
      colorGray03,
      onTap: () {
        routeService.pushNamed(
          Routes.notificationPage,
        );
      },
    ));
    listSection.add(createSection(
      "Hỗ trợ",
      const Icon(
        Icons.support_agent_rounded,
        color: colorGray03,
      ),
      colorGray03,
      onTap: () {
        routeService.pushNamed(Routes.supportPage);
      },
    ));

    listSection.add(createSection(
      "Đổi mật khẩu",
      const Icon(
        Icons.change_circle_outlined,
        color: colorGray03,
      ),
      colorMain.withOpacity(0.7),
      onTap: () {
        routeService.pushNamed(Routes.resetPassWordPage);
      },
    ));

    listSection.add(createSection(
      "Đăng xuất",
      const Image(
        image: AssetImage('assets/icons/ic_logout.png'),
        width: 20,
        height: 20,
        color: colorGray03,
      ),
      colorMain.withOpacity(0.7),
      onTap: () {
        showConfirmActionSheet(
          context,
          message: 'Anh/chị có chắc muốn đăng xuất?',
          confirmButtonLabel: 'Đồng ý',
          onConfirm: () {
            bloc.onLogout();
          },
        );
      },
    ));
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
      child: BlocListener<HistoryNotificationBloc, HistoryNotificationState>(
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
        child: BlocBuilder<HistoryNotificationBloc, HistoryNotificationState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Quản lý tài khoản',
                  style: textTheme.titleMedium?.copyWith(
                      color: colorWhite, fontWeight: FontWeight.bold),
                ),
                backgroundColor: colorMain,
              ),
              backgroundColor: Colors.grey.shade200,
              resizeToAvoidBottomInset: true,
              body: LoadingScaffold(
                isLoading: state.isLoading,
                child: Builder(builder: (context) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          spaceH4,
                          state.userInfoLogin?.isLogin == false ||
                                  state.userInfoLogin == null
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.person_add_alt_rounded,
                                        color: tesst,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          routeService.pushNamed(
                                            Routes.login,
                                            arguments:
                                                SignInParams(typeDirec: 1),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 12),
                                          child: Text(
                                            'Đăng nhập',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: tesst,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '|',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: colorGray04,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          routeService.pushNamed(
                                            Routes.register,
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 12),
                                          child: Text(
                                            'Đăng ký',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: tesst,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : space0,
                          (state.userInfoLogin?.isLogin == false ||
                                  state.userInfoLogin == null)
                              ? spaceH16
                              : spaceH16,
                          Stack(
                            children: <Widget>[
                              Card(
                                margin: const EdgeInsets.only(
                                  top: 50,
                                ),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.r))),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 8.w,
                                          top: 8.h,
                                          right: 8.w,
                                          bottom: 8.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          IconButton(
                                            icon: const Icon(Icons.settings),
                                            iconSize: 24.r,
                                            color: colorGray04,
                                            onPressed: () {
                                              routeService.pushNamed(
                                                  Routes.phoneAuthPage,
                                                  arguments: PhoneAuthParams(
                                                      timeout: 10,
                                                      firstName: '',
                                                      password: '',
                                                      passwordConfirmation: '',
                                                      username: '0967611550'));
                                            },
                                          ),
                                          state.userInfoLogin?.isLogin ==
                                                      false ||
                                                  state.userInfoLogin == null
                                              ? space0
                                              : IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  color: colorGray04,
                                                  iconSize: 24.r,
                                                  onPressed: () {
                                                    routeService.pushNamed(
                                                      Routes.updateProfile,
                                                    );
                                                  },
                                                )
                                        ],
                                      ),
                                    ),
                                    spaceH8,
                                    (state.userInfoLogin?.isLogin == false ||
                                            state.userInfoLogin == null)
                                        ? space0
                                        : spaceH8,
                                    Text(
                                      state.userInfoLogin?.name ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: colorPrimary,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    (state.userInfoLogin?.isLogin == false ||
                                            state.userInfoLogin == null)
                                        ? space0
                                        : spaceH8,
                                    Text(
                                      state.userInfoLogin?.email ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: colorPrimary,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    spaceH12,
                                    Container(
                                      height: 1.h,
                                      width: double.infinity,
                                      color: Colors.grey.shade300,
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          child: _orderHeader(context),
                                        ),
                                        spaceH16,
                                        _orderItem(context),
                                      ],
                                    ),
                                    Container(
                                      height: 1.h,
                                      width: double.infinity,
                                      color: Colors.grey.shade300,
                                    ),
                                    buildListView(state),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 2.w),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              state.userInfoLogin?.avatar ??
                                                  ''),
                                          fit: BoxFit.contain)),
                                  width: 100.w,
                                  height: 100.h,
                                ),
                              ),
                            ],
                          ),
                          spaceH72,
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
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

  ListView buildListView(HistoryNotificationState state) {
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
