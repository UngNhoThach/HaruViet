import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';

part 'address_state.g.dart';

@CopyWith()
class AddressState extends BaseState {
  final bool isLoading;
  final bool isSubmitSuccess;
  final String? addressDefaultId;

  final List<DataListAddress> listAddresses;
  const AddressState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.addressDefaultId,
    this.isLoading = false,
    this.listAddresses = const [],
    this.isSubmitSuccess = false,
  }) : super(viewState, errorMsg);
}
