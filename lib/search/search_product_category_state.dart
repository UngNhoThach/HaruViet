import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_category.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_product.dart';
import 'package:haruviet/database_local/suggestion_data_search/models/suggestion_data_search_model.dart';

part 'search_product_category_state.g.dart';

@CopyWith()
class SearchProductCategoryState extends BaseState {
  final bool isLoading;
  final List<SearchCategory> categorySearchList;
  final List<SearchProduct> productSearchList;
  final List<SuggestionDataSearchModel> searchDataList;
  final bool checkSearch;
  final bool firtTimeLoadingPage;
  const SearchProductCategoryState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.categorySearchList = const [],
    this.isLoading = false,
    this.checkSearch = false,
    this.productSearchList = const [],
    this.searchDataList = const [],
    this.firtTimeLoadingPage = true,
  }) : super(viewState, errorMsg);
}
