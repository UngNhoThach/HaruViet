import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/list_product.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_category.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_product.dart';
import 'package:haruviet/database_local/suggestion_data_search/models/suggestion_data_search_model.dart';
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
  final CurrentTab currentTab;
  final List<SearchCategory> categorySearchList;
  final List<SearchProduct> productSearchList;
  final List<SuggestionDataSearchModel> searchDataList;
  final bool checkSearch;
  final bool firtTimeLoadingPage;
  const ProductListState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.productList,
    this.firtTimeLoadingPage = true,
    this.checkSearch = false,
    this.categorySearchList = const [],
    this.searchDataList = const [],
    this.productSearchList = const [],
    this.currentTab = CurrentTab.all,
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
