const String idProductsTable = 'productsrecommendation';

class IdProductRecommendationModel {
  final String id;

  IdProductRecommendationModel({
    required this.id,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory IdProductRecommendationModel.fromMap(Map<String, dynamic> map) {
    return IdProductRecommendationModel(
      id: map['id'] ?? '',
    );
  }
}
