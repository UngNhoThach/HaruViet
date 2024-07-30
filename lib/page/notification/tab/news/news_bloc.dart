import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/news/news_response.dart';
import 'package:haruviet/page/notification/tab/news/news_state.dart';
import 'package:haruviet/service/clearedStoredData.dart';
import 'package:flutter/foundation.dart';

// NewsBloc
class NewsBloc extends BaseBloc<NewsState> {
  NewsBloc() : super(const NewsState());

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final userInfoLogin = await Preference.getUserInfo();

      List<NewsResponse> listNews() {
        return [
          NewsResponse(
            id: 1,
            description:
                'Chi nhánh 1519 Phạm Văn Thuận TP Biên Hoà Đồng Nai, Việt Nam',
            image:
                'https://images2.thanhnien.vn/zoom/328_205/Uploaded/linhntqc/2023_01_21/picture1-7887.jpg',
            location: 'CN 1519 Phạm Văn Thuận TP Biên Hoà',
            time: '01-12-2023',
            title: 'Tủ lạnh TOSIBA',
          ),
          NewsResponse(
            id: 1,
            description:
                'Chi nhánh 1519 Phạm Văn Thuận TP Biên Hoà Đồng Nai, Việt Nam',
            image:
                'https://images2.thanhnien.vn/zoom/328_205/Uploaded/linhntqc/2023_01_21/picture1-7887.jpg',
            location: 'CN 1519 Phạm Văn Thuận TP Biên Hoà',
            time: '01-12-2023',
            title: 'Tủ lạnh TOSIBA',
          ),
          NewsResponse(
            id: 1,
            description:
                'Chi nhánh 1519 Phạm Văn Thuận TP Biên Hoà Đồng Nai, Việt Nam',
            image:
                'https://images2.thanhnien.vn/zoom/328_205/Uploaded/linhntqc/2023_01_21/picture1-7887.jpg',
            location: 'CN 1519 Phạm Văn Thuận TP Biên Hoà',
            time: '01-12-2023',
            title: 'Tủ lạnh TOSIBA',
          ),
          NewsResponse(
            id: 1,
            description:
                'Chi nhánh 1519 Phạm Văn Thuận TP Biên Hoà Đồng Nai, Việt Nam',
            image:
                'https://images2.thanhnien.vn/zoom/328_205/Uploaded/linhntqc/2023_01_21/picture1-7887.jpg',
            location: 'CN 1519 Phạm Văn Thuận TP Biên Hoà',
            time: '01-12-2023',
            title: 'Tủ lạnh TOSIBA',
          ),
          NewsResponse(
            id: 1,
            description:
                'Chi nhánh 1519 Phạm Văn Thuận TP Biên Hoà Đồng Nai, Việt Nam',
            image:
                'https://images2.thanhnien.vn/zoom/328_205/Uploaded/linhntqc/2023_01_21/picture1-7887.jpg',
            location: 'CN 1519 Phạm Văn Thuận TP Biên Hoà',
            time: '01-12-2023',
            title: 'Tủ lạnh TOSIBA',
          ),
          NewsResponse(
            id: 1,
            description:
                'Chi nhánh 1519 Phạm Văn Thuận TP Biên Hoà Đồng Nai, Việt Nam',
            image:
                'https://images2.thanhnien.vn/zoom/328_205/Uploaded/linhntqc/2023_01_21/picture1-7887.jpg',
            location: 'CN 1519 Phạm Văn Thuận TP Biên Hoà',
            time: '01-12-2023',
            title: 'Tủ lạnh TOSIBA',
          ),
          NewsResponse(
            id: 1,
            description:
                'Chi nhánh 1519 Phạm Văn Thuận TP Biên Hoà Đồng Nai, Việt Nam',
            image:
                'https://images2.thanhnien.vn/zoom/328_205/Uploaded/linhntqc/2023_01_21/picture1-7887.jpg',
            location: 'CN 1519 Phạm Văn Thuận TP Biên Hoà',
            time: '01-12-2023',
            title: 'Tủ lạnh TOSIBA',
          ),
          NewsResponse(
            id: 1,
            description:
                'Chi nhánh 1519 Phạm Văn Thuận TP Biên Hoà Đồng Nai, Việt Nam',
            image:
                'https://images2.thanhnien.vn/zoom/328_205/Uploaded/linhntqc/2023_01_21/picture1-7887.jpg',
            location: 'CN 1519 Phạm Văn Thuận TP Biên Hoà',
            time: '01-12-2023',
            title: 'Tủ lạnh TOSIBA',
          ),
          NewsResponse(
            id: 1,
            description:
                'Chi nhánh 1519 Phạm Văn Thuận TP Biên Hoà Đồng Nai, Việt Nam',
            image:
                'https://images2.thanhnien.vn/zoom/328_205/Uploaded/linhntqc/2023_01_21/picture1-7887.jpg',
            location: 'CN 1519 Phạm Văn Thuận TP Biên Hoà',
            time: '01-12-2023',
            title: 'Tủ lạnh TOSIBA',
          ),
        ];
      }

      emit(state.copyWith(userInfoLogin: userInfoLogin, listNews: listNews()));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onLogout() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    // emit(state.copyWith(isSubmitSuccess: false));
    await clearSharedPreferencesData();
    await getData();
    emit(state.copyWith(
      isLoading: false,
    ));
  }
}
