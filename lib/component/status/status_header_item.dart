import 'package:flutter/material.dart';

enum StatusWork {
  all(6),
  current(0),
  processing(1),
  done(2),
  complete(3);

  const StatusWork(this.value);

  final int value;

  static StatusWork from(int? value) {
    return StatusWork.values.firstWhere(
      (element) => element.value == value,
      orElse: () => StatusWork.current,
    );
  }

  String get name {
    switch (this) {
      case StatusWork.all:
        return 'Tất cả';
      case StatusWork.current:
        return 'Nổi bật';
      case StatusWork.processing:
        return 'Bán chạy';
      case StatusWork.done:
        return 'Giá';
      case StatusWork.complete:
        return 'Siêu giảm';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case StatusWork.all:
        return const Color(0xFFB6B6B6);
      case StatusWork.current:
        return const Color(0xFFB6B6B6);
      case StatusWork.processing:
        return const Color(0xFFFFF2CC);
      case StatusWork.done:
        return const Color(0xFFDEEBF7);
      case StatusWork.complete:
        return const Color(0xFFDCFFEA);
    }
  }

  Color get color {
    switch (this) {
      case StatusWork.all:
        return const Color(0xFFFFFFFF);
      case StatusWork.current:
        return const Color(0xFFFFFFFF);
      case StatusWork.processing:
        return const Color(0xFFC55A11);
      case StatusWork.done:
        return const Color(0xFF0070C0);
      case StatusWork.complete:
        return const Color(0xFF00B050);
    }
  }
}
