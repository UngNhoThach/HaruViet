import 'package:flutter/material.dart';
import 'package:haruviet/helper/colors.dart';

enum CurrentTab {
  all(6),
  current(0),
  processing(1),
  done(2),
  complete(3);

  const CurrentTab(this.value);

  final int value;

  static CurrentTab from(int? value) {
    return CurrentTab.values.firstWhere(
      (element) => element.value == value,
      orElse: () => CurrentTab.current,
    );
  }

  String get name {
    switch (this) {
      case CurrentTab.all:
        return 'Tất cả';
      case CurrentTab.current:
        return 'Nổi bật';
      case CurrentTab.processing:
        return 'Bán chạy';
      case CurrentTab.done:
        return 'Giá';
      case CurrentTab.complete:
        return 'Siêu giảm';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case CurrentTab.all:
        return colorMain;
      case CurrentTab.current:
        return const Color(0xFFB6B6B6);
      case CurrentTab.processing:
        return const Color(0xFFFFF2CC);
      case CurrentTab.done:
        return const Color(0xFFDEEBF7);
      case CurrentTab.complete:
        return const Color(0xFFDCFFEA);
    }
  }

  Color get color {
    switch (this) {
      case CurrentTab.all:
        return const Color(0xFFFFFFFF);
      case CurrentTab.current:
        return const Color(0xFFFFFFFF);
      case CurrentTab.processing:
        return const Color(0xFFC55A11);
      case CurrentTab.done:
        return const Color(0xFF0070C0);
      case CurrentTab.complete:
        return const Color(0xFF00B050);
    }
  }
}
