import 'package:json_annotation/json_annotation.dart';

part 'value_attributes.g.dart';

@JsonSerializable()
class AtributesValue {
  String? id;
  String? lang;
  String? value;
  bool? isFilter;
  String? idSubCategory;
  String? idSelected;

  AtributesValue(
      {this.id,
      this.lang,
      this.value,
      this.isFilter,
      this.idSubCategory,
      this.idSelected});

  factory AtributesValue.fromJson(Map<String, dynamic> json) =>
      _$AtributesValueFromJson(json);

  Map<String, dynamic> toJson() => _$AtributesValueToJson(this);

  AtributesValue copyWith({
    String? id,
    String? lang,
    String? value,
    bool? isFilter,
    String? idSelected,
    String? idSubCategory,
  }) {
    return AtributesValue(
      id: id ?? this.id,
      lang: lang ?? this.lang,
      value: value ?? this.value,
      isFilter: isFilter ?? this.isFilter,
      idSelected: idSelected ?? this.idSelected,
      idSubCategory: idSubCategory ?? this.idSelected,
    );
  }
}
