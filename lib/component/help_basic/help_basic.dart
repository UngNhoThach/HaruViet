class HelpBasic {
  // remove .0 double
  String formatDouble(double value) {
    if (value == value.toInt()) {
      // Chuyển đổi thành chuỗi và loại bỏ phần ".0"
      return value.toInt().toString();
    } else {
      return value.toString();
    }
  }
}
