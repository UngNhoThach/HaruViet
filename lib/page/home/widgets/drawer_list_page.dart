import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/history_orders/widget/history_order_params.dart';
import 'package:haruviet/page/home/widgets/drawer_list_bloc.dart';
import 'package:haruviet/page/home/widgets/drawer_list_state.dart';
import 'package:haruviet/page/view_data_web/widgets/view_data_web_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerListPage extends StatefulWidget {
  final bool isLogin;
  final String name;
  final String url;

  const DrawerListPage(
      {super.key,
      required this.isLogin,
      required this.name,
      required this.url});

  @override
  State<DrawerListPage> createState() => _DrawListState();
}

class _DrawListState extends State<DrawerListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late DrawerListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = DrawerListBloc()
      ..getData(
        isLogin: widget.isLogin,
      );
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<DrawerListBloc, DrawerListState>(
        builder: (context, state) {
          return Drawer(
              child: Padding(
            padding: EdgeInsets.only(
              left: 8.w,
              right: 4,
              top: widget.isLogin ? 60 : 16,
            ),
            child:
                // state.isLoading
                //     ? const LoadingWidget()
                //     :
                ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: <Widget>[
                widget.isLogin
                    ? Row(
                        children: [
                          CircleAvatar(
                              radius: 30.r,
                              backgroundColor: colorBackgroundWhite,
                              child: CircleAvatar(
                                radius: 38.r,
                                child: widget.url == ""
                                    ? AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                            decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(65.r)),
                                          color: colorBackgroundWhite
                                              .withOpacity(0.5),
                                        )),
                                      )
                                    : AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 2.w),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image:
                                                      NetworkImage(widget.url),
                                                  fit: BoxFit.contain)),
                                        )),
                              )

                              //
                              ),
                          spaceW12,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Xin chào,",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: colorPrimary,
                                ),
                              ),
                              spaceH4,
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Text(
                                      widget.name,
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorBlackTileItem,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    : space0,
                spaceH26,
                _itemDrawer(
                  context,
                  title: 'Giỏ hàng',
                  icon: Icons.shopping_basket,
                  onTap: () {
                    !widget.isLogin
                        ? routeService.pushNamed(Routes.login,
                            arguments: SignInParams(typeDirec: 1))
                        : routeService.pushNamed(Routes.cartPage,
                            arguments: CartPageParams(isAppBar: true));
                  },
                ),
                const Divider(),
                _itemDrawer(
                  context,
                  title: 'Lịch sử mua hàng',
                  icon: Icons.history,
                  onTap: () {
                    !widget.isLogin
                        ? routeService.pushNamed(Routes.login,
                            arguments: SignInParams(typeDirec: 1))
                        : routeService.pushNamed(Routes.historyOrderPage,
                            arguments: HistoryOrderParams(
                                onReload: () {},
                                listStatusOrder: state.listStatusOrder));
                  },
                ),
                const Divider(),
                _itemDrawer(
                  context,
                  title: 'Về chúng tôi',
                  icon: Icons.help,
                  onTap: () {
                    routeService.pushNamed(Routes.viewDataWeb,
                        arguments: ViewDataWebPageParams(
                            title: 'Về chúng tôi',
                            url: "https://dev.sni.vn/about.html"));
                  },
                ),
                const Divider(),
                _itemDrawer(
                  context,
                  title: 'Liên hệ',
                  icon: Icons.call,
                  onTap: () {
                    routeService.pushNamed(Routes.viewDataWeb,
                        arguments: ViewDataWebPageParams(
                            title: 'Liên hệ',
                            url: "https://dev.sni.vn/contact.html"));
                  },
                ),
                const Divider(),
                _itemDrawer(
                  context,
                  title: 'Phương thức thanh toán',
                  icon: Icons.payments_sharp,
                  onTap: () {
                    routeService.pushNamed(Routes.viewDataWeb,
                        arguments: ViewDataWebPageParams(
                            title: 'Phương thức thanh toán',
                            url:
                                "https://hotro.hasaki.vn/dieu-khoan-su-dung.html"));
                  },
                ),
                const Divider(),
                _itemDrawer(
                  context,
                  title: 'Chính sách đổi trả',
                  icon: Icons.cached_sharp,
                  onTap: () {
                    routeService.pushNamed(Routes.viewDataWeb,
                        arguments: ViewDataWebPageParams(
                            title: 'Chính sách đổi trả',
                            url:
                                "https://hotro.hasaki.vn/doi-tra-hoan-tien.html"));
                  },
                ),
                const Divider(),
                _itemDrawer(
                  context,
                  title: 'Chính sách bảo mật',
                  icon: Icons.security,
                  onTap: () {
                    routeService.pushNamed(Routes.viewDataWeb,
                        arguments: ViewDataWebPageParams(
                            title: 'Chính sách bảo mật',
                            url:
                                "https://hotro.hasaki.vn/chinh-sach-bao-mat.html"));
                  },
                ),
                const Divider(),
                _itemDrawer(
                  context,
                  title: 'Chính sách bảo hành',
                  icon: Icons.branding_watermark,
                  onTap: () {
                    routeService.pushNamed(Routes.viewDataWeb,
                        arguments: ViewDataWebPageParams(
                            title: 'Chính sách bảo hành',
                            url:
                                "https://hotro.hasaki.vn/dieu-khoan-su-dung.html"));
                  },
                ),
                const Divider(),
                _itemDrawer(
                  context,
                  title: 'Hỗ trợ',
                  icon: Icons.support_agent_rounded,
                  onTap: () {
                    routeService.pushNamed(Routes.supportPage);
                  },
                ),
                const Divider(),
                _itemDrawer(
                  context,
                  title: 'Cài đăt',
                  icon: Icons.settings,
                  onTap: () {
                    routeService.pushNamed(Routes.supportPage);
                  },
                ),
              ],
            ),
          ));
        },
      ),
    );
  }

  // ITEM DRAWER
  Widget _itemDrawer(BuildContext context,
      {required String title,
      required IconData icon,
      required void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: colorPrimary,
            ),
            spaceW16,
            Flexible(
                child: Text(
              title,
              style: textTheme.bodyMedium?.copyWith(),
            ))
          ],
        ),
      ),
    );
  }
}
