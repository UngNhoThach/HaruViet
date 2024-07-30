// import 'dart:io';
// import 'package:haruviet/helper/colors.dart';
// import 'package:haruviet/helper/context.dart';
// import 'package:haruviet/helper/spaces.dart';
// import 'package:haruviet/theme/typography.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'orders_bloc.dart';
// import 'orders_state.dart';
// import 'package:path/path.dart' as Path;

// class OrdersPage extends StatefulWidget {
//   const OrdersPage({
//     super.key,
//   });

//   @override
//   State<OrdersPage> createState() => _OrdersPageState();
// }

// class _OrdersPageState extends State<OrdersPage> with TickerProviderStateMixin {
//   late OrdersBloc bloc;
//   late TabController _tabController;
//   late PageController _pageController;

//   String keyword = '';

//   @override
//   void initState() {
//     super.initState();
//     bloc = OrdersBloc()..getData();
//     _tabController = TabController(length: 4, vsync: this);
//     _pageController = PageController();
//   }

//   @override
//   void dispose() async {
//     super.dispose();
//     final folderTree = bloc.state.folderTree;

//     folderTree?.remove(bloc.state.parentId);

//     _pageController.dispose();
//     _tabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => bloc,
//       child: MultiBlocListener(
//         listeners: [
//           BlocListener<OrdersBloc, OrdersState>(
//             listenWhen: (previous, current) =>
//                 previous.countChecked != current.countChecked ||
//                 previous.isUnselected != current.isUnselected,
//             listener: (context, state) {
//               if (state.isUnselected) {
//                 context.read<OrdersBloc>();
//               }
//             },
//           ),
//           BlocListener<OrdersBloc, OrdersState>(
//             listenWhen: (previous, current) =>
//                 previous.isUploadFile != current.isUploadFile,
//             listener: (context, state) {},
//           ),
//         ],
//         child: BlocBuilder<OrdersBloc, OrdersState>(
//           builder: (context, state) {
//             return Scaffold(
//                 backgroundColor: colorWhite,
//                 appBar: state.countChecked != 0
//                     ? AppBar(
//                         elevation: 0,
//                         leading: Padding(
//                           padding: const EdgeInsets.only(
//                             left: 20,
//                           ),
//                           child: GestureDetector(
//                             onTap: () {},
//                             child: const Icon(
//                               Icons.close,
//                             ),
//                           ),
//                         ),
//                         actions: [
//                           spaceW12,
//                           GestureDetector(
//                             onTap: () {
//                               PopupSelectedDocument.show(
//                                 onTapDeleteEternal: () async {
//                                   await bloc.onRemoveEternal(ids: state.ids);
//                                 },
//                                 isTabRestoreFolder:
//                                     _tabController.index == 3 ? true : false,
//                                 onTapRestoreFolder: () async {
//                                   await bloc.onChangeRestoreFolder(
//                                       ids: state.ids);
//                                 },
//                                 context,
//                                 onTapDelete: () async {},
//                               );
//                             },
//                             child: const Icon(
//                               Icons.more_vert_outlined,
//                             ),
//                           ),
//                           spaceW10,
//                         ],
//                         title: Text(
//                           '${state.countChecked} mục đang chọn',
//                           style: const TextStyle(fontWeight: FontWeight.w600),
//                         ))
//                     : AppBar(
//                         backgroundColor: colorWhite,
//                         elevation: 0,
//                         leading: const Padding(
//                           padding: EdgeInsets.only(
//                             left: 23,
//                           ),
//                           child: BackButton(color: colorBlack),
//                         ),
//                         title: state.isCheck
//                             ? Padding(
//                                 padding: const EdgeInsets.only(
//                                   right: 14,
//                                 ),
//                                 child: _buildSearchField(),
//                               )
//                             : null,
//                       ),

//                 // state.data

