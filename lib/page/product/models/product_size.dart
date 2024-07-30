import 'package:haruviet/page/product/models/categorical.dart';
import 'package:haruviet/page/product/models/numerical.dart';

class ProductSizeType {
  List<Numerical>? numerical;
  List<Categorical>? categorical;

  ProductSizeType({this.numerical, this.categorical});
}
