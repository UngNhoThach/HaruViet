import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/brands_repository/brands_repository.dart';
import 'package:haruviet/data/reponsitory/brands_repository/get_top_brands_response/data_top_brand.dart';
import 'package:haruviet/database_local/suggestion_data_search/suggestion_data_search_database.dart';
import 'package:haruviet/helper/const.dart';
import 'package:flutter/foundation.dart';

import 'brands_list_state.dart';

// BrandsListBloc
class BrandsListBloc extends BaseBloc<BrandsListState> {
  BrandsListBloc() : super(const BrandsListState());
  final BrandsRepository _brandRepository = BrandsRepository();
  final SuggestionDataSearchDatabase searchDatabase =
      SuggestionDataSearchDatabase();

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
//    if (state.firtTimeLoadingPage) {
    try {
      emit(state.copyWith());
      await onFetch(page: startPage);
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    } finally {
      emit(state.copyWith(
        isLoading: false,
      ));
    }
    //}
  }

  onReset() {
    onFetch(page: startPage);
  }

  bool isINT(double number) {
    return number % 1 == 0;
  }

  bool canLoadMore = false;

  onFetch({
    required int page,
  }) async {
    // emit(state.copyWith(
    //   isLoading: true,
    // ));
    try {
      // Reset the list if fetching the first page
      //  List<DataTopBrand> updatedDataList = [];
      if (page == startPage) {
        emit(
          state.copyWith(
            newDataList: null,
            canLoadMore: false,
          ),
        );
      }

      final productList = await _brandRepository.getListBrandRP(
        pageNumber: page,
        pageSize: state.limit,
      );

      var newDataList = List<DataTopBrand>.from(productList.data ?? []);

      final maxLoadMore = ((productList.total ?? 0) / state.limit).floor();
      // final canLoadMore = page < maxLoadMore;

      if (isINT(((productList.total ?? 0) / state.limit))) {
        canLoadMore = page < maxLoadMore;
      } else {
        canLoadMore = page <= maxLoadMore;
        print('error');
      }

      emit(state.copyWith(
        newDataList: newDataList,
        currentPage: page,
        canLoadMore: canLoadMore,
      ));
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("$error + $stackTrace");
      }
      emit(state.copyWith(
        viewState: ViewState.error,
        errorMsg: error.toString(),
      ));
    }
    // emit(state.copyWith(
    //   isLoading: false,
    // ));
  }
}
