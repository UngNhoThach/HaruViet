Map<String, dynamic> splitCurrencyString(String currency) {
  List<String> parts = currency.split('.');
  int wholePart = int.parse(parts[0]);
  String decimalPart = parts.length > 1 ? '0.${parts[1]}' : '0.00';
  return {
    'wholePart': wholePart,
    'decimalPart': double.parse(decimalPart),
  };
}

int splitLetterString({required String valueInput}) {
  List<String> parts = valueInput.split('.');
  int wholePart = int.parse(parts[0]);

  return wholePart;
}
