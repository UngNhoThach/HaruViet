import 'dart:async';

import 'package:eco_app/component/select_address/models/select_address_params.dart';
import 'package:eco_app/component/select_address/select_address_page.dart';
import 'package:eco_app/config.dart';
import 'package:eco_app/firebase_options.dart';
import 'package:eco_app/page/about_us/about_us_page.dart';
import 'package:eco_app/page/account/update_profile/widgets/update_profile_params.dart';
import 'package:eco_app/page/add_address/address_page.dart';
import 'package:eco_app/page/cart/cart_page.dart';
import 'package:eco_app/page/cart/models/cart_page_params.dart';
import 'package:eco_app/page/category/category_child/category_child_page.dart';
import 'package:eco_app/page/category/category_page.dart';
import 'package:eco_app/page/category/models/category_paga_params.dart';
import 'package:eco_app/page/chat/chat_page.dart';
import 'package:eco_app/page/cart/checkout/checkout_page.dart';
import 'package:eco_app/page/cart/address_%20receive/address_receive_page.dart';
import 'package:eco_app/page/cart/bill/bill_info_page.dart';
import 'package:eco_app/page/cart/payment_method/payment_method_page.dart';
import 'package:eco_app/page/cart/voucher/voucher_page.dart';
import 'package:eco_app/page/account/forget_password/forget_password_page.dart';
import 'package:eco_app/page/main_screen/main_screen_page.dart';
import 'package:eco_app/page/account/phone_authen/phone_authen_page.dart';
import 'package:eco_app/page/account/phone_authen/widgets/phone_authen_params.dart';
import 'package:eco_app/page/notification/tab/news/widgets/new_detail_page.dart';
import 'package:eco_app/page/product/detail/product_deatail_page.dart';
import 'package:eco_app/page/profile/profile_page.dart';
import 'package:eco_app/page/review/ask_quesition_page/ask_quesition_page.dart';
import 'package:eco_app/page/review/review_page.dart';
import 'package:eco_app/page/review/write_review/write_review_page.dart';
import 'package:eco_app/page/account/signin/signin_page.dart';
import 'package:eco_app/page/account/signin/widgets/signin_params.dart';
import 'package:eco_app/page/account/signup/signup_page.dart';
import 'package:eco_app/page/support/support_page.dart';
import 'package:eco_app/page/account/update_profile/update_profile_page.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/service/navigation_service.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'page/account/reset_password/reset_password_page.dart';
import 'page/account/reset_password/widgets/reset_password_params.dart';
import 'page/cart/checkout/widgets/checkout_params.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

// initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // // variables and fuctions
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // String _connectionStatus = 'Unknown';
  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   switch (result) {
  //     case ConnectivityResult.wifi:
  //     case ConnectivityResult.mobile:
  //     case ConnectivityResult.none:
  //       setState(() => _connectionStatus = result.toString());
  //       break;
  //     default:
  //       setState(() => _connectionStatus = 'Failed to get connectivity.');
  //       break;
  //   }
  // }

  // Future<void> initConnectivity() async {
  //   ConnectivityResult result = ConnectivityResult.none;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //   return _updateConnectionStatus(result);
  // }

  @override
  void initState() {
    super.initState();
    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    // _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          // builder: EasyLoading.init(),
          title: 'HaruViet',
          onGenerateRoute: (settings) => _getRoutes(settings),
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
            fontFamily: "SF PRO",
            colorScheme: myColorScheme,
            textTheme: TextTheme(
              titleLarge: TextStyle(fontSize: 18.r),
              displayLarge: const TextStyle(
                color: Color.fromARGB(255, 36, 48, 86),
              ),
              displayMedium: const TextStyle(
                color: Color.fromARGB(255, 36, 48, 86),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromARGB(255, 36, 48, 86),
              ),
              titleMedium: const TextStyle(
                color: Color.fromARGB(255, 36, 48, 86),
              ),
            ),
          ),
          home: _getRootScreen(context),
        );
      },
      // child: const HomePage(title: 'First Method'),
    );
  }

  Route<dynamic> _getRoutes(RouteSettings settings) {
    //  root
    switch (settings.name) {
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

      // HomePage

      case Routes.homePage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.homePage),
          builder: (_) => const HomePage(),
        );

      case Routes.root:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.root),
          builder: (_) => _getRootScreen(routeService.context),
        );
      // main
      case Routes.main:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.main),
          builder: (_) => const MainScreenPage(),
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
          builder: (_) => const ReviewPage(),
        );
      //writeReviewPage
      case Routes.writeReviewPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.writeReviewPage),
          builder: (_) => const WriteReviewPage(),
        );
      //askQuesitionPage
      case Routes.askQuesitionPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.askQuesitionPage),
          builder: (_) => const AskQuesitonPage(),
        );
      // ChatPage
      case Routes.chatPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.chatPage),
          builder: (_) => const ChatPage(),
        );

      // CartPage
      case Routes.cartPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.cartPage),
          builder: (_) => CartPage(
            params: settings.arguments! as CartPageParams,
          ),
        );
      // CheckOutPage
      case Routes.checkOutPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.checkOutPage),
          builder: (_) => CheckOutPage(
            params: settings.arguments! as CheckoutParams,
          ),
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
          builder: (_) => const PaymentMethodPage(),
        );

      // AddressPage
      case Routes.addressPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addressPage),
          builder: (_) => const AddressPage(),
        );
      // AddressReceivePage
      case Routes.addressReceivePage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addressReceivePage),
          builder: (_) => const AddressReceivePage(),
        );
      // VoucherPage
      case Routes.voucherPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.voucherPage),
          builder: (_) => const VoucherPage(),
        );

      // NewDetailPage
      case Routes.newDetailPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.newDetailPage),
          builder: (_) => const NewDetailPage(),
        );
      // CategoryChildPage
      case Routes.categoryChildPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.categoryChildPage),
          builder: (_) => const CategoryChildPage(),
        );

      // AboutPage
      case Routes.aboutPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.aboutPage),
          builder: (_) => AboutPage(),
        );

      // ProfilePage
      case Routes.profilePage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.profilePage),
          builder: (_) => ProfilePage(
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

      // ProductDetailPage
      case Routes.productDetailPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.productDetailPage),
          builder: (_) => const ProductDetailPage(),
        );

      // forgot password
      case Routes.resetPassWordPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.resetPassWordPage),
          builder: (_) => ResetPassWordPage(
            params: settings.arguments! as ResetPasswordParams,
          ),
        );

      //SupportPage
      case Routes.supportPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.supportPage),
          builder: (_) => const SupportPage(),
        );
      default:
        throw Exception("Route is not defined");
    }
  }

  Widget _getRootScreen(BuildContext context) {
    return const MainScreenPage();
  }
}
