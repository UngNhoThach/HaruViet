import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

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
