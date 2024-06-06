import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/data/reponsitory/product/product_repository.dart';
import 'package:eco_app/page/product/detail/product_detail_state.dart';
import 'package:flutter/foundation.dart';

// ProductDetailBloc
class ProductDetailBloc extends BaseBloc<ProductDetailState> {
  ProductDetailBloc() : super(const ProductDetailState());
  final ProductRepository _productRepository = ProductRepository();
  getData(final String idProduct) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final userInfoLogin = await Preference.getUserInfo();
      final productDetail =
          await _productRepository.getProductDetailsRP(idProduct: idProduct);

      //   final domain = userInfoLogin?.subDomain ?? '';

      final imageUrls = [
        '${productDetail.image}',
      ];
      emit(state.copyWith(
          userInfoLogin: userInfoLogin,
          dataProduct: productDetail,
          imageUrls: imageUrls));
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
}
