import 'package:flutter/material.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/attributes_category_response.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/value_attributes.dart';

class FilterProductParams {
  FilterProductParams({
    // this.onSearchUser,
    // this.onSelectChanged,
    // this.personnelsChange,
    // this.organizationId,
    // this.isNotId = true,
    // this.onGetUserEmployee,
    // this.idStep2,
    // this.status,
    required this.onReturnResult,
    required this.onReload,
    required this.atributesCategoryData,
    required this.onReturnAtributesCategoryData,
    this.filteredCategories,
  });
  // final void Function(String, String, String?)? onSearchUser;
  // final void Function(List<EmployeeResponse>)? onSelectChanged;
  // final void Function(DetailManeuveRestoresRespone?)? onGetUserEmployee;
  final VoidCallback onReload;
  final List<AtributesCategoryResponse> atributesCategoryData;
  // final List<AtributesCategoryResponse> atributesCategoryDataReturn;
  final void Function(List<AtributesCategoryResponse>?)
      onReturnAtributesCategoryData;
  final void Function(Map<AtributesCategoryResponse, AtributesValue>?)
      onReturnResult;
  final Map<AtributesCategoryResponse, AtributesValue>? filteredCategories;

  // final bool isNotId;
  // final String? idStep2;
  // final int? organizationId;
  // final int? status;
}
