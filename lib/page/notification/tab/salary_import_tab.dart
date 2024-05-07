// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'salary_import_tab_bloc.dart';
// import 'salary_import_tab_state.dart';

// class NotificationTabPage extends StatefulWidget {
//   const NotificationTabPage({super.key});

//   @override
//   State<NotificationTabPage> createState() => _NotificationTabState();
// }

// class _NotificationTabState extends State<NotificationTabPage>
//     with AutomaticKeepAliveClientMixin {
//   late NotificationTabBloc bloc;
//   final PagingController<int, SalaryImportResponse> _pagingController =
//       PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pagingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return BlocProvider(
//       create: (context) => bloc,
//       child: BlocListener<NotificationTabBloc, NotificationTabState>(
//         listenWhen: (previous, current) =>
//             previous.newDatatList != current.newDatatList,
//         listener: (context, state) {
//           if (state.currentPage == startPage) {
//             _pagingController.refresh();
//           }
//           if (state.canLoadMore) {
//             _pagingController.appendPage(
//               state.newDatatList ?? [],
//               state.currentPage + 1,
//             );
//           } else {
//             _pagingController.appendLastPage(state.newDatatList ?? []);
//           }
//         },
//         child: BlocBuilder<NotificationTabBloc, NotificationTabState>(
//           builder: (context, state) {
//             return RefreshIndicator(
//                 onRefresh: () async {
//                   bloc.onReset();
//                 },
//                 child: Column(
//                   children: [
//                     state.newDatatList == null
//                         ? _shimmer(context)
//                         : Expanded(
//                             child: PagedListView.separated(
//                               // itemExtent: 9999,
//                               // cacheExtent: 9999,
//                               // key: PageStorageKey(widget.key),
//                               keyboardDismissBehavior:
//                                   ScrollViewKeyboardDismissBehavior.onDrag,
//                               pagingController: _pagingController,
//                               shrinkWrap: true,
//                               physics: const ClampingScrollPhysics(),
//                               padding:
//                                   EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 72.h),
//                               builderDelegate: PagedChildBuilderDelegate<
//                                   SalaryImportResponse>(
//                                 noItemsFoundIndicatorBuilder: _empty,
//                                 itemBuilder: (context, item, index) {
//                                   return _item(context, data: item);
//                                 },
//                               ),
//                               separatorBuilder: (context, index) => spaceH12,
//                             ),
//                           ),
//                   ],
//                 ));
//           },
//         ),
//       ),
//     );
//   }

//   Widget _item(
//     BuildContext context, {
//     required SalaryImportResponse data,
//   }) {
//     if ((data.attach ?? '').isEmpty) {
//       return space0;
//     }
//     return ViewFile(
//       icon: SizedBox(
//         width: 60,
//         height: 60,
//         child: Center(
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const FaIcon(FontAwesomeIcons.filePdf,
//                 color: Colors.red, size: 40),
//           ),
//         ),
//       ),
//       widget: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             data.fullName ?? '',
//             style: textTheme.bodyMedium?.copyWith(
//               color: context.appColorScheme.colorExtendedTextBodyMedium,
//             ),
//           ),
//           spaceH4,
//           Text(
//             'Tháng ${data.month} / ${data.year}',
//             style: textTheme.bodySmall?.copyWith(
//               color: context.appColorScheme.colorExtendedTextBodySmall,
//             ),
//           ),
//         ],
//       ),
//       url: data.attach ?? '',
//     );
//   }

//   Widget _shimmer(BuildContext context) {
//     return Expanded(
//       child: ListView.separated(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 72.h),
//         itemBuilder: (context, index) => ShimmerEffect(
//           child: Container(
//             height: 100.h,
//             decoration: BoxDecoration(
//               color: context.appColor.colorWhite,
//               borderRadius: BorderRadius.circular(16.0),
//             ),
//           ),
//         ),
//         separatorBuilder: (context, index) => spaceH12,
//         itemCount: 10,
//       ),
//     );
//   }

//   Widget _empty(BuildContext context) {
//     return const DidntFound();
//   }

//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }
