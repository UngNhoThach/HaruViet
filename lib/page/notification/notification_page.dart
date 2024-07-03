import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/page/notification/tab/news/discount_page.dart';
import 'package:eco_app/page/notification/tab/notification/history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationTabPage extends StatefulWidget {
  const NotificationTabPage({Key? key}) : super(key: key);

  @override
  State<NotificationTabPage> createState() => _NotificationTabPageState();
}

class _NotificationTabPageState extends State<NotificationTabPage>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  late TabController tabController;

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar:
      // AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     'Thông báo',
      //     style: textTheme.titleMedium
      //         ?.copyWith(color: colorWhite, fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: colorMain,
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TabBar(
                controller: tabController,
                tabs: const [
                  Tab(
                    text: 'Tin tức',
                  ),
                  Tab(
                    text: 'Thông báo',
                  ),
                ],
                labelColor: colorBlack,
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    DiscountPage(),
                    HistoryPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
