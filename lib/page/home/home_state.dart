import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/list_product.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/database_local/products_recommendation/models/id_products_recommendation_model.dart';
import 'package:haruviet/database_local/products_recommendation/models/products_recommendation_model.dart';
import 'package:haruviet/helper/const.dart';

part 'home_state.g.dart';

@CopyWith()
class HomeState extends BaseState {
  final bool isSubmitSuccess;
  final UserInfoLogin? userInfoLogin;
  final bool isLoading;
  final bool canLoadMore;
  final int currentPage;
  final ListProduct? productList;
  final List<DataProduct>? newDataList;
  final List<DataProduct> datatList;
  final int limit;
  final List<ProductRecommendationModel> productListLocal;
  final List<IdProductRecommendationModel> idProductListLocal;

  const HomeState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.productListLocal = const [],
    this.idProductListLocal = const [],
    this.productList,
    this.canLoadMore = false,
    this.limit = 8, // perPageHome,
    this.currentPage = startPage,
    this.isSubmitSuccess = false,
    this.datatList = const [],
    this.newDataList,
    this.isLoading = false,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
