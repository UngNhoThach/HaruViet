import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/reviews/models/post_review_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/data/reponsitory/reviews/reviews_repository.dart';
import 'package:haruviet/page/review/write_review/widgets/write_review_params.dart';
import 'package:haruviet/page/review/write_review/write_review_state.dart';

class WriteReviewBloc extends BaseBloc<WriteReviewState> {
  final WriteReviewParams? params;

  WriteReviewBloc({this.params}) : super(const WriteReviewState());
  final ReviewsRepository _reviewsRepository = ReviewsRepository();
  final ProductRepository _productRepository = ProductRepository();

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));

    try {
      final userInfoLogin = await Preference.getUserInfo();
      // if direc by id
      final productDetail = params?.itemProductDetailResponse ??
          await _productRepository.getProductDetailsRP(
              idProduct: params?.idItem ?? '');

      emit(state.copyWith(
        dataProduct: productDetail,
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
          productId: params?.itemProductDetailResponse?.id ?? '',
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
