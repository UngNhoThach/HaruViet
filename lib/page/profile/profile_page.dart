import 'dart:async';

import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/component/popup/alert/alert_cofirm.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/connection.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/dialog.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/account/update_profile/widgets/update_profile_params.dart';
import 'package:haruviet/page/add_address/add_address/widgets/address_params.dart';
import 'package:haruviet/page/cart/payment_method/widgets/payment_method_params.dart';
import 'package:haruviet/page/history_orders/widget/history_order_params.dart';
import 'package:haruviet/page/profile/profile_bloc.dart';
import 'package:haruviet/page/profile/profile_state.dart';
import 'package:haruviet/page/profile/widgets/order_item.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/view_data_web/widgets/view_data_web_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/service/clearedStoredData.dart';
import 'package:haruviet/theme/typography.dart';
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
  bool isOffline = false;

  // check connection
  late StreamSubscription connectionChangeStream;
  Color? previousPrimaryColorColor;

  @override
  void initState() {
    bloc = ProfileBloc(context)..getData();
// check connection change
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    if (!connectionStatus.hasConnection) {
      isOffline = !connectionStatus.hasConnection;
    } else {}
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Color primaryColorCover = Theme.of(context).primaryColor;

    if (primaryColorCover != previousPrimaryColorColor) {
      previousPrimaryColorColor = primaryColorCover;
      //     createListItem(previousPrimaryColorColor!);
    }
  }

  connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ObjectKey(isOffline),
      create: (context) => bloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) =>
            previous.isSubmitSuccess != current.isSubmitSuccess &&
            current.isSubmitSuccess == true,
        listener: (context, state) {},
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return isOffline
                ? const Center(
                    child: Text(
                    'Kiểm tra kết nối!',
                  ))
                : Scaffold(
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
                                (!state.isLoginSuccess &&
                                        state.isLoading == false)
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.person_add_alt_rounded,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                routeService.pushNamed(
                                                  Routes.login,
                                                  arguments: SignInParams(
                                                      typeDirec: 1),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 12),
                                                child: Text(
                                                  'Đăng nhập',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
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
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                routeService.pushNamed(
                                                  Routes.register,
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 12),
                                                child: Text(
                                                  'Đăng ký',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
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
                                state.isLoading == false
                                    ? Stack(
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.settings),
                                                        iconSize: 24.r,
                                                        color: colorGray04,
                                                        onPressed: () {},
                                                      ),
                                                      state.userInfoLogin
                                                                      ?.isLogin ==
                                                                  false ||
                                                              state.userInfoLogin ==
                                                                  null
                                                          ? space0
                                                          : IconButton(
                                                              icon: const Icon(
                                                                  Icons.edit),
                                                              color:
                                                                  colorGray04,
                                                              iconSize: 24.r,
                                                              onPressed: () {
                                                                routeService.pushNamed(
                                                                    Routes
                                                                        .updateProfile,
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
                                                Text(
                                                  state.userInfoLogin?.name ??
                                                      '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                ),
                                                state.isLoginSuccess
                                                    ? spaceH12
                                                    : space0,
                                                Text(
                                                  state.userInfoLogin?.email ??
                                                      '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                ),
                                                bloc.state.isLoginSuccess
                                                    ? spaceH12
                                                    : space0,
                                                bloc.state.isLoginSuccess
                                                    ? Container(
                                                        height: 1.h,
                                                        width: double.infinity,
                                                        color: Colors
                                                            .grey.shade300,
                                                      )
                                                    : space0,
                                                bloc.state.isLoginSuccess
                                                    ? Column(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16.w),
                                                            child: _orderHeader(
                                                                context),
                                                          ),
                                                          spaceH16,
                                                          _orderItem(context),
                                                        ],
                                                      )
                                                    : space0,
                                                Container(
                                                  height: 1.h,
                                                  width: double.infinity,
                                                  color: Colors.grey.shade300,
                                                ),
                                                _buildListView(context),
                                              ],
                                            ),
                                          ),
                                          state.userInfoLogin?.avatar == null ||
                                                  state.userInfoLogin?.avatar ==
                                                      ""
                                              ? Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: CircleAvatar(
                                                    radius: 56.r,
                                                    backgroundColor:
                                                        colorBlueGray02,
                                                    child: CircleAvatar(
                                                        radius: 40.r,
                                                        backgroundColor:
                                                            colorBlueGray02,
                                                        child: AspectRatio(
                                                          aspectRatio: 1,
                                                          child: Container(),
                                                        )),
                                                  ))
                                              : Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: CircleAvatar(
                                                    radius: 56.r,
                                                    backgroundColor:
                                                        Colors.white70,
                                                    child: CircleAvatar(
                                                        radius: 40.r,
                                                        child: AspectRatio(
                                                          aspectRatio: 1,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        state.userInfoLogin?.avatar ??
                                                                            ''),
                                                                    fit: BoxFit
                                                                        .contain)),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                        ],
                                      )
                                    : space0,
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
            style: textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          InkWell(
            onTap: () {
              bloc.state.isLoginSuccess
                  ? routeService.pushNamed(Routes.historyOrderPage,
                      arguments: HistoryOrderParams(
                          onReload: () {},
                          listStatusOrder: bloc.state.listStatusOrder))
                  : routeService.pushNamed(Routes.login,
                      arguments: SignInParams(typeDirec: 1));
            },
            child: Row(
              children: [
                Text(
                  "Xem lịch sử mua hàng",
                  style: textTheme.bodyMedium?.copyWith(color: colorGray03),
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

  Widget _buildListView(BuildContext context) {
    final int indexShippingMethod = bloc.state.indexShippingMethod;

    final bool isLogin = bloc.state.isLoginSuccess;

    return Container(
      width: 1.sw - 32.w,
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          isLogin
              ? _item(
                  context,
                  onTap: () {
                    routeService.pushNamed(Routes.paymentMethodPage,
                        arguments: PaymentMethodParams(
                          keyPaymentMethod: '',
                          shippingMethodFuc:
                              (valueShippingMethod, indexShippingMethod) {},
                        ));
                  },
                  child: const Image(
                    image: AssetImage('assets/icons/ic_payment.png'),
                    width: 20,
                    height: 20,
                    color: colorGray03,
                  ),
                  title: "Phương thức thanh toán",
                )
              : space0,
          _item(
            context,
            onTap: () {
              routeService.pushNamed(Routes.viewDataWeb,
                  arguments: ViewDataWebPageParams(
                      title: 'Về chúng tôi',
                      url: "https://dev.sni.vn/about.html"));
            },
            child: const Image(
              image: AssetImage('assets/icons/ic_about_us.png'),
              width: 20,
              height: 20,
              color: colorGray03,
            ),
            title: "Về chúng tôi",
          ),
          _item(
            context,
            onTap: () {
              CustomSnackBar.showTop(
                  context, 'Chức năng đang được phát triển', null);
            },
            child: const Icon(
              Icons.repeat_rounded,
              color: colorGray03,
            ),
            title: "Chính sách đổi trả",
          ),
          _item(
            context,
            onTap: () {
              routeService.pushNamed(Routes.supportPage);
            },
            child: const Icon(
              Icons.support_agent_rounded,
              color: colorGray03,
            ),
            title: "Hỗ trợ",
          ),
          isLogin
              ? _item(
                  context,
                  onTap: () {
                    routeService.pushNamed(Routes.addressPage,
                        arguments: AddressParams(
                          isShipping: false,
                          idAddressShipping: '',
                          returnAddress: (dataAddress) {},
                        ));
                  },
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: colorGray03,
                  ),
                  title: "Địa chỉ của tôi",
                )
              : space0,
          isLogin
              ? _item(
                  context,
                  onTap: () {
                    bloc.state.isLoginSuccess
                        ? routeService.pushNamed(Routes.historyOrderPage,
                            arguments: HistoryOrderParams(
                                onReload: () {},
                                listStatusOrder: bloc.state.listStatusOrder))
                        : routeService.pushNamed(Routes.login,
                            arguments: SignInParams(typeDirec: 1));
                  },
                  child: const Icon(
                    Icons.history,
                    color: colorGray03,
                  ),
                  title: "Lịch sử mua hàng",
                )
              : space0,
          isLogin
              ? _item(
                  context,
                  onTap: () {
                    routeService.pushNamed(Routes.forgetPassWordPage);
                  },
                  child: const Icon(
                    Icons.change_circle_outlined,
                    color: colorGray03,
                  ),
                  title: "Đổi mật khẩu",
                )
              : space0,
          isLogin
              ? _item(
                  context,
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
                  child: const Image(
                    image: AssetImage('assets/icons/ic_logout.png'),
                    width: 20,
                    height: 20,
                    color: colorGray03,
                  ),
                  title: "Đăng xuất",
                )
              : space0
        ],
      ),
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
