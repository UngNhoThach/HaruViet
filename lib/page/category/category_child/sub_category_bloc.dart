import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/category/category_repository.dart';
import 'package:haruviet/data/reponsitory/category/models/category_detail_response/subcategory.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/database_local/suggestion_data_search/suggestion_data_search_database.dart';
import 'package:haruviet/page/category/category_child/sub_category_state.dart';
import 'package:flutter/foundation.dart';

// SubCategoryBloc
class SubCategoryBloc extends BaseBloc<SubCategoryState> {
  final String idCategory;
  SubCategoryBloc({required this.idCategory}) : super(const SubCategoryState());
  final CategoryRepository _categoryRepository = CategoryRepository();
  final SuggestionDataSearchDatabase searchDatabase =
      SuggestionDataSearchDatabase();

  onChangeFirstTimeLoadinPage(bool firtTimeLoadingPage) {
    emit(state.copyWith(firtTimeLoadingPage: firtTimeLoadingPage));
  }

  getData({String? idCategorySub}) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    if (state.firtTimeLoadingPage) {
      try {
        List<Subcategory> subcategories = [];
        final List<DataProduct> datatList = [];

        final categoryDetailData = await _categoryRepository.getListProductsRP(
            idCategory: idCategorySub ?? idCategory);

        subcategories.addAll(categoryDetailData.category?.subcategories ?? []);
        datatList.addAll(categoryDetailData.products?.data ?? []);
        final userInfoLogin = await Preference.getUserInfo();

        emit(state.copyWith(
          subcategories: subcategories,
          datatList: datatList,
          userInfoLogin: userInfoLogin,
        ));
      } catch (error, statckTrace) {
        if (kDebugMode) {
          print("$error + $statckTrace");
        }
        emit(state.copyWith(
            viewState: ViewState.error, errorMsg: error.toString()));
      }
    }
    emit(state.copyWith(
      isLoading: false,
    ));
    // onFetch(page: startPage);
  }

  // onReset() {
  //   onFetch(page: startPage);
  // }

  // onFetch({
  //   required int page,
  // }) async {
  //   try {
  //     emit(state.copyWith(
  //       isLoading: true,
  //     ));

  //     // Reset the list if fetching the first page
  //     List<DataProduct> updatedDataList = [];
  //     if (page == startPage) {
  //       emit(
  //         state.copyWith(
  //           newDataList: null,
  //           canLoadMore: false,
  //           datatList: updatedDataList,
  //         ),
  //       );
  //     } else {
  //       // Keep the existing list if not fetching the first page
  //       updatedDataList = List<DataProduct>.from(state.datatList);
  //     }

  //     final categoryDetailData =
  //         await _categoryRepository.getListProductsRP(idCategory: idCategory);

  //     updatedDataList.addAll(categoryDetailData.data ?? []);

  //     final maxLoadMore = ((productList.total ?? 0) / state.limit).floor();
  //     final canLoadMore = page <= maxLoadMore;

  //     emit(state.copyWith(
  //       datatList: updatedDataList,
  //       newDataList: updatedDataList,
  //       currentPage: page,
  //       canLoadMore: canLoadMore,
  //     ));

  //     emit(state.copyWith(
  //       isLoading: false,
  //     ));
  //     onChangeFirstTimeLoadinPage(false);
  //   } catch (error, stackTrace) {
  //     if (kDebugMode) {
  //       print("$error + $stackTrace");
  //     }
  //     emit(state.copyWith(
  //       viewState: ViewState.error,
  //       errorMsg: error.toString(),
  //     ));
  //   }
  // }

  // onchange current tab
  onChangeCurrentTab(CurrentTab currentTab) {
    emit(state.copyWith(currentTab: currentTab));
    getData();
  }
}
