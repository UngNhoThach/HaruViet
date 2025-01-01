import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/reponsitory/category/models/list_category_response/data_category.dart';
import 'package:haruviet/helper/const.dart';

part 'category_state.g.dart';

@CopyWith()
class CategoryState extends BaseState {
  final bool isSubmitSuccess;
  final UserState? userInfoLogin;
  final bool isLoading;
  final bool canLoadMore;
  final int currentPage;
  final int limit;
  final CurrentTab currentTab;
  final List<DataCategory>? listCategory;
  final List<DataCategory>? newListCategory;
  final int selectedCategory;

  final bool firtTimeLoadingPage;
  const CategoryState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.selectedCategory = 0,
    this.firtTimeLoadingPage = true,
    this.listCategory = const [],
    this.newListCategory = const [],
    this.currentTab = CurrentTab.latest,
    this.canLoadMore = false,
    this.limit = 12, // perPage,
    this.currentPage = startPage,
    this.isSubmitSuccess = false,
    this.isLoading = false,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
