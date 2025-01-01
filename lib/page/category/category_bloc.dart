import 'package:haruviet/api/services/products/models/get_list_product_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/category/category_repository.dart';
import 'package:haruviet/data/reponsitory/category/models/list_category_response/data_category.dart';
import 'package:haruviet/database_local/suggestion_data_search/suggestion_data_search_database.dart';
import 'package:flutter/foundation.dart';
import 'package:haruviet/helper/const.dart';

import 'category_state.dart';

// CategoryBloc
class CategoryBloc extends BaseBloc<CategoryState> {
  CategoryBloc() : super(const CategoryState());
  final CategoryRepository _categoryRepository = CategoryRepository();
  final SuggestionDataSearchDatabase searchDatabase =
      SuggestionDataSearchDatabase();
  onChangeFirstTimeLoadinPage(bool firtTimeLoadingPage) {
    emit(state.copyWith(firtTimeLoadingPage: firtTimeLoadingPage));
  }

  bool isINT(double number) {
    return number % 1 == 0;
  }

  bool canLoadMore = false;

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    if (state.firtTimeLoadingPage) {
      try {
        final userInfoLogin = await Preference.getUserInfo();
        emit(state.copyWith(
          userInfoLogin: userInfoLogin,
        ));
        await onFetch(page: startPage);
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
  }

  onFetch({
    required int page,
  }) async {
    try {
      if (page == startPage) {
        emit(
          state.copyWith(
            newListCategory: null,
            canLoadMore: false,
          ),
        );
      }

      final category = await _categoryRepository.getCategoryRP(
          request: GetListProductRequest(
        paegNumber: page,
        language: 'en',
        pageSize: state.limit,
      ));

      var newDataList =
          List<DataCategory>.from(category.parseDataCategory() ?? []);

      final loadingCount = ((category.total ?? 0) / state.limit);
      final maxLoadMore = loadingCount.floor();
      if (isINT(loadingCount)) {
        canLoadMore = page < maxLoadMore;
      } else {
        canLoadMore = page <= maxLoadMore;
        print('error');
      }

      emit(state.copyWith(
        currentPage: page,
        listCategory: newDataList,
        newListCategory: newDataList,
        canLoadMore: false,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }
  }

  onChangeSelecCategories({
    required int selectedCategory,
  }) {
    emit(state.copyWith(selectedCategory: selectedCategory));
  }

  // onchange current tab
  onChangeCurrentTab(CurrentTab currentTab) {
    emit(state.copyWith(currentTab: currentTab));
    getData();
  }
}
