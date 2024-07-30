import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/product/models/list_product/data_product/data_product.dart';
import 'package:haruviet/data/reponsitory/product/models/list_product/list_product.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/helper/const.dart';

part 'product_list_state.g.dart';

@CopyWith()
class ProductListState extends BaseState {
  final bool isSubmitSuccess;
  final UserInfoLogin? userInfoLogin;
  final bool isLoading;
  final bool canLoadMore;
  final int currentPage;
  final ListProduct? productList;
  final List<DataProduct>? newDataList;
  final List<DataProduct> datatList;
  final int limit;

  const ProductListState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.productList,
    this.canLoadMore = false,
    this.limit = 12, // perPage,
    this.currentPage = startPage,
    this.isSubmitSuccess = false,
    this.datatList = const [],
    this.newDataList,
    this.isLoading = false,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
