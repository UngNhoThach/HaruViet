import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

const startPage = 1;
const perPage = 10;
const perPageHome = 4;

const unknown = 'Không xác định';
const noData = ' ';

CurrencyTextInputFormatter get currencyFormatWithoutSymbol =>
    CurrencyTextInputFormatter(
      locale: 'vi',
      decimalDigits: 0,
      symbol: '',
    );

CurrencyTextInputFormatter get defaultCurrencyFormatter =>
    CurrencyTextInputFormatter(
      locale: 'vi',
      symbol: 'đ',
      decimalDigits: 0,
    );

CurrencyTextInputFormatter get defaultCurrencyVNDFormatter =>
    CurrencyTextInputFormatter(
      locale: 'vi',
      symbol: 'VNĐ',
      decimalDigits: 0,
    );
