import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/brands_repository/get_top_brands_response/data_top_brand.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/database_local/products_recommendation/models/id_products_recommendation_model.dart';
import 'package:haruviet/helper/const.dart';

part 'home_state.g.dart';

@CopyWith()
class HomeState extends BaseState {
  final bool isSubmitSuccess;
  final bool isFirstLoading;
  final List<DataTopBrand?>? listTopBrands;
  final UserState? userInfoLogin;
  final bool isPendingLoading;
  final bool isLoading;
  final bool canLoadMore;
  final bool canLoadMoreProductFlashDeal;
  final int currentPage;
  final int currentPageProductFlashDeal;
  final bool isViewMemberCard;
  final List<DataProduct>? newDataList;
  final bool isLoadingProductsFlashDeal;
  final bool isLoadingBrands;
  final List<DataProduct> datatList;
  final List<DataProduct> newDataListProductFlashDeal;
  final List<DataProduct> datatListProductFlashDeal;
  final int limit;
  final int limitFlashDeal;
  // final List<ProductRecommendationModel> productListLocal;
  final List<IdProductRecommendationModel> idProductListLocal;
  final bool firtTimeLoadingPage;

  const HomeState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    // this.productListLocal = const [],
    this.isFirstLoading = true,
    this.isPendingLoading = false,
    this.canLoadMoreProductFlashDeal = false,
    this.idProductListLocal = const [],
    this.newDataListProductFlashDeal = const [],
    this.datatListProductFlashDeal = const [],
    this.listTopBrands,
    this.firtTimeLoadingPage = true,
    this.canLoadMore = false,
    this.isLoadingProductsFlashDeal = false,
    this.isLoadingBrands = false,
    this.isViewMemberCard = false,
    this.limit = 20, // perPageHome,
    this.limitFlashDeal = 8,
    this.currentPage = startPage,
    this.currentPageProductFlashDeal = startPage,
    this.isSubmitSuccess = false,
    this.datatList = const [],
    this.newDataList,
    this.isLoading = false,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
