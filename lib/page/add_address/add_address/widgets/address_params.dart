import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';

class AddressParams {
  AddressParams({
    this.idAddressShipping,
    this.returnAddress,
    required this.isShipping,
  });
  final String? idAddressShipping;
  final void Function(DataListAddress? dataAddress)? returnAddress;
  final bool isShipping;
}
