import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import "package:intl/intl.dart";

const startPage = 1;
const perPage = 10;
const perPageHome = 4;

const unknown = 'Không xác định';
const noData = ' ';

CurrencyTextInputFormatter get currencyFormatWithoutSymbol =>
    CurrencyTextInputFormatter.currency(
      locale: 'vi',
      decimalDigits: 0,
      symbol: '',
    );

CurrencyTextInputFormatter get defaultCurrencyFormatter =>
    CurrencyTextInputFormatter.currency(
      locale: 'vi',
      symbol: 'đ',
      decimalDigits: 0,
    );

CurrencyTextInputFormatter get defaultCurrencyVNDFormatter =>
    CurrencyTextInputFormatter.currency(
      locale: 'vi',
      symbol: 'VNĐ',
      decimalDigits: 0,
    );

int splitCurrency(String currency) {
  List<String> parts = currency.split('.');
  int wholePart = int.parse(parts[0]);
  return wholePart;
}

String toPrice({required String value}) {
  if (value == "") {
    return '0';
  } else {
    int temp = splitCurrency(value);
    final result =
        defaultCurrencyVNDFormatter.formatString(((temp).toStringAsFixed(0)));
    return result;
  }
}

String formatDouble(double value) {
  if (value == value.toInt()) {
    // Chuyển đổi thành chuỗi và loại bỏ phần ".0"
    return value.toInt().toString();
  } else {
    return value.toString();
  }
}

// split the string before and after the ","
List<String> splitStringWithComma(String input) {
  List<String> parts = input.split(',');

  if (parts.length == 2) {
    String before = parts[0].trim();
    String after = parts[1].trim();
    return [before, after];
  } else {
    return ['', ''];
  }
}

// convert to kilogram
double convertToKilogram({required String unit, required double value}) {
  switch (unit.toLowerCase()) {
    case 'oz': // ounce
      return value * 0.0283495;
    case 'g': // gram
      return value * 0.001;
    case 'lb': // pound
      return value * 0.453592;
    case 'kg': // kilogram
      return value;
    default:
      return 0.0;
  }
}

String formattedNumber(dynamic numberToFormat) {
  var formattedNumber = NumberFormat.compact().format(numberToFormat);
  return formattedNumber;
}
