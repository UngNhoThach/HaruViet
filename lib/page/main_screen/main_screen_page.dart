import 'package:haruviet/component/input/search_bar.dart';
import 'package:haruviet/component/popup/popup.dart';
import 'package:haruviet/database_local/product/cart_provider.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/category/category_page.dart';
import 'package:haruviet/page/category/models/category_paga_params.dart';
import 'package:haruviet/page/home/home_page.dart';
import 'package:haruviet/page/home/widgets/drawer_list_page.dart';
import 'package:haruviet/page/main_screen/main_screen_state.dart';
import 'package:haruviet/page/notification/notification_page.dart';
import 'package:haruviet/page/profile/profile_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
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
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  bool isFocused = false;

  late MainScreenBloc bloc;
  late PersistentTabController _controller;
  String keywordText = '';
  int screenIndex = 0;
  TextStyle? styleTitles = textTheme.titleMedium
      ?.copyWith(color: colorWhite, fontWeight: FontWeight.bold);

  void _onFocusChange() {
    setState(() {
      // bloc.onChangeSearch();
      isFocused = focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    _controller.dispose();
    super.dispose();
  }

  final List<Widget> _buildScreens = [
    const HomePage(
        // firstTabBarScrollController: _firstTabBarScrollController,
        // secondTabBarScrollController: _secondTabBarScrollController,
        ),
    const NotificationTabPage(),
    CategoryPage(
      params: CategoryPageParams(isAppBar: false),
    ),
    const ProfilePage()
  ];

  @override
  void initState() {
    focusNode.addListener(_onFocusChange);

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

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   if (index == 0 && _firstTabBarScrollController.hasClients) {
  //     _firstTabBarScrollController.animateTo(
  //       0,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeOut,
  //     );
  //   }

  //   if (index == 0 && _secondTabBarScrollController.hasClients) {
  //     _secondTabBarScrollController.animateTo(
  //       0,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeOut,
  //     );
  //   }
  // }

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
      PersistentBottomNavBarItem(
        iconSize: 24,
        icon: const Icon(Icons.person),
        title: ("Tài khoản"),
        activeColorPrimary: colorMain,
        inactiveColorPrimary: colorBlueGray03,
      ),
    ];
  }

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
            resizeToAvoidBottomInset: false,
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
              confineInSafeArea: true,
              context,
              controller: _controller,
              screens: _buildScreens,
              items: _navBarsItems(),
              backgroundColor: colorBlueGray01,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              hideNavigationBarWhenKeyboardShows: true,
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 50),
                curve: Curves.bounceInOut,
              ),
              navBarStyle: NavBarStyle.style6,
              hideNavigationBar: isFocused,
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
      focusNode: focusNode,
      controller: searchController,
      onChanged: (keyword) {
        setState(() {
          keywordText = keyword;
        });
      },
    );
  }
}
