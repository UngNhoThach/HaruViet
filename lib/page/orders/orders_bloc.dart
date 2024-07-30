// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'orders_state.dart';

// class OrdersBloc extends Cubit<DocumentState> {
//   OrdersBloc() : super(const DocumentState());

//   getData({
//     int? parentId,
//     Map<int, String>? folderTree,
//   }) async {
//     emit(state.copyWith(
//       isLoadingStart: true,
//     ));

//     emit(state.copyWith(
//       isLoadingStart: false,
//       parentId: parentId,
//       folderTree: folderTree,
//     ));
//   }

//   onChangeRestoreFolder({
//     required List<int> ids,
//   }) async {
//     try {} catch (error, statckTrace) {
//       if (kDebugMode) {
//         print("$error + $statckTrace");
//       }
//     }
//   }

//   onRemoveEternal({
//     required List<int> ids,
//   }) async {
//     try {} catch (error, statckTrace) {
//       if (kDebugMode) {
//         print("$error + $statckTrace");
//       }
//     }
//   }

//   onChangeTab(int tab) {
//     emit(state.copyWith(
//       tab: tab,
//     ));
//   }
// }
