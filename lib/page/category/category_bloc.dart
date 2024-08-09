import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/database_local/suggestion_data_search/suggestion_data_search_database.dart';
import 'package:flutter/foundation.dart';

import 'category_state.dart';

// CategoryBloc
class CategoryBloc extends BaseBloc<CategoryState> {
  CategoryBloc() : super(const CategoryState());
  final ProductRepository _productRepository = ProductRepository();
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
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  // onchange current tab
  onChangeCurrentTab(CurrentTab currentTab) {
    emit(state.copyWith(currentTab: currentTab));
    getData();
  }
}
