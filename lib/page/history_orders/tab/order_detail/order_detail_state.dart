import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/cart_order_response/details_cart.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/get_order_detail/get_order_detail.dart';
import 'package:haruviet/helper/const.dart';

part 'order_detail_state.g.dart';

@CopyWith()
class OrderDetailState extends BaseState {
  final int tab;
  final bool isLoadingProductDetails;
  final List<DetailsCart>? newDataList;
  final GetOrderDetail? orderDetail;
  final int currentPage;
  final int limit;
  final bool canLoadMore;
  final int? status;
  final String? idUser;
  const OrderDetailState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.tab = 1,
    this.newDataList,
    this.idUser,
    this.orderDetail,
    this.isLoadingProductDetails = false,
    this.currentPage = startPage,
    this.limit = perPage,
    this.canLoadMore = false,
    this.status,
  }) : super(viewState, errorMsg);
}
