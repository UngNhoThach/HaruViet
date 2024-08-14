import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:haruviet/component/select_address/models/select_address_params.dart';
import 'package:haruviet/component/select_address/select_address_page.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/database_local/product/cart_provider.dart';
import 'package:haruviet/helper/theme.dart';
import 'package:haruviet/page/about_us/about_us_page.dart';
import 'package:haruviet/page/account/update_profile/widgets/update_profile_params.dart';
import 'package:haruviet/page/add_address/add_address/add_address_page.dart';
import 'package:haruviet/page/add_address/address_page.dart';
import 'package:haruviet/page/cart/cart_page.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/category/category_child/sub_category_page.dart';
import 'package:haruviet/page/category/category_child/widgets/sub_category_params.dart';
import 'package:haruviet/page/category/category_page.dart';
import 'package:haruviet/page/category/widgets/category_paga_params.dart';
import 'package:haruviet/page/chat/chat_page.dart';
import 'package:haruviet/page/cart/bill/bill_info_page.dart';
import 'package:haruviet/page/cart/payment_method/payment_method_page.dart';
import 'package:haruviet/page/cart/voucher/voucher_page.dart';
import 'package:haruviet/page/account/forget_password/forget_password_page.dart';
import 'package:haruviet/page/main_screen/main_screen_page.dart';
import 'package:haruviet/page/account/phone_authen/phone_authen_page.dart';
import 'package:haruviet/page/account/phone_authen/widgets/phone_authen_params.dart';
import 'package:haruviet/page/notification/tab/news/widgets/new_detail_page.dart';
import 'package:haruviet/page/product/detail/product_deatail_page.dart';
import 'package:haruviet/page/product/detail/widgets/product_detail_params.dart';
import 'package:haruviet/page/product/product_list/product_list_page.dart';
import 'package:haruviet/page/profile/profile_page.dart';
import 'package:haruviet/page/review/ask_quesition_page/ask_quesition_page.dart';
import 'package:haruviet/page/review/review_page.dart';
import 'package:haruviet/page/review/write_review/write_review_page.dart';
import 'package:haruviet/page/account/signin/signin_page.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/account/signup/signup_page.dart';
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
import 'page/product/product_list/widgets/product_list_page_params.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;

  runApp(ChangeNotifierProvider(
      create: (context) => CartProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return BlocProvider<UserBloc>(
      create: (BuildContext context) {
        final bloc = UserBloc();
        bloc.loadData();
        return bloc;
      },
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'HaruViet',
            onGenerateRoute: (settings) => _getRoutes(settings),
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: myThemeData,
            home: _getRootScreen(context),
          );
        },
        // child: const HomePage(title: 'First Method'),
      ),
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
          builder: (_) => const AddressPage(),
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
      case Routes.subCategoryPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.subCategoryPage),
          builder: (_) => SubCategoryPage(
            params: settings.arguments as CategoryParams,
          ),
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

      // OrdersPage
      // case Routes.ordersPage:
      //   return MaterialPageRoute(
      //     settings: const RouteSettings(name: Routes.ordersPage),
      //     builder: (_) => const OrdersPage(),
      //   );

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
    return const MainScreenPage(
        //   cartModel: CartModel(),
        );
  }
}
