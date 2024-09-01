import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/reviews/models/post_review_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/data_product_detail_response.dart';
import 'package:haruviet/data/reponsitory/reviews/reviews_repository.dart';
import 'package:haruviet/page/review/write_review/write_review_state.dart';

class WriteReviewBloc extends BaseBloc<WriteReviewState> {
  final DataProductDetailResponse? dataProduct;

  WriteReviewBloc({required this.dataProduct})
      : super(const WriteReviewState());
  final ReviewsRepository _reviewsRepository = ReviewsRepository();

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));

    try {
      final userInfoLogin = await Preference.getUserInfo();

      emit(state.copyWith(
        dataProduct: dataProduct,
        userInfoLogin: userInfoLogin,
      ));
    } catch (e) {}

    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onChangeRating({
    required double rating,
  }) {
    emit(state.copyWith(rating: rating));
  }

  onChangeComment({
    required String comment,
  }) {
    emit(state.copyWith(comment: comment));
  }

  onSubmitReview() async {
    emit(state.copyWith(isSubmitted: false));
    try {
      final response = await _reviewsRepository.postReviewProductRP(
        request: PostReviewRequest(
          productId: dataProduct?.id ?? '',
          rating: state.rating.toInt(),
          comment: state.comment ?? '',
          customerId: state.userInfoLogin?.id ?? '',
          name: state.userInfoLogin?.name ?? '',
        ),
      );

      final y = response.parseReviewData();
      final z = response.parseDataNormalData();

      emit(state.copyWith(
          messsage: response.message,
          isSuccess: response.success,
          isSubmitted: true));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }
  }
}
