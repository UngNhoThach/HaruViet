import 'package:flutter/material.dart';
import 'package:haruviet/helper/colors.dart';

enum CurrentTab {
//  'topsale','latest','pricelowtohigh','pricehightolow',
  hot('topsale'),
  topsale('topsale'),
  latest('latest'),
  priceLow('pricelowtohigh'),
  priceHigh('pricehightolow');

  const CurrentTab(this.value);

  final String value;

  static CurrentTab from(String? value) {
    return CurrentTab.values.firstWhere(
      (element) => element.value == value,
      orElse: () => CurrentTab.latest,
    );
  }

  String get name {
    switch (this) {
      case CurrentTab.hot:
        return "Hot";
      case CurrentTab.topsale:
        return 'Bán chạy';
      case CurrentTab.latest:
        return 'Mới nhất';
      case CurrentTab.priceLow:
        return '';
      case CurrentTab.priceHigh:
        return '';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case CurrentTab.topsale:
        return const Color(0xFFFFF2CC);
      case CurrentTab.hot:
        return colorMain;

      case CurrentTab.latest:
        return colorMain;
      case CurrentTab.priceLow:
        return colorMain;
      case CurrentTab.priceHigh:
        return colorMain;
    }
  }

  Color get color {
    switch (this) {
      case CurrentTab.topsale:
        return const Color(0xFFC55A11);
      case CurrentTab.hot:
        return const Color(0xFFFFFFFF);
      case CurrentTab.latest:
        return const Color(0xFFFFFFFF);
      case CurrentTab.priceLow:
        return const Color(0xFFFFFFFF);
      case CurrentTab.priceHigh:
        return const Color(0xFFFFFFFF);
    }
  }
}
