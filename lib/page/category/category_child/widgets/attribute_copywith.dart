class AttributeCopyWith {
  AttributeCopyWith({
    this.id,
    this.lang,
    this.value,
    this.isFilter = false,
  });

  final String? id;
  final String? lang;
  final String? value;
  final bool? isFilter;

  AttributeCopyWith copyWith(
      {String? id, String? lang, String? value, bool? isFilter}) {
    return AttributeCopyWith(
      id: id ?? this.id,
      lang: lang ?? this.lang,
      value: id ?? this.value,
      isFilter: isFilter ?? this.isFilter,
    );
  }
}
