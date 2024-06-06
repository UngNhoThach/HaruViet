import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/reponsitory/product/models/list_product/data_product.dart';
import 'package:eco_app/data/data_local/user_state.dart';

part 'product_detail_state.g.dart';

@CopyWith()
class ProductDetailState extends BaseState {
  final bool isSubmitSuccess;
  final UserInfoLogin? userInfoLogin;
  final bool isLoading;
  final DataProduct? dataProduct;
  final List<String> imageUrls;
  const ProductDetailState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isSubmitSuccess = false,
    this.isLoading = false,
    this.imageUrls = const [],
    this.dataProduct,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
