import 'dart:async';

import 'package:haruviet/component/input/search_barv2.dart';
import 'package:haruviet/component/popup/popup.dart';
import 'package:haruviet/connection.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/category/category_page.dart';
import 'package:haruviet/page/category/widgets/category_paga_params.dart';
import 'package:haruviet/page/home/home_page.dart';
import 'package:haruviet/page/home/widgets/drawer_list_page.dart';
import 'package:haruviet/page/main_screen/main_screen_state.dart';
import 'package:haruviet/page/notification/notification_page.dart';
import 'package:haruviet/page/profile/profile_page.dart';
import 'package:haruviet/page/voucher/voucher_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/search/search_product_category_bloc.dart';
import 'package:haruviet/search/search_product_category_page.dart';
import 'package:haruviet/search/search_product_category_state.dart';
import 'package:haruviet/search/widgets/search_widgets.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'main_screen_bloc.dart';

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({
    this.screenIndex,
    // required this.cartDatabase,
    super.key,
  });

  final int? screenIndex;
  // final CartDatabaseV2 cartDatabase;

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  // variables and functions

  TextEditingController searchController = TextEditingController();
  bool isFocused = false;
  final SearchWidgets searchWidgets = SearchWidgets();
  late SearchProductCategoryBloc blocSearchProductCategory;
  late PersistentTabController _controller;
  // check connection
  // GlobalKey _persistentTabViewKey = GlobalKey();
  late StreamSubscription connectionChangeStream;
  bool isOffline = false;

  late MainScreenBloc bloc;
  String keywordText = '';
  int screenIndex = 0;
  TextStyle? styleTitles = textTheme.titleMedium
      ?.copyWith(color: colorWhite, fontWeight: FontWeight.bold);
  late String domain;

  @override
  initState() {
    super.initState();
// check connection change

    // Get the instance of the singleton
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    if (!connectionStatus.hasConnection) {
      isOffline = !connectionStatus.hasConnection;
    } else {}

    _controller = PersistentTabController(initialIndex: screenIndex);

    _controller.addListener(_onTabChanged);
    domain = context.read<SettingAppBloc>().state.xUrl ?? '';
    bloc = MainScreenBloc()..getData();
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
      // _persistentTabViewKey = GlobalKey();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    connectionChangeStream.cancel();
    super.dispose();
  }

  // if (!isOffline) {
  //       setState(() {
  //         _controller = PersistentTabController(initialIndex: screenIndex);
  //       });
  //     }
  final List<Widget> _buildScreens = [
    const HomePage(),
    const VoucherPage(),
    const NotificationTabPage(),
    CategoryPage(
      params: CategoryPageParams(isAppBar: false),
    ),
    const ProfilePage()
  ];

  void _onTabChanged() {
    setState(() {
      screenIndex = _controller.index;
    });
  }

  List<PersistentBottomNavBarItem> _navBarsItems(
      {required Color activeColorPrimary}) {
    return [
      PersistentBottomNavBarItem(
        iconSize: 24,
        icon: const Icon(
          Icons.home,
        ),
        title: ("Trang chủ"),
        activeColorPrimary: activeColorPrimary,
        inactiveColorPrimary: colorBlueGray03,
      ),
      PersistentBottomNavBarItem(
        iconSize: 24,
        icon: const Icon(
          Icons.home,
        ),
        title: ("Voucher"),
        activeColorPrimary: activeColorPrimary,
        inactiveColorPrimary: colorBlueGray03,
      ),
      PersistentBottomNavBarItem(
        iconSize: 24,
        icon: const Icon(Icons.notifications),
        title: ("Quà tặng"),
        activeColorPrimary: activeColorPrimary,
        inactiveColorPrimary: colorBlueGray03,
      ),
      PersistentBottomNavBarItem(
        iconSize: 24,
        icon: const Icon(Icons.shopify_sharp),
        title: ("Danh mục"),
        activeColorPrimary: activeColorPrimary,
        inactiveColorPrimary: colorBlueGray03,
      ),
      PersistentBottomNavBarItem(
        iconSize: 24,
        icon: const Icon(Icons.person),
        title: ("Tài khoản"),
        activeColorPrimary: activeColorPrimary,
        inactiveColorPrimary: colorBlueGray03,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => bloc,
        ),
      ],
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
          //define color
          Color activeColorPrimary = Theme.of(context).primaryColor;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: screenIndex == 0
                ? _appbarSearch()
                : screenIndex == 1
                    ? AppBar(
                        centerTitle: true,
                        title: Text('Voucher', style: styleTitles),
                      )
                    : screenIndex == 3
                        ? _appbarSearch()
                        : screenIndex == 4
                            ? AppBar(
                                centerTitle: true,
                                title: Text(
                                  'Quản lý tài khoản',
                                  style: textTheme.titleMedium?.copyWith(
                                      color: colorWhite,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : AppBar(
                                centerTitle: true,
                                title: Text('Quà tặng', style: styleTitles),
                              ),
            drawer: DrawerListPage(
              isLogin: state.isLogin,
              name: state.dataUser?.name ?? "",
              url: state.dataUser?.avatar ?? "",
            ),
            body: PersistentTabView(
              //   key: _persistentTabViewKey, // Add the key here

              confineInSafeArea: true,
              context,
              controller: _controller,
              screens: _buildScreens,
              items: _navBarsItems(activeColorPrimary: activeColorPrimary),
              backgroundColor: colorBlueGray01,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              stateManagement: true,
              hideNavigationBarWhenKeyboardShows: true,
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 50),
                curve: Curves.bounceInOut,
              ),
              navBarStyle: NavBarStyle.style6,
              //       hideNavigationBar: state.hideBottomBar,
              selectedTabScreenContext: (context) {
                context = context;
              },
            ),
          );
        }),
      ),
    );
  }

  Widget viewSearch(BuildContext context,
      {required String domain,
      required SearchProductCategoryBloc blocSearchProductCategory,
      required TextEditingController searchController,
      required SearchProductCategoryState stateSearchList}) {
    return searchWidgets.viewSearch(context,
        domain: domain,
        stateSearchList: stateSearchList,
        blocSearchProductCategory: blocSearchProductCategory,
        searchController: searchController);
  }

  PreferredSizeWidget _appbarSearch() {
    return AppBar(
      titleSpacing: 0,
      centerTitle: true,
      title: AppSearchBarV2(
        hintText: 'Tìm kiếm sản phẩm',
        onTap: () {
          Navigator.push(
            context,
            // navigation with animation
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                const begin = Offset(0.8, 0.0);
                const end = Offset.zero;
                const curve = Curves.decelerate;

                var tween = Tween(begin: begin, end: end);
                var curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: curve,
                );

                var offsetAnimation = tween.animate(curvedAnimation);

                return SlideTransition(
                  position: offsetAnimation,
                  child: const SearchScaffold(),
                );
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
          //.then((value) => bloc.onHideBottomBar());
        },
      ),
      actions: <Widget>[
        Consumer<CartProviderV2>(
          builder: (BuildContext context, CartProviderV2 value, Widget? child) {
            return badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 2),
              showBadge: value.getCounter() == 0 ? false : true,
              ignorePointer: false,
              badgeStyle: const badges.BadgeStyle(badgeColor: Colors.yellow),
              badgeContent: Text('${value.counter}'),
              child: IconButton(
                onPressed: () {
                  !bloc.state.isLogin
                      ? routeService.pushNamed(Routes.login,
                          arguments: SignInParams(typeDirec: 1))
                      : routeService.pushNamed(Routes.cartPage,
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
    );
  }
}
