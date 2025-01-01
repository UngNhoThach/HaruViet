import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/attributes_category_response.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/value_attributes.dart';

part 'filter_product_state.g.dart';

@CopyWith()
class FilterProductState extends BaseState {
  final UserState? userInfoLogin;
  final bool isLoading;
  final List<AtributesCategoryResponse> atributesCategoryData;
  final List<AtributesValue> attributesSelected;
  final bool checkResetFilter;
  final Map<AtributesCategoryResponse, AtributesValue>? filteredCategories;

  const FilterProductState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.checkResetFilter = false,
    this.isLoading = false,
    this.filteredCategories,
    this.attributesSelected = const [],
    this.atributesCategoryData = const [],
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
