const String dataSearchSuggestion = 'datasearchsuggestion';

class SuggestionDataSearchModel {
  final String value;
  final int? dateLastview;

  SuggestionDataSearchModel({
    required this.value,
    required this.dateLastview,
  });
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'dateLastview': dateLastview,
    };
  }

  factory SuggestionDataSearchModel.fromMap(Map<String, dynamic> map) {
    return SuggestionDataSearchModel(
      value: map['value'] ?? '',
      dateLastview:
          map['dateLastview'] ?? DateTime.now().millisecondsSinceEpoch,
    );
  }
}
