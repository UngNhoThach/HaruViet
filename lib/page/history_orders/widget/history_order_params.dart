import 'package:flutter/material.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/cart_order_status_response/data_status_order.dart';

class HistoryOrderParams {
  HistoryOrderParams({
    required this.onReload,
    required this.listStatusOrder,
  });
  final VoidCallback onReload;
  final List<DataStatusOrder> listStatusOrder;
}
