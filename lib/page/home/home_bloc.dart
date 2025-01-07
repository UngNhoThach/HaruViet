import 'package:haruviet/api/services/products/models/get_list_product_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/brands_repository/brands_repository.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/page/home/home_state.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

// HomeBloc
class HomeBloc extends BaseBloc<HomeState> {
  HomeBloc() : super(const HomeState());
  final ProductRepository _productRepository = ProductRepository();
  final BrandsRepository _brandRepository = BrandsRepository();

  removeZeroDouble({required double value}) {
    return formatDouble(value);
  }

  onChangeFirstTimeLoadinPage(bool firtTimeLoadingPage) {
    emit(state.copyWith(firtTimeLoadingPage: firtTimeLoadingPage));
  }

  onChangeViewMember() {
    emit(state.copyWith(isViewMemberCard: !state.isViewMemberCard));
  }

  getData() async {
    emit(state.copyWith(
      isLoading: true,
      isLoadingBrands: true,
    ));
    try {
      //   final dbHelper = IdProductRecommendationDatabase();
      //   final List<IdProductRecommendationModel> idProductListLocal;
      //    idProductListLocal = await dbHelper.getAllProducts();

      final userInfoLogin = await Preference.getUserInfo();
      emit(state.copyWith(
        //    idProductListLocal: idProductListLocal,
        userInfoLogin: userInfoLogin,
      ));

      // get product list
      await onFetch(page: startPage);
      // get product flash deal
      await onGetProductsFlashsale(page: startPage);
      // get top brands
      await onGetTopBrands();
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

      var newDataList =
          List<DataProduct>.from(productList.parseDataProduct() ?? []);

      final loadingCount = ((productList.total ?? 0) / state.limit);
      final maxLoadMore = loadingCount.floor();
      if (isINT(loadingCount)) {
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
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }
  }

  // loading a + loading b  + loading c
  // if loading[A] is not change && loading[B] is not change && loading[C] is not change
  // => isPendingLoading = true => 0.2 || isPendingLoading = false
  // =>

  // start get products Flashsale
  bool canLoadMoreProductFlashDeal = false;

  // start onReset

  onReset() async {
    emit(state.copyWith(isPendingLoading: true));
    await onFetch(page: startPage);
    await onGetProductsFlashsale(page: startPage);
    emit(state.copyWith(isPendingLoading: false));
  }
// end onReset

  // RestClient
  onGetProductsFlashsale({
    required int page,
  }) async {
    try {
      if (page == startPage) {
        emit(
          state.copyWith(
            //   isPendingLoading: true,
            newDataListProductFlashDeal: null,
            canLoadMoreProductFlashDeal: false,
          ),
        );
      }
      final productListFlashsale = await _productRepository.getListProductsRP(
        request: GetListProductRequest(
            paegNumber: page,
            pageSize: state.limitFlashDeal,
            sort: CurrentTab.topsale.value),
      );

      var newDataListProductFlashDeal =
          List<DataProduct>.from(productListFlashsale.parseDataProduct() ?? []);

      // start check isPendingLoading
      // if (!state.isFirstLoading) {
      //   if (newDataListProductFlashDeal[0].price?.price !=
      //           state.datatListProductFlashDeal[0].price?.price &&
      //       newDataListProductFlashDeal[0].id !=
      //           state.datatListProductFlashDeal[0].id) {
      //     emit(state.copyWith(
      //       newDataListProductFlashDeal: newDataListProductFlashDeal,
      //       datatListProductFlashDeal: newDataListProductFlashDeal,
      //     ));
      //   } else {
      //     emit(state.copyWith(
      //       newDataListProductFlashDeal:
      //           state.datatListProductFlashDeal.take(8).toList(),
      //     ));
      //     // isPendingLoading: false,
      //   }
      // }
      // end check isPendingLoading

      final loadingCount =
          ((productListFlashsale.total ?? 0) / state.limitFlashDeal);
      final maxLoadMore = loadingCount.floor();
      if (isINT(loadingCount)) {
        canLoadMoreProductFlashDeal = page < maxLoadMore;
      } else {
        canLoadMoreProductFlashDeal = page <= maxLoadMore;
        print('error');
      }
      emit(state.copyWith(
        isFirstLoading: false,
        //    isPendingLoading: false,
        datatListProductFlashDeal: newDataListProductFlashDeal,
        newDataListProductFlashDeal: newDataListProductFlashDeal,
        currentPageProductFlashDeal: page,
        canLoadMoreProductFlashDeal: canLoadMoreProductFlashDeal,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }
  }

  // end get products Flashsale

  // start get top brands
  onGetTopBrands() async {
    try {
      final listTopBrands = await _brandRepository.getTopBrandRP(pageSize: 8);
      emit(state.copyWith(listTopBrands: listTopBrands.data));
    } catch (e) {
      print(e);
    }
    emit(state.copyWith(isLoadingBrands: false));
  }

  // end get top brands
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
