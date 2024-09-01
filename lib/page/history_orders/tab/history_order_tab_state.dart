import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/cart_order_response/data_cart_response.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/cart_order_status_response/data_status_order.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/data_product_detail_response.dart';
import 'package:haruviet/helper/const.dart';

part 'history_order_tab_state.g.dart';

@CopyWith()
class HistoryOrderTabState extends BaseState {
  final int tab;
  final bool isLoadingProductDetails;
  final List<DataCart>? newDataList;
  final List<DataStatusOrder>? listStatusOrder;
  final DataProductDetailResponse? productDetail;
  final int currentPage;
  final int limit;
  final bool canLoadMore;
  final int? status;
  final String? idUser;
  const HistoryOrderTabState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.tab = 1,
    this.newDataList,
    this.idUser,
    this.productDetail,
    this.isLoadingProductDetails = false,
    this.listStatusOrder = const [],
    this.currentPage = startPage,
    this.limit = perPage,
    this.canLoadMore = false,
    this.status,
  }) : super(viewState, errorMsg);
}
