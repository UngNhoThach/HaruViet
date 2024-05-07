import 'package:eco_app/page/product/models/categorical.dart';
import 'package:eco_app/page/product/models/numerical.dart';

class ProductSizeType {
  List<Numerical>? numerical;
  List<Categorical>? categorical;

  ProductSizeType({this.numerical, this.categorical});
}
