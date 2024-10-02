import 'package:flutter/foundation.dart';

class HistoryOrderTabParams {
  HistoryOrderTabParams({
    required this.onReload,
    this.idUser,
    this.status,
  });
  final VoidCallback onReload;
  final String? idUser;
  final int? status;
}
