import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/reponsitory/product/models/product_response.dart';
import 'package:haruviet/page/support/support_sate.dart';

class SupportBloc extends BaseBloc<SupportState> {
  SupportBloc() : super(const SupportState());
  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));

    List<ProductResponse> listCategories() {
      return [
        ProductResponse(
            id: 1,
            code: '9032451',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            price: '900.000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 2,
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            code: '90324529032452',
            price: '900.000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 3,
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            code: '9032453',
            amount: '1',
            price: '900.000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 4,
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            code: '9032454',
            amount: '1',
            price: '900.000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 5,
            amount: '1',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            code: '9032455',
            price: '900.000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 6,
            code: '9032456',
            amount: '1',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            price: '900.000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 7,
            code: '90324579032452',
            price: '900.000',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            name: 'Máy lạnh toshiba inverter 2 hp-End',
            isCheck: false),
        ProductResponse(
            id: 8,
            code: '9032458',
            price: '900.000',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 9,
            code: '9032459',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            price: '900.000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 10,
            code: '90324510',
            amount: '1',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            price: '900.000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 11,
            code: '903245119032452',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            price: '900.000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
      ];
    }

    final totalItem = listCategories().length;

    emit(state.copyWith(
        listCategories: listCategories(), finalPrice: 6, totalItem: totalItem));
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  // onChangeListConstruction(bool isAdd, int index) {
  //   var listConstruction =
  //       List<ConstructionMaeuveRequestType2Item>.from(state.listConstruction);
  //   if (isAdd) {
  //     listConstruction.add(ConstructionMaeuveRequestType2Item());
  //   } else {
  //     listConstruction.removeAt(index);
  //   }
  //   emit(state.copyWith(
  //     listConstruction: listConstruction,
  //     isChangeListConstruction: !state.isChangeListConstruction,
  //   ));
  // }

  onDeleteItem({
    required int index,
  }) {
    var listCategories = List<ProductResponse>.from(state.listCategories);
    listCategories.removeAt(index);
    final total = state.totalItem;
    int temp;
    if (total != null) {
      temp = total - 1;
    } else {
      temp = 0;
    }
    emit(state.copyWith(totalItem: temp, listCategories: listCategories));
  }
  // onChangeItemQuality(
  //   int index,
  //   int? quality,
  // ) {
  //   var items = List<CartItemRequest>.from(state.cartItemsRequest);
  //   items = items.asMap().entries.map((entry) {
  //     final i = entry.key;
  //     final element = entry.value;
  //     if (index == i) {
  //       return element.copyWith(
  //         quality: quality,
  //       );
  //     }
  //     return element;
  //   }).toList();
  //   emit(state.copyWith(
  //     cartItemsRequest: items,
  //   ));
  // }
}
