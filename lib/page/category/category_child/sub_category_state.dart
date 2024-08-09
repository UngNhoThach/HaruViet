import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/category/models/category_detail_response/category_detail_response.dart';
import 'package:haruviet/data/reponsitory/category/models/category_detail_response/subcategory.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/helper/const.dart';

part 'sub_category_state.g.dart';

@CopyWith()
class SubCategoryState extends BaseState {
  final bool isSubmitSuccess;
  final UserInfoLogin? userInfoLogin;
  final bool isLoading;
  final bool canLoadMore;
  final int currentPage;
  final List<DataProduct>? newDataList;
  final List<DataProduct> datatList;
  final int limit;
  final CurrentTab currentTab;
  final bool firtTimeLoadingPage;
  final CategoryDetailResponse? categoryDetailData;
  final List<Subcategory> subcategories;
  const SubCategoryState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.subcategories = const [],
    this.categoryDetailData,
    this.firtTimeLoadingPage = true,
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
