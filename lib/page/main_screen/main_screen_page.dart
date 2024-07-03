import 'package:eco_app/component/input/search_bar.dart';
import 'package:eco_app/component/popup/popup.dart';
import 'package:eco_app/database_local/product/cart_provider.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/page/cart/models/cart_page_params.dart';
import 'package:eco_app/page/category/category_page.dart';
import 'package:eco_app/page/category/models/category_paga_params.dart';
import 'package:eco_app/page/home/home_page.dart';
import 'package:eco_app/page/home/widgets/drawer_list_page.dart';
import 'package:eco_app/page/main_screen/main_screen_state.dart';
import 'package:eco_app/page/notification/notification_page.dart';
import 'package:eco_app/page/profile/profile_page.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'main_screen_bloc.dart';

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({
    this.screenIndex,
    // required this.cartDatabase,
    super.key,
  });

  final int? screenIndex;
  // final CartDatabase cartDatabase;

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  // variables and functions
  late MainScreenBloc bloc;
  late PersistentTabController _controller;
  String keywordText = '';
  bool _onTapWorkPlan = false;
  int screenIndex = 0;
  TextStyle? styleTitles = textTheme.titleMedium
      ?.copyWith(color: colorWhite, fontWeight: FontWeight.bold);
  late bool _hideNavBar;

  @override
  void dispose() {
    // _controller.removeListener(_onTabChanged);

    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _hideNavBar = false;
    _controller = PersistentTabController(initialIndex: screenIndex);
    _controller.addListener(_onTabChanged);
    super.initState();
    bloc = MainScreenBloc()..getData();
  }

  void _onTabChanged() {
    setState(() {
      screenIndex = _controller.index;
    });
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        iconSize: 24,
        icon: const Icon(
          Icons.home,
        ),
        title: ("Trang chủ"),
        activeColorPrimary: colorMain,
        inactiveColorPrimary: colorBlueGray03,
      ),
      PersistentBottomNavBarItem(
        iconSize: 24,
        icon: const Icon(Icons.notifications),
        title: ("Thông báo"),
        activeColorPrimary: colorMain,
        inactiveColorPrimary: colorBlueGray03,
      ),
      PersistentBottomNavBarItem(
        iconSize: 24,
        icon: const Icon(Icons.shopify_sharp),
        title: ("Danh mục"),
        activeColorPrimary: colorMain,
        inactiveColorPrimary: colorBlueGray03,
      ),
      // PersistentBottomNavBarItem(
      //   iconSize: 24,
      //   icon: const Icon(Icons.shopping_cart_outlined),
      //   title: ("Giỏ hàng"),
      //   activeColorPrimary: colorMain,
      //   inactiveColorPrimary: colorBlueGray03,
      // ),
      PersistentBottomNavBarItem(
        iconSize: 24,
        icon: const Icon(Icons.person),
        title: ("Tài khoản"),
        activeColorPrimary: colorMain,
        inactiveColorPrimary: colorBlueGray03,
      ),
    ];
  }

  final List<Widget> _buildScreens = [
    const HomePage(),
    const NotificationTabPage(),
    CategoryPage(
      params: CategoryPageParams(isAppBar: false),
    ),
    // CartPage(
    //   params: CartPageParams(isAppBar: false),
    // ),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
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
          return Scaffold(
            appBar: screenIndex == 0
                ? AppBar(
                    centerTitle: true,
                    title: _buildSearchField(),
                    backgroundColor: colorMain,
                    actions: <Widget>[
                      Consumer<CartProvider>(
                        builder: (BuildContext context, CartProvider value,
                            Widget? child) {
                          return badges.Badge(
                            position:
                                badges.BadgePosition.topEnd(top: 0, end: 2),
                            showBadge: value.getCounter() == 0 ? false : true,
                            ignorePointer: false,
                            badgeStyle: const badges.BadgeStyle(
                                badgeColor: Colors.yellow),
                            badgeContent: Text('${value.counter}'),
                            child: IconButton(
                              onPressed: () {
                                routeService.pushNamed(Routes.cartPage,
                                    arguments: CartPageParams(isAppBar: true));
                              },
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                color: colorWhite,
                                weight: 2.5.sp,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : screenIndex == 1
                    ? AppBar(
                        centerTitle: true,
                        title: Text('Thông báo', style: styleTitles),
                        // title: Text('${widget.cartDatabase.getCount()}',
                        //     style: styleTitles),
                        backgroundColor: colorMain,
                      )
                    : screenIndex == 2
                        ? AppBar(
                            centerTitle: true,
                            title: _buildSearchField(),
                            backgroundColor: colorMain,
                            actions: <Widget>[
                              Consumer<CartProvider>(
                                builder: (BuildContext context,
                                    CartProvider value, Widget? child) {
                                  return badges.Badge(
                                    position: badges.BadgePosition.topEnd(
                                        top: 0, end: 2),
                                    showBadge:
                                        value.getCounter() == 0 ? false : true,
                                    ignorePointer: false,
                                    badgeStyle: const badges.BadgeStyle(
                                        badgeColor: Colors.yellow),
                                    badgeContent: Text('${value.counter}'),
                                    child: IconButton(
                                      onPressed: () {
                                        routeService.pushNamed(Routes.cartPage,
                                            arguments:
                                                CartPageParams(isAppBar: true));
                                      },
                                      icon: Icon(
                                        Icons.shopping_cart_outlined,
                                        color: colorWhite,
                                        weight: 2.5.sp,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        // : screenIndex == 3
                        //     ? AppBar(
                        //         centerTitle: true,
                        //         title: Text(
                        //           'Giỏ hàng',
                        //           style: textTheme.titleMedium?.copyWith(
                        //               color: colorWhite,
                        //               fontWeight: FontWeight.bold),
                        //         ),
                        //         backgroundColor: colorMain,
                        //       )
                        : screenIndex == 3
                            ? AppBar(
                                centerTitle: true,
                                title: Text(
                                  'Quản lý tài khoản',
                                  style: textTheme.titleMedium?.copyWith(
                                      color: colorWhite,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: colorMain,
                              )
                            : AppBar(
                                centerTitle: true,
                                title: Text('Thông báo', style: styleTitles),
                                backgroundColor: colorMain,
                              ),
            drawer: const DrawerListPage(),
            body: PersistentTabView(
              //  stateManagement: (_controller.index == 3) ? false : true,
              // onItemSelected: (index) {
              //   setState(() {
              //     _controller.index = index;
              //   });
              // },

              confineInSafeArea: true,
              context,
              controller: _controller,
              screens: _buildScreens,
              items: _navBarsItems(),
              backgroundColor: colorBlueGray01,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              //   hideNavigationBar: true,
              hideNavigationBarWhenKeyboardShows: true,
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 50),
                curve: Curves.bounceInOut,
              ),
              navBarStyle: NavBarStyle.style6,
              hideNavigationBar: _hideNavBar,

              selectedTabScreenContext: (context) {
                context = context;
              },
            ),
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
