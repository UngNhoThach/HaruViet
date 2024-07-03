import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/reponsitory/product/models/list_product/data_product.dart';
import 'package:eco_app/data/reponsitory/product/models/list_product/list_product.dart';
import 'package:eco_app/data/data_local/user_state.dart';
import 'package:eco_app/helper/const.dart';

part 'home_state.g.dart';

@CopyWith()
class HomeState extends BaseState {
  final bool isSubmitSuccess;
  final UserInfoLogin? userInfoLogin;
  final bool isLoading;
  final bool canLoadMore;
  final int currentPage;
  final ListProduct? productList;
  final List<DataProduct>? newDataList;
  final List<DataProduct> datatList;
  final int limit;

  const HomeState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.productList,
    this.canLoadMore = false,
    this.limit = 8, // perPageHome,
    this.currentPage = startPage,
    this.isSubmitSuccess = false,
    this.datatList = const [],
    this.newDataList,
    this.isLoading = false,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
