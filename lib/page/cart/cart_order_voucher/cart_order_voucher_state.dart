import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_product.dart';
import 'package:haruviet/database_local/suggestion_data_search/models/suggestion_data_search_model.dart';
part 'cart_order_voucher_state.g.dart';

@CopyWith()
class CartOrderVoucherState extends BaseState {
  final bool isVoucherSelected;
  final bool isLoading;
  final int totalPrice;
  final int discountAmount;
  final String? codeSelected;
  final SearchProduct? voucherSelected;
  final List<SearchProduct> productSearchList;
  final List<SuggestionDataSearchModel> searchDataList;
  final bool firtTimeLoadingPage;
  final bool checkSearch;
  const CartOrderVoucherState({
    ViewState viewState = ViewState.loaded,
    this.isLoading = false,
    this.totalPrice = 0,
    this.codeSelected,
    this.discountAmount = 0,
    this.isVoucherSelected = false,
    this.voucherSelected,
    this.checkSearch = false,
    this.productSearchList = const [],
    this.searchDataList = const [],
    this.firtTimeLoadingPage = true,
    String errorMsg = '',
  }) : super(viewState, errorMsg);
}
