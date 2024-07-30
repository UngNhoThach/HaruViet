import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/customers/models/address_response.dart';
import 'package:haruviet/data/reponsitory/setting/item_base_response.dart';

import 'models/select_address_step.dart';

part 'select_address_state.g.dart';

@CopyWith()
class SelectAddressState extends BaseState {
  final SelectAddressStep? step;
  final bool isLoading;
  final bool isSelect;
  final List<ItemBaseResponse> dataList;
  final List<ItemBaseResponse> dataSearchList;
  final AddressResponse dataAddress;
  final bool isSubmitSuccess;

  const SelectAddressState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.step = SelectAddressStep.city,
    this.isLoading = false,
    this.isSelect = false,
    this.dataList = const [],
    this.dataSearchList = const [],
    this.dataAddress = const AddressResponse(),
    this.isSubmitSuccess = false,
  }) : super(viewState, errorMsg);
}
