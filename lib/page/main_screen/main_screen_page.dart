import 'package:eco_app/component/input/search_bar.dart';
import 'package:eco_app/component/popup/popup.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/page/cart/cart_page.dart';
import 'package:eco_app/page/cart/models/cart_page_params.dart';
import 'package:eco_app/page/category/category_page.dart';
import 'package:eco_app/page/category/models/category_paga_params.dart';
import 'package:eco_app/page/home/home_page.dart';
import 'package:eco_app/page/main_screen/main_screen_state.dart';
import 'package:eco_app/page/notification/notification_page.dart';
import 'package:eco_app/page/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'main_screen_bloc.dart';

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({
    this.screenIndex,
    super.key,
  });

  final int? screenIndex;

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  late MainScreenBloc bloc;
  late PersistentTabController _controller;

  String keywordText = '';
  bool _onTapWorkPlan = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
    bloc = MainScreenBloc()..getData();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        iconSize: 28,
        icon: const Icon(
          Icons.home,
        ),
        title: ("Trang chủ"),
        activeColorPrimary: colorMain,
        inactiveColorPrimary: colorBlueGray03,
      ),
      PersistentBottomNavBarItem(
        iconSize: 28,
        icon: const Icon(Icons.notifications),
        title: ("Thông báo"),
        activeColorPrimary: colorMain,
        inactiveColorPrimary: colorBlueGray03,
      ),
      PersistentBottomNavBarItem(
        iconSize: 28,
        icon: const Icon(Icons.shopify_sharp),
        title: ("Danh mục"),
        activeColorPrimary: colorMain,
        inactiveColorPrimary: colorBlueGray03,
      ),
      PersistentBottomNavBarItem(
        iconSize: 28,
        icon: const Icon(Icons.shopping_cart_outlined),
        title: ("Giỏ hàng"),
        activeColorPrimary: colorMain,
        inactiveColorPrimary: colorBlueGray03,
      ),
      PersistentBottomNavBarItem(
        iconSize: 28,
        icon: const Icon(Icons.person),
        title: ("Tài khoản"),
        activeColorPrimary: colorMain,
        inactiveColorPrimary: colorBlueGray03,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const NotificationTabPage(),
      CategoryPage(
        params: CategoryPageParams(isAppBar: false),
      ),
      CartPage(
        params: CartPageParams(isAppBar: false),
      ),
      const ProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomePage(),
      const NotificationTabPage(),
      CategoryPage(
        params: CategoryPageParams(isAppBar: false),
      ),
      CartPage(
        params: CartPageParams(isAppBar: false),
      ),
      const ProfilePage()
    ];

    return BlocProvider(
      create: (context) => bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<MainScreenBloc, MainScreenState>(
            listenWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            listener: (context, state) {
              if (state.isLoading) {
                showPopupLoading(context, text: 'Đang tải...');
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
        child: BlocBuilder<MainScreenBloc, MainScreenState>(
            builder: (context, state) {
          return PersistentTabView(
            navBarHeight: 58,
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: colorBlueGray01,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            //   hideNavigationBar: true,
            hideNavigationBarWhenKeyboardShows: true,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 100),
              curve: Curves.bounceInOut,
            ),
            navBarStyle: NavBarStyle.style6,
          );
        }),
      ),
    );
  }

  Widget _buildSearchField() {
    return AppSearchBar(
      hintText: 'Tìm kiếm theo tên',
      onChanged: (keyword) {
        setState(() {
          keywordText = keyword;
          _onTapWorkPlan = !_onTapWorkPlan;
        });
      },
    );
  }
}
