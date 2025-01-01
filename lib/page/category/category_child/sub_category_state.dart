import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/attributes_category_response.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/value_attributes.dart';
import 'package:haruviet/data/reponsitory/category/models/category_detail_response/category_detail_response.dart';
import 'package:haruviet/data/reponsitory/category/models/category_detail_response/subcategory.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/helper/const.dart';

part 'sub_category_state.g.dart';

@CopyWith()
class SubCategoryState extends BaseState {
  final bool isSubmitSuccess;
  final UserState? userInfoLogin;
  final bool isLoading;
  final bool isLoadingProduct;
  final Map<AtributesCategoryResponse, AtributesValue>? filteredCategories;
  final bool isFilter;
  final bool canLoadMore;
  final int currentPage;
  final List<DataProduct>? newDataList;
  final List<DataProduct> datatList;
  final int limit;
  final CurrentTab currentTab;
  final bool firtTimeLoadingPage;
  final bool checkListNotProduct;
  final String? nameCategory;
  final CategoryDetailResponse? categoryDetailData;
  final List<Subcategory> subcategories;
  final List<AtributesCategoryResponse> atributesCategoryData;
  final List<AtributesCategoryResponse> atributesCategoryDataSave;

  final List<AtributesValue> attributesSelected;
  final Map<String, String> filterValues;
  final Map<String, String> filterValuesName;
  final Map<String, String> filterValuesID;
  final bool hasLoadedRecommendations;
  final bool checkResetFilter;
  final bool checkIsChangeListItem;
  final bool checkFilterProductList;

  const SubCategoryState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.nameCategory,
    this.hasLoadedRecommendations = false,
    this.filteredCategories,
    this.isFilter = false,
    this.checkResetFilter = false,
    this.checkIsChangeListItem = false,
    this.checkFilterProductList = false,
    this.filterValues = const {},
    this.filterValuesName = const {},
    this.filterValuesID = const {},
    this.subcategories = const [],
    this.atributesCategoryData = const [],
    this.atributesCategoryDataSave = const [],
    this.attributesSelected = const [],
    this.categoryDetailData,
    this.firtTimeLoadingPage = true,
    this.checkListNotProduct = false,
    this.currentTab = CurrentTab.latest,
    this.canLoadMore = false,
    this.isLoadingProduct = false,
    this.limit = 12, // perPage,
    this.currentPage = startPage,
    this.isSubmitSuccess = false,
    this.datatList = const [],
    this.newDataList,
    this.isLoading = false,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