//                 body:
//                     // state.isCheck
//                     //   ?
//                     Column(children: [
//                   if (state.folderTree != null) ...[
//                     Container(
//                       color: colorWhite,
//                       child: spaceH10,
//                     ),
//                     Container(
//                       width: 1.sw,
//                       color: colorBackgroundWhite,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Wrap(
//                             spacing: 4,
//                             runSpacing: 12,
//                             children: state.folderTree!.entries
//                                 .toList()
//                                 .map((e) => Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         if (e.key ==
//                                             state.folderTree!.entries.first
//                                                 .key) ...[
//                                           spaceW16,
//                                         ] else ...[
//                                           Icon(
//                                             Icons.arrow_forward_ios_rounded,
//                                             color: context.appColorScheme
//                                                 .colorExtendedTextBodySmall,
//                                             size: 12,
//                                           ),
//                                           spaceW4,
//                                         ],
//                                         Text(
//                                           e.value,
//                                           style: textTheme.bodySmall?.copyWith(
//                                             color: context.appColorScheme
//                                                 .colorExtendedTextBodySmall,
//                                           ),
//                                         ),
//                                       ],
//                                     ))
//                                 .toList(),
//                           ),
//                         ],
//                       ),
//                     )
//                   ] else ...[
//                     state.countChecked != 0 ? space0 : _tabBar(context),
//                   ],
//                   Expanded(
//                     child: ColoredBox(
//                       color: const Color(0xFFECECEE),
//                       child: state.isLoading
//                           ? const Loading()
//                           : PageView.builder(
//                               controller: _pageController,
//                               onPageChanged: (value) {
//                                 setState(() {
//                                   _tabController.index = value;
//                                 });
//                                 bloc.onChangeTab(value + 1);
//                               },
//                               itemCount: _tabController.length,
//                               itemBuilder: (c, i) {
//                                 return BlocProvider(
//                                   key: ObjectKey(state.onReload),
//                                   create: (context) => OrdersBloc(
//                                     tab: i,
//                                     keyword: keyword,
//                                     parentId: state.parentId,
//                                     folderTree: state.folderTree,
//                                   ),
//                                   child: DocumentTab(
//                                     isTabDelete: _tabController.index == 3
//                                         ? true
//                                         : false,
//                                     locationName: _tabController.index == 0
//                                         ? 'Tất cả'
//                                         : _tabController.index == 1
//                                             ? "Tài liệu của tôi"
//                                             : _tabController.index == 2
//                                                 ? "Chia sẻ"
//                                                 : "Thùng rác",
//                                     onReload: () {
//                                       bloc.getData();
//                                     },
//                                   ),
//                                 );
//                               },
//                             ),
//                     ),
//                   ),
//                 ])
//                 // : const NotActivePage(
//                 //     isAppBar: false,
//                 //   ),
//                 );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _tabBar(
//     BuildContext context,
//   ) {
//     return TabBar(
//       onTap: (value) async {
//         _pageController.jumpToPage(value);
//         bloc.onChangeTab(value);
//       },
//       controller: _tabController,
//       indicator: UnderlineTabIndicator(
//         borderSide: BorderSide(
//           width: 2,
//           color: context.colorScheme.primary,
//         ),
//       ),
//       tabs: [
//         Tab(
//           child: Text(
//             'Tất cả',
//             style: textTheme.bodyMedium?.copyWith(
//               color: _tabController.index == 0
//                   ? context.appColorScheme.colorExtendedTextFieldCursor
//                   : context.appColorScheme.colorIconInactive,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Tab(
//           child: Text(
//             'Tài liệu\ncủa tôi',
//             style: textTheme.bodyMedium?.copyWith(
//               color: _tabController.index == 1
//                   ? context.appColorScheme.colorExtendedTextFieldCursor
//                   : context.appColorScheme.colorIconInactive,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Tab(
//           child: Text(
//             'Chia sẻ',
//             style: textTheme.bodyMedium?.copyWith(
//               color: _tabController.index == 2
//                   ? context.appColorScheme.colorExtendedTextFieldCursor
//                   : context.appColorScheme.colorIconInactive,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Tab(
//           child: Text(
//             'Thùng rác',
//             style: textTheme.bodyMedium?.copyWith(
//               color: _tabController.index == 3
//                   ? context.appColorScheme.colorExtendedTextFieldCursor
//                   : context.appColorScheme.colorIconInactive,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSearchField() {
//     return AppSearchBarV2(
//       hintText: 'Tìm tài liệu',
//       onChanged: (value) {
//         setState(() {
//           keyword = value;
//         });
//         bloc.onChangeReload();
//       },
//     );
//   }
// }
