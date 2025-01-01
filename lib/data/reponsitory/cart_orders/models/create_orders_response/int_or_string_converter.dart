import 'package:json_annotation/json_annotation.dart';

class IntOrStringConverter implements JsonConverter<int?, dynamic> {
  const IntOrStringConverter();

  @override
  int? fromJson(dynamic json) {
    if (json == null) {
      return null;
    } else if (json is int) {
      return json;
    } else if (json is String) {
      return int.tryParse(json);
    }
    throw Exception('Invalid type for qty: $json');
  }

  @override
  dynamic toJson(int? object) => object;
}
