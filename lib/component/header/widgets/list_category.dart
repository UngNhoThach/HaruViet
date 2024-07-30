import 'package:haruviet/helper/colors.dart';
import 'package:flutter/material.dart';

enum CategoryList {
  all(6),
  current(0),
  processing(1),
  done(2),
  complete(3),
  bon(4),
  nam(5);

  const CategoryList(this.value);

  final int value;

  static CategoryList from(int? value) {
    return CategoryList.values.firstWhere(
      (element) => element.value == value,
      orElse: () => CategoryList.current,
    );
  }

  String get name {
    switch (this) {
      case CategoryList.all:
        return 'Điện công nghiệp Điện công nghiệp';
      case CategoryList.current:
        return 'Điện dân dụng';
      case CategoryList.processing:
        return 'Điện nhà máy';
      case CategoryList.done:
        return 'Điện trung thế ';
      case CategoryList.complete:
        return 'Điện hạ thế';
      case CategoryList.bon:
        return 'Điện hạ thế';
      case CategoryList.nam:
        return 'Điện hạ thế';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case CategoryList.all:
        return const Color(0xFFB6B6B6);
      case CategoryList.current:
        return const Color(0xFFB6B6B6);
      case CategoryList.processing:
        return const Color(0xFFFFF2CC);
      case CategoryList.done:
        return const Color(0xFFDEEBF7);
      case CategoryList.complete:
        return colorPrimary01;
      case CategoryList.bon:
        return const Color(0xFFDCFFEA);
      case CategoryList.nam:
        return const Color(0xFFDCFFEA);
    }
  }

  Color get color {
    switch (this) {
      case CategoryList.all:
        return const Color(0xFFFFFFFF);
      case CategoryList.current:
        return const Color(0xFFFFFFFF);
      case CategoryList.processing:
        return const Color(0xFFC55A11);
      case CategoryList.done:
        return const Color(0xFF0070C0);
      case CategoryList.complete:
        return colorPrimary01;
      case CategoryList.bon:
        return const Color(0xFF0070C0);
      case CategoryList.nam:
        return const Color(0xFF00B050);
    }
  }
}
