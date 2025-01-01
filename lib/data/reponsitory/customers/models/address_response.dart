import 'package:haruviet/data/reponsitory/setting/models/item_base_response.dart';

class AddressResponse {
  const AddressResponse({
    this.city,
    this.district,
    this.ward,
    this.address,
    this.fullAddress,
  });
  final ItemBaseResponse? city;
  final ItemBaseResponse? district;
  final ItemBaseResponse? ward;
  final String? address;
  final String? fullAddress;

  @override
  String toString() {
    return (address ?? '').isNotEmpty
        ? '$address, ${ward?.name}, ${district?.name}, ${city?.name}'
        : '' '${ward?.name}, ${district?.name}, ${city?.name}';
  }

  AddressResponse copyWith({
    ItemBaseResponse? city,
    ItemBaseResponse? district,
    ItemBaseResponse? ward,
    String? address,
    String? fullAddress,
  }) {
    return AddressResponse(
      city: city ?? this.city,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      address: address ?? this.address,
      fullAddress: fullAddress ?? this.fullAddress,
    );
  }
}
