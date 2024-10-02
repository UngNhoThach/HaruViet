import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/attributes_category_response.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/value_attributes.dart';
import 'package:haruviet/database_local/suggestion_data_search/suggestion_data_search_database.dart';
import 'package:flutter/foundation.dart';

import 'filter_product_state.dart';
import 'widgets/filter_product_params.dart';

// FilterProductBloc
class FilterProductBloc extends BaseBloc<FilterProductState> {
  final FilterProductParams params;

  FilterProductBloc({
    required this.params,
  }) : super(const FilterProductState());
  final SuggestionDataSearchDatabase searchDatabase =
      SuggestionDataSearchDatabase();

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final userInfoLogin = await Preference.getUserInfo();
      emit(state.copyWith(
          userInfoLogin: userInfoLogin,
          atributesCategoryData: params.atributesCategoryData,
          filteredCategories: params.filteredCategories));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }

    emit(state.copyWith(
      isLoading: false,
    ));
  }

  void onSelectAttributeValue({
    required AtributesCategoryResponse category,
    required AtributesValue selectedValue,
    required List<AtributesCategoryResponse> allCategories,
  }) {
    // Create a copy of the current categories
    List<AtributesCategoryResponse> updatedCategories = allCategories.map((c) {
      // If this is the category we want to update
      if (c.id == category.id) {
        // Update the values inside this category
        List<AtributesValue> updatedValues = c.values!.map((v) {
          if (v.id == selectedValue.id) {
            // Toggle the isFilter value
            return v.copyWith(isFilter: !(v.isFilter ?? false));
          } else {
            // Ensure all other values in this category have isFilter set to false
            return v.copyWith(isFilter: false);
          }
        }).toList();
        return c.copyWith(values: updatedValues);
      }
      return c;
    }).toList();

    // Find categories with at least one value where isFilter is true
    Map<AtributesCategoryResponse, AtributesValue> filteredCategories = {};
    for (var category in updatedCategories) {
      for (var value in category.values!) {
        if (value.isFilter == true) {
          filteredCategories[category] = value;
          break; // Only need the first matched value
        }
      }
    }
    // Emit the updated state with the modified categories and selected attributes
    emit(
      state.copyWith(
        filteredCategories: filteredCategories,
        //      attributesSelected: filteredCategories,
        atributesCategoryData: updatedCategories,
      ),
    );
  }

  void onResetFilters({
    required List<AtributesCategoryResponse> allCategories,
  }) {
    // Đặt tất cả isFilter của các giá trị trong atributesCategoryData về false
    List<AtributesCategoryResponse> resetCategories = allCategories.map((c) {
      List<AtributesValue> resetValues = c.values!.map((v) {
        return v.copyWith(isFilter: false);
      }).toList();

      return c.copyWith(values: resetValues);
    }).toList();

    // Đặt filteredCategories thành map rỗng
    Map<AtributesCategoryResponse, AtributesValue> resetFilteredCategories = {};

    // Emit trạng thái mới cho Bloc
    emit(
      state.copyWith(
        filteredCategories: {},
        atributesCategoryData: resetCategories,
      ),
    );
  }
}
