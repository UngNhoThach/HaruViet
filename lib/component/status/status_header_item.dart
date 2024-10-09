import 'package:flutter/material.dart';

enum CurrentTab {
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

  Color backgroundColor(BuildContext context) {
    switch (this) {
      case CurrentTab.topsale:
        return const Color(0xFFFFF2CC);
      case CurrentTab.hot:
      case CurrentTab.latest:
      case CurrentTab.priceLow:
      case CurrentTab.priceHigh:
        return Theme.of(context).primaryColor;
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
