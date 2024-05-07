import 'package:eco_app/data/reponsitory/customers/models/address_response.dart';

import 'select_address_step.dart';

class SelectAddressParams {
  SelectAddressParams({
    this.step,
    this.dataAddress,
    required this.onChange,
    this.isRequiredAddress,
    this.isNotAddress = false,
  });
  final SelectAddressStep? step;
  final AddressResponse? dataAddress;
  final void Function(AddressResponse?) onChange;
  final bool? isRequiredAddress;
  final bool isNotAddress;
}
