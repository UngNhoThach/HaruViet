import 'package:flutter/material.dart';
import 'package:haruviet/helper/colors.dart';

enum CurrentTab {
//  'topsale','latest','pricelowtohigh','pricehightolow',
  all(''),
  topsale('topsale'),
  latest('latest'),
  pricelowtohigh('pricelowtohigh'),
  pricehightolow('pricehightolow');

  const CurrentTab(this.value);

  final String value;

  static CurrentTab from(String? value) {
    return CurrentTab.values.firstWhere(
      (element) => element.value == value,
      orElse: () => CurrentTab.all,
    );
  }

  String get name {
    switch (this) {
      case CurrentTab.all:
        return 'Tất cả';
      case CurrentTab.topsale:
        return 'Bán chạy';
      case CurrentTab.latest:
        return 'Mới nhất';
      case CurrentTab.pricehightolow:
        return 'Giá giảm dần';
      case CurrentTab.pricelowtohigh:
        return 'Giá tăng dần';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case CurrentTab.all:
        return colorMain;
      case CurrentTab.topsale:
        return const Color(0xFFB6B6B6);
      case CurrentTab.latest:
        return const Color(0xFFFFF2CC);
      case CurrentTab.pricehightolow:
        return const Color(0xFFDEEBF7);
      case CurrentTab.pricelowtohigh:
        return const Color(0xFFDCFFEA);
    }
  }

  Color get color {
    switch (this) {
      case CurrentTab.all:
        return const Color(0xFFFFFFFF);
      case CurrentTab.topsale:
        return const Color(0xFFFFFFFF);
      case CurrentTab.latest:
        return const Color(0xFFC55A11);
      case CurrentTab.pricehightolow:
        return const Color(0xFF0070C0);
      case CurrentTab.pricelowtohigh:
        return const Color(0xFF00B050);
    }
  }
}
