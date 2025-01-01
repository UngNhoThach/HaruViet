// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentDataCWProxy {
  PaymentData paymentMethod(String? paymentMethod);

  PaymentData indexShippingMethod(int? indexShippingMethod);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaymentData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaymentData(...).copyWith(id: 12, name: "My name")
  /// ````
  PaymentData call({
    String? paymentMethod,
    int? indexShippingMethod,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaymentData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaymentData.copyWith.fieldName(...)`
class _$PaymentDataCWProxyImpl implements _$PaymentDataCWProxy {
  const _$PaymentDataCWProxyImpl(this._value);

  final PaymentData _value;

  @override
  PaymentData paymentMethod(String? paymentMethod) =>
      this(paymentMethod: paymentMethod);

  @override
  PaymentData indexShippingMethod(int? indexShippingMethod) =>
      this(indexShippingMethod: indexShippingMethod);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaymentData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaymentData(...).copyWith(id: 12, name: "My name")
  /// ````
  PaymentData call({
    Object? paymentMethod = const $CopyWithPlaceholder(),
    Object? indexShippingMethod = const $CopyWithPlaceholder(),
  }) {
    return PaymentData(
      paymentMethod: paymentMethod == const $CopyWithPlaceholder()
          ? _value.paymentMethod
          // ignore: cast_nullable_to_non_nullable
          : paymentMethod as String?,
      indexShippingMethod: indexShippingMethod == const $CopyWithPlaceholder()
          ? _value.indexShippingMethod
          // ignore: cast_nullable_to_non_nullable
          : indexShippingMethod as int?,
    );
  }
}

extension $PaymentDataCopyWith on PaymentData {
  /// Returns a callable class that can be used as follows: `instanceOfPaymentData.copyWith(...)` or like so:`instanceOfPaymentData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentDataCWProxy get copyWith => _$PaymentDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentData _$PaymentDataFromJson(Map<String, dynamic> json) => PaymentData(
      paymentMethod: json['payment_method'] as String?,
      indexShippingMethod: (json['index_shipping_method'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaymentDataToJson(PaymentData instance) =>
    <String, dynamic>{
      'payment_method': instance.paymentMethod,
      'index_shipping_method': instance.indexShippingMethod,
    };
