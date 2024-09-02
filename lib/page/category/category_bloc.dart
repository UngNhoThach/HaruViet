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
      } catch (error, statckTrace) {
        if (kDebugMode) {
          print("$error + $statckTrace");
        }
        emit(state.copyWith(
            viewState: ViewState.error, errorMsg: error.toString()));
      }
    }
    await onFetch(page: startPage);
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onFetch({
    required int page,
  }) async {
    try {
      List<DataCategory> updatedDataList = [];

      if (page == startPage) {
        emit(
          state.copyWith(
            newListCategory: null,
            canLoadMore: false,
            listCategory: updatedDataList,
          ),
        );
      } else {
        updatedDataList = List<DataCategory>.from(state.listCategory ?? []);
      }
      final category = await _categoryRepository.getCategoryRP();

      updatedDataList.addAll(category.parseDataCategory() ?? []);

      final maxLoadMore = ((category.total ?? 0) / state.limit).floor();
      final canLoadMore = page <= maxLoadMore;

      emit(state.copyWith(
        currentPage: page,
        newListCategory: category.parseDataCategory(),
        listCategory: updatedDataList,
        canLoadMore: canLoadMore,
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
