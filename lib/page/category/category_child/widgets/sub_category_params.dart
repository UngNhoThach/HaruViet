class CategoryParams {
  CategoryParams({
    required this.idCategory,
    this.isProcuctRecommendation = false,
    this.idBrand,
  });
  final String idCategory;
  final String? idBrand;
  bool isProcuctRecommendation;
}
