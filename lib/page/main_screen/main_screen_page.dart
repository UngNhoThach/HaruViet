import 'package:flutter/widgets.dart';
import 'package:haruviet/component/input/search_barv2.dart';
import 'package:haruviet/component/popup/popup.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/database_local/product/cart_provider.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/category/category_page.dart';
import 'package:haruviet/page/category/widgets/category_paga_params.dart';
import 'package:haruviet/page/home/home_page.dart';
import 'package:haruviet/page/home/widgets/drawer_list_page.dart';
import 'package:haruviet/page/main_screen/main_screen_state.dart';
import 'package:haruviet/page/notification/notification_page.dart';
import 'package:haruviet/page/profile/profile_page.dart';
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

  late MainScreenBloc bloc;
  String keywordText = '';
  int screenIndex = 0;
  TextStyle? styleTitles = textTheme.titleMedium
      ?.copyWith(color: colorWhite, fontWeight: FontWeight.bold);
  late String domain;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  final List<Widget> _buildScreens = [
    const HomePage(),
    const NotificationTabPage(),
    CategoryPage(
      params: CategoryPageParams(isAppBar: false),
    ),
    const ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: screenIndex);
    _controller.addListener(_onTabChanged);

    domain = context.read<UserBloc>().state.subDomain ?? '';
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
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: screenIndex == 0
                ? _appbarSearch()
                : screenIndex == 1
                    ? AppBar(
                        centerTitle: true,
                        title: Text('Thông báo', style: styleTitles),
                        // title: Text('${widget.cartDatabase.getCount()}',
                        //     style: styleTitles),
                        backgroundColor: colorMain,
                      )
                    : screenIndex == 2
                        ? _appbarSearch()
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
              //       hideNavigationBar: state.hideBottomBar,
              selectedTabScreenContext: (context) {
                context = context;
              },
            ),

            // IndexedStack(
            //   index: screenIndex,
            //   children: _buildScreens,
            // ),
            // bottomNavigationBar: Theme(
            //   data: ThemeData(
            //     splashColor: Colors.transparent,
            //   ),
            //   child: BottomNavigationBar(
            //     showSelectedLabels: true,
            //     selectedFontSize: 12,
            //     type: BottomNavigationBarType.fixed,
            //     selectedItemColor: colorMain,
            //     unselectedItemColor: const Color(0xFFADADAD),
            //     showUnselectedLabels: true,
            //     onTap: (index) {
            //       setState(() {
            //         screenIndex = index;
            //       });
            //     },
            //     currentIndex: screenIndex,
            //     items: [
            //       _bottomNavigationBarItem(
            //         context,
            //         label: 'Trang chủ',
            //         icon: Assets.icons.iconHome.image(),
            //         iconActive: Assets.icons.iconHomeActive.image(),
            //       ),
            //       _bottomNavigationBarItem(
            //         context,
            //         label: 'Lịch sử',
            //         icon: Assets.icons.icNotification.image(),
            //         iconActive: Assets.icons.icNotification.image(),
            //       ),
            //       _bottomNavigationBarItem(
            //         context,
            //         label: 'Cài đặt',
            //         icon: Assets.icons.iconSetting.image(),
            //         iconActive: Assets.icons.iconSettingActive.image(),
            //       ),
            //       _bottomNavigationBarItem(
            //         context,
            //         label: 'Cá nhân',
            //         icon: Assets.icons.icNotification.image(),
            //         iconActive: Assets.icons.icNotification.image(),
            //       )
            //     ],
            //   ),
            // ),
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

  BottomNavigationBarItem _bottomNavigationBarItem(
    BuildContext context, {
    required String label,
    required Widget icon,
    required Widget iconActive,
    String? noti,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: badges.Badge(
        showBadge: noti == null || noti == '' || noti == 'error' ? false : true,
        position: badges.BadgePosition.topEnd(top: -12, end: -14),
        badgeAnimation: const badges.BadgeAnimation.slide(
          disappearanceFadeAnimationDuration: Duration(milliseconds: 100),
          curve: Curves.easeInCubic,
        ),
        ignorePointer: false,
        badgeContent: noti == null
            ? space0
            : Text(
                noti,
                style: const TextStyle(color: Colors.white),
              ),
        child: Column(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: icon,
            ),
            spaceH2,
          ],
        ),
      ),
      activeIcon: badges.Badge(
        position: badges.BadgePosition.topEnd(top: -12, end: -14),
        badgeAnimation: const badges.BadgeAnimation.slide(
          disappearanceFadeAnimationDuration: Duration(milliseconds: 100),
          curve: Curves.easeInCubic,
        ),
        ignorePointer: false,
        showBadge: noti == null || noti == '' || noti == 'error' ? false : true,
        badgeContent: noti == null || noti == '' || noti == 'error'
            ? space0
            : Text(
                noti,
                style: const TextStyle(color: colorWhite),
              ),
        child: Column(
          children: [
            SizedBox(
              width: 20.r,
              height: 20.r,
              child: iconActive,
            ),
            spaceH2,
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appbarSearch() {
    return AppBar(
      centerTitle: true,
      backgroundColor: colorMain,
      title: AppSearchBarV2(
        hintText: 'Tìm kiếm sản phẩm',
        onTap: () {
          Navigator.push(
            context,
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

      // .then((value) =>
      //         WidgetsBinding.instance.focusManager.primaryFocus?.unfocus());
      actions: <Widget>[
        spaceW16,
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
    );
  }
}
