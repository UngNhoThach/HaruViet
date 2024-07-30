import 'package:flutter_bloc/flutter_bloc.dart';
import 'orders_tab_state.dart';

class OrdersTabBloc extends Cubit<OrdersTabState> {
  OrdersTabBloc({
    required int tab,
    String? keyword,
    int? parentId,
    Map<int, String>? folderTree,
  }) : super(OrdersTabState(
          tab: tab,
          keyword: keyword,
          parentId: parentId,
          folderTree: folderTree,
        ));

  getData() async {}
}
