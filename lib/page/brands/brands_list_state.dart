import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/brands_repository/get_top_brands_response/data_top_brand.dart';

import 'package:haruviet/helper/const.dart';

part 'brands_list_state.g.dart';

@CopyWith()
class BrandsListState extends BaseState {
  final bool isSubmitSuccess;
  final bool isLoading;
  final bool canLoadMore;
  final int currentPage;
  final List<DataTopBrand>? newDataList;
  final List<DataTopBrand> datatList;
  final int limit;

  const BrandsListState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.canLoadMore = false,
    this.limit = 12, // perPage,
    this.currentPage = startPage,
    this.isSubmitSuccess = false,
    this.datatList = const [],
    this.newDataList,
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
