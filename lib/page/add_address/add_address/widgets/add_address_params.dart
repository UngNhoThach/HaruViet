import 'package:eco_app/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:flutter/material.dart';

class AddNewAddressParams {
  AddNewAddressParams({
    required this.onReload,
    this.status,
    this.isUpdate = false,
    this.dataListAddress,
  });
  final VoidCallback onReload;
  final int? status;
  final bool isUpdate;
  final DataListAddress? dataListAddress;
}
