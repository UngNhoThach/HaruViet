import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/component/popup/alert/alert_cofirm.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/account/update_profile/widgets/update_profile_params.dart';
import 'package:haruviet/page/profile/models/list_profile_selection.dart';
import 'package:haruviet/page/profile/profile_bloc.dart';
import 'package:haruviet/page/profile/profile_state.dart';
import 'package:haruviet/page/profile/widgets/order_item.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/service/clearedStoredData.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  // final ProfileParams params;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc bloc;

  // variables and functions
  List<ListProfileSection> listSection = [];

  @override
  void initState() {
    bloc = ProfileBloc()..getData();

    // TODO: implement initState
    super.initState();

    createListItem();
  }

  void createListItem(
      // ProfileState state
      ) {
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
      "Địa chỉ của tôi",
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
      "Đổi mật khẩu",
      const Icon(
        Icons.change_circle_outlined,
        color: colorGray03,
      ),
      colorMain.withOpacity(0.7),
      onTap: () {
        routeService.pushNamed(Routes.forgetPassWordPage);
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
      title: title,
      icon: icon,
      color: color,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) =>
            previous.isSubmitSuccess != current.isSubmitSuccess &&
            current.isSubmitSuccess == true,
        listener: (context, state) {},
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Scaffold(
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
                                            onPressed: () {},
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
                                                        arguments:
                                                            UpdateProfileParams(
                                                      onReload: () {
                                                        bloc.getData();
                                                      },
                                                    ));
                                                  },
                                                )
                                        ],
                                      ),
                                    ),
                                    spaceH16,
                                    (state.userInfoLogin?.isLogin == false ||
                                            state.userInfoLogin == null)
                                        ? space0
                                        : spaceH12,
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
                                        : spaceH12,
                                    Text(
                                      state.userInfoLogin?.email ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: colorPrimary,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    spaceH16,
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
                                    _buildListView(state),
                                  ],
                                ),
                              ),
                              state.userInfoLogin?.avatar == null ||
                                      state.userInfoLogin?.avatar == ""
                                  ? Align(
                                      alignment: Alignment.topCenter,
                                      child: CircleAvatar(
                                        radius: 56.r,
                                        backgroundColor: colorBlueGray02,
                                        child: CircleAvatar(
                                            radius: 40.r,
                                            backgroundColor: colorBlueGray02,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(),
                                            )),
                                      ))
                                  : Align(
                                      alignment: Alignment.topCenter,
                                      child: CircleAvatar(
                                        radius: 56.r,
                                        backgroundColor: Colors.white70,
                                        child: CircleAvatar(
                                            radius: 40.r,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade400,
                                                        width: 2.w),
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            state.userInfoLogin
                                                                    ?.avatar ??
                                                                ''),
                                                        fit: BoxFit.contain)),
                                              ),
                                            )),
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
            onTap: () {
              routeService.pushNamed(
                Routes.ordersPage,
              );
            },
            child: Row(
              children: [
                Text(
                  "Xem lịch sử mua hàng",
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

  ListView _buildListView(ProfileState state) {
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
              ? listSection.length - 4
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
                itemString: "Chờ xác nhận",
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
