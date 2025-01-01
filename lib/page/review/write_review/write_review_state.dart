import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/data_product_detail_response.dart';

import '../../../data/data_local/user_state.dart';

part 'write_review_state.g.dart';

@CopyWith()
class WriteReviewState extends BaseState {
  final bool isLoading;
  final DataProduct? dataProduct;
  final double rating;
  final String? comment;
  final String? messsage;
  final UserState? userInfoLogin;
  final bool isSuccess;
  final bool isSubmitted;

  const WriteReviewState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.comment,
    this.isSuccess = false,
    this.userInfoLogin,
    this.rating = 0.0,
    this.isSubmitted = false,
    this.isLoading = false,
    this.messsage,
    this.dataProduct,
  }) : super(viewState, errorMsg);

  bool get isValid {
    if (rating == 0.0 || comment == null || comment == '') {
      return false;
    }
    return true;
  }
}
