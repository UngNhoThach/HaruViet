import 'package:haruviet/api/services/products/models/get_list_product_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/help_basic/help_basic.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/database_local/products_recommendation/id_product_recommendation_database.dart';
import 'package:haruviet/database_local/products_recommendation/models/id_products_recommendation_model.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/page/home/home_state.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

// HomeBloc
class HomeBloc extends BaseBloc<HomeState> {
  HomeBloc() : super(const HomeState());
  final ProductRepository _productRepository = ProductRepository();
  final help = HelpBasic();

  removeZeroDouble({required double value}) {
    return help.formatDouble(value);
  }

  onChangeFirstTimeLoadinPage(bool firtTimeLoadingPage) {
    emit(state.copyWith(firtTimeLoadingPage: firtTimeLoadingPage));
  }

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final dbHelper = IdProductRecommendationDatabase();

      final List<IdProductRecommendationModel> idProductListLocal;

      idProductListLocal = await dbHelper.getAllProducts();

      final userInfoLogin = await Preference.getUserInfo();

      emit(state.copyWith(
        idProductListLocal: idProductListLocal,
        userInfoLogin: userInfoLogin,
      ));
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
    try {
      if (page == startPage) {
        emit(
          state.copyWith(
            newDataList: null,
            canLoadMore: false,
          ),
        );
      }

      final productList = await _productRepository.getListProductsRP(
        request: GetListProductRequest(paegNumber: page, pageSize: state.limit),
      );

      var newDataList = List<DataProduct>.from(productList.data ?? []);

      final loadingCount = ((productList.total ?? 0) / state.limit);
      final maxLoadMore = loadingCount.floor();
      if (isINT(loadingCount)) {
        canLoadMore = page < maxLoadMore;
      } else {
        canLoadMore = page <= maxLoadMore;
        print('error');
      }
      emit(state.copyWith(
        productList: productList,
        newDataList: newDataList,
        currentPage: page,
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

  String calculateRemainingTime(String startDate, String endDate) {
    DateTime start = DateFormat("yyyy-MM-dd HH:mm:ss").parse(startDate);
    DateTime end = DateFormat("yyyy-MM-dd HH:mm:ss").parse(endDate);

    Duration difference = end.difference(start);

    int days = difference.inDays;
    int hours = difference.inHours.remainder(24);
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);

    return '${days}d ${hours}h ${minutes}m ${seconds}s';
  }
}
