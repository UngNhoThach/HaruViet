import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:haruviet/component/select_address/models/select_address_params.dart';
import 'package:haruviet/component/select_address/select_address_page.dart';
import 'package:haruviet/connection.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/setting/setting_repository.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/firebase_api.dart';
import 'package:haruviet/firebase_options.dart';
import 'package:haruviet/page/view_data_web/view_data_web_page.dart';
import 'package:haruviet/page/view_data_web/widgets/view_data_web_params.dart';
import 'package:haruviet/theme/theme.dart';
import 'package:haruviet/page/account/update_profile/widgets/update_profile_params.dart';
import 'package:haruviet/page/add_address/add_address/add_address_page.dart';
import 'package:haruviet/page/add_address/address_page.dart';
import 'package:haruviet/page/cart/cart_page.dart';
import 'package:haruviet/page/cart/checkout/widgets/checkout_params.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/category/category_child/sub_category_page.dart';
import 'package:haruviet/page/category/category_child/widgets/sub_category_params.dart';
import 'package:haruviet/page/category/category_page.dart';
import 'package:haruviet/page/category/widgets/category_paga_params.dart';
import 'package:haruviet/page/chat/chat_page.dart';
import 'package:haruviet/page/cart/bill/bill_info_page.dart';
import 'package:haruviet/page/cart/payment_method/payment_method_page.dart';
import 'package:haruviet/page/account/forget_password/forget_password_page.dart';
import 'package:haruviet/page/history_orders/history_order_page.dart';
import 'package:haruviet/page/history_orders/tab/history_order_tab.dart';
import 'package:haruviet/page/history_orders/tab/widgets/history_order_tab_params.dart';
import 'package:haruviet/page/history_orders/widget/history_order_params.dart';
import 'package:haruviet/page/cart/checkout/checkout_page.dart';
import 'package:haruviet/page/main_screen/main_screen_page.dart';
import 'package:haruviet/page/account/phone_authen/phone_authen_page.dart';
import 'package:haruviet/page/account/phone_authen/widgets/phone_authen_params.dart';
import 'package:haruviet/page/notification/tab/news/widgets/new_detail_page.dart';
import 'package:haruviet/page/product/detail/product_deatail_page.dart';
import 'package:haruviet/page/product/detail/widgets/product_detail_params.dart';
import 'package:haruviet/page/product/product_list/product_list_page.dart';
import 'package:haruviet/page/profile/profile_page.dart';
import 'package:haruviet/page/review/review_page.dart';
import 'package:haruviet/page/review/write_review/widgets/write_review_params.dart';
import 'package:haruviet/page/review/write_review/write_review_page.dart';
import 'package:haruviet/page/account/signin/signin_page.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/account/signup/signup_page.dart';
import 'package:haruviet/page/shipment/shipment_page.dart';
import 'package:haruviet/page/shipment/widgets/shipment_params.dart';
import 'package:haruviet/page/support/support_page.dart';
import 'package:haruviet/page/account/update_profile/update_profile_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/service/navigation_service.dart';
import 'package:haruviet/utils/commons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'page/account/reset_password/reset_password_page.dart';
import 'page/account/reset_password/widgets/reset_password_params.dart';
import 'page/add_address/add_address/widgets/add_address_params.dart';
import 'page/add_address/add_address/widgets/address_params.dart';
import 'page/cart/payment_method/widgets/payment_method_params.dart';
import 'page/history_orders/tab/order_detail/order_detail_page.dart';
import 'page/history_orders/tab/widgets/order_detail_params.dart';
import 'page/product/product_list/widgets/product_list_page_params.dart';

Future<void> main() async {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // fetch data default
  await _fetchDataDefault();

  // check connection
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  // set for debug
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  // splash screen
  //  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize the SettingAppBloc and call loadData
  final SettingAppBloc bloc = SettingAppBloc();
  await bloc.loadData(); // Ensure the data is loaded before running the app
  // await Future.delayed(const Duration(microseconds: 5000));

  runApp(
    BlocProvider<SettingAppBloc>(
      create: (context) => bloc,
      child: ChangeNotifierProvider(
        create: (context) => CartProviderV2(),
        child: const HaruViet(),
      ),
    ),
  );

  FlutterNativeSplash.remove();
  // end splash screen
}

// fetch data default
Future<void> _fetchDataDefault() async {
  // setting default
  final SettingRepository settingRepository = SettingRepository();
  final getAppDefaultRP = await settingRepository.fetchAndStoreSettings();
  await Preference.setAppConfig(getAppDefaultRP);
  print("Fetching data from API...");
}

class HaruViet extends StatefulWidget {
  const HaruViet({super.key});

  @override
  State<HaruViet> createState() => _HaruVietState();
}

