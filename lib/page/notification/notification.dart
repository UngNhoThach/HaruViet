// import 'package:haruviet/helper/colors.dart';
// import 'package:haruviet/helper/context.dart';
// import 'package:haruviet/page/notification/tab/salary_import_tab.dart';
// import 'package:haruviet/page/notification/tab/salary_import_tab_bloc.dart';
// import 'package:haruviet/theme/typography.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class NotificationPage extends StatefulWidget {
//   const NotificationPage({super.key});

//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage>
//     with TickerProviderStateMixin {
//   late TabController _tabController;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _pageController.dispose();
//     _tabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorWhite,
//       appBar: AppBar(
//         title: const Text('Phiếu lương tháng'),
//       ),
//       body: Column(children: [
//         _tabBar(context),
//         Expanded(
//           child: ColoredBox(
//             color: const Color(0xFFECECEE),
//             child: PageView.builder(
//               controller: _pageController,
//               onPageChanged: (value) {
//                 setState(() {
//                   _tabController.index = value;
//                 });
//               },
//               itemCount: _tabController.length,
//               itemBuilder: (c, i) {
//                 return BlocProvider(
//                   create: (context) => NotificationTabBloc(
//                     currentTab: i,
//                   ),
//                   child: const NotificationTabPage(),
//                 );
//               },
//             ),
//           ),
//         ),
//       ]),
//     );
//   }

//   Widget _tabBar(
//     BuildContext context,
//   ) {
//     return TabBar(
//       onTap: (value) async {
//         _pageController.jumpToPage(value);
//       },
//       controller: _tabController,
//       indicator: UnderlineTabIndicator(
//         borderSide: BorderSide(
//           width: 2,
//           color: context.appColor.colorBlue,
//         ),
//       ),
//       tabs: [
//         Tab(
//           child: Text(
//             'Tin tức',
//             style: textTheme.bodyMedium?.copyWith(
//               color: _tabController.index == 1
//                   ? context.appColorScheme.colorIconInactive
//                   : context.appColorScheme.colorExtendedTextFieldCursor,
//             ),
//           ),
//         ),
//         Tab(
//           child: Text(
//             'Thông báo',
//             style: textTheme.bodyMedium?.copyWith(
//               color: _tabController.index == 1
//                   ? context.appColorScheme.colorExtendedTextFieldCursor
//                   : context.appColorScheme.colorIconInactive,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