class _HaruVietState extends State<HaruViet> {
  @override
  void initState() {
    super.initState();
    print("Data fetched successfully!");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design,
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'HaruViet',
          initialRoute: Routes.root,
          onGenerateRoute: (settings) => _getRoutes(settings),
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: myThemeData,
          home: _getRootScreen(context),
        );
      },
    );
  }

  Route<dynamic> _getRoutes(RouteSettings settings) {
    //  root
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.root),
          builder: (_) => _getRootScreen(routeService.context),
        );
      // settings
      case Routes.selectAddress:
        assert(
          settings.arguments != null &&
              settings.arguments is SelectAddressParams,
        );
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.selectAddress),
          builder: (_) => SelectAddressPage(
            params: settings.arguments! as SelectAddressParams,
          ),
        );

      // main
      case Routes.main:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.main),
          builder: (_) => const MainScreenPage(
              // cartModel: CartModel(),
              ),
        );

      case Routes.login:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.login),
          builder: (_) => SignInPage(
            params: settings.arguments as SignInParams,
          ),
        );
      case Routes.register:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.register),
          builder: (_) => const SignUpPage(),
        );

      // PhoneAuthPage
      case Routes.phoneAuthPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.phoneAuthPage),
          builder: (_) => PhoneAuthPage(
            params: settings.arguments as PhoneAuthParams,
          ),
        );

      // CategoryPage
      case Routes.categoryPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.categoryPage),
          builder: (_) => CategoryPage(
            params: settings.arguments! as CategoryPageParams,
          ),
        );

      //UpdateProfilePage
      case Routes.updateProfile:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.updateProfile),
          builder: (_) => UpdateProfilePage(
            params: settings.arguments! as UpdateProfileParams,
          ),
        );
      // ReviewPage
      case Routes.reviewPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.reviewPage),
          builder: (_) => ReviewPage(
            params: settings.arguments! as WriteReviewParams,
          ),
        );
      //writeReviewPage
      case Routes.writeReviewPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.writeReviewPage),
          builder: (_) => WriteReviewPage(
            params: settings.arguments as WriteReviewParams,
          ),
        );

      //askQuesitionPage
      // case Routes.askQuesitionPage:
      //   return MaterialPageRoute(
      //     settings: const RouteSettings(name: Routes.askQuesitionPage),
      //     builder: (_) => const AskQuesitonPage(),
      //   );
      // ChatPage
      case Routes.chatPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.chatPage),
          builder: (_) => const ChatPage(),
        );

      //billInfoPage
      case Routes.billInfoPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.billInfoPage),
          builder: (_) => const BillInfoPage(),
        );

      //PaymentMethodPage
      case Routes.paymentMethodPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.paymentMethodPage),
          builder: (_) => PaymentMethodPage(
            params: settings.arguments! as PaymentMethodParams,
          ),
        );

      // AddressPagex
      case Routes.addnewaddressPage:
        assert(
          settings.arguments != null &&
              settings.arguments is AddNewAddressParams,
        );
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addnewaddressPage),
          builder: (_) => AddNewAddressPage(
            params: settings.arguments! as AddNewAddressParams,
          ),
        );
      // AddressReceivePage
      case Routes.addressPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addressPage),
          builder: (_) => AddressPage(
            params: settings.arguments! as AddressParams,
          ),
        );

      // NewDetailPage
      case Routes.newDetailPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.newDetailPage),
          builder: (_) => const NewDetailPage(),
        );
      // CategoryChildPage
      case Routes.subCategoryPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.subCategoryPage),
          builder: (_) => SubCategoryPage(
            params: settings.arguments as CategoryParams,
          ),
        );

      // AboutPage
      case Routes.viewDataWeb:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.viewDataWeb),
          builder: (_) => ViewDataWebPage(
            params: settings.arguments! as ViewDataWebPageParams,
          ),
        );

      // ProfilePage
      case Routes.profilePage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.profilePage),
          builder: (_) => const ProfilePage(
              // params: settings.arguments! as ProfileParams,
              ),
        );

      // historyPaymentPage
      case Routes.historyPaymentPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.historyPaymentPage),
          builder: (_) => const ProfilePage(),
        );

      // ForgetPassWordPage
      case Routes.forgetPassWordPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.forgetPassWordPage),
          builder: (_) => const ForgetPassWordPage(),
        );

      // PRODUCT
      case Routes.productDetailPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.productDetailPage),
          builder: (_) => ProductDetailPage(
            params: settings.arguments as ProductDetailParams,
          ),
        );
      case Routes.productListPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.productListPage),
          builder: (_) => ProductListPage(
            params: settings.arguments as ProductListPageParams,
          ),
        );

      // forgot password
      case Routes.resetPassWordPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.resetPassWordPage),
          builder: (_) => ResetPassWordPage(
            params: settings.arguments! as ResetPasswordParams,
          ),
        );

      // CART
      case Routes.cartPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.cartPage),
          builder: (_) => CartPage(
            params: settings.arguments! as CartPageParams,
          ),
        );

      // check out
      case Routes.orderDetailPage:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.orderDetailPage),
            builder: (_) => OrderDetailPage(
                params: settings.arguments! as OrderDetailParams));

      case Routes.checkOutPage:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.checkOutPage),
            builder: (_) =>
                CheckOutPage(params: settings.arguments! as CheckoutParams));

      case Routes.historyOrderTab:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.historyOrderTab),
          builder: (_) => HistoryOrderTab(
            params: settings.arguments! as HistoryOrderTabParams,
          ),
        );

      case Routes.historyOrderPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.historyOrderPage),
          builder: (_) => HistoryOrderPage(
            params: settings.arguments! as HistoryOrderParams,
          ),
        );

      case Routes.shipmentPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.shipmentPage),
          builder: (_) => ShipmentPage(
            params: settings.arguments! as ShipmentParams,
          ),
        );

      //SupportPage
      case Routes.supportPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.supportPage),
          builder: (_) => const SupportPage(),
        );

      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.root),
          builder: (_) => _getRootScreen(routeService.context),
        );
    }
  }

  Widget _getRootScreen(BuildContext context) {
    return const MainScreenPage();
  }
}
