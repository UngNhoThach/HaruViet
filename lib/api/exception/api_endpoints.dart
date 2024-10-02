class SettingApi {
  static const rootDomain = "https://dev.sni.vn";
  static const giaohangtietkiem = "https://services.giaohangtietkiem.vn";
  static const getCountryList =
      "$rootDomain/api/v1/shop/province?id_country={id_country}";
  static const getDistrictList =
      "$rootDomain/api/v1/shop/district?id_province={id_province}";
  static const getWardList =
      "$rootDomain/api/v1/shop/ward/?id_district={id_district}";
}

// CUSTOMERS API
class CustomersApi {
  static const login = "${SettingApi.rootDomain}/api/v1/customer/login";
  static const register = "${SettingApi.rootDomain}/api/v1/customer/register";
  static const verify = "${SettingApi.rootDomain}/api/v1/customer/verify";
  static const forgotPass = "${SettingApi.rootDomain}/api/v1/customer/forgot";

  static const getInfoUser = "${SettingApi.rootDomain}/api/v1/customer/info";
  static const updatePassWord =
      "${SettingApi.rootDomain}/api/v1/customer/reset";
  static const loginGoogle =
      "${SettingApi.rootDomain}/api/v1/customer/google/login";

  static const updateInfo = "${SettingApi.rootDomain}/api/v1/customer/upinfo";
}

// PRODUCT API
class ProductApi {
  static const getListProducts =
      "${SettingApi.rootDomain}/api/v1/shop/product?page[size]={size}&page[number]={totalproduct}";
  static const getProductDetails =
      "${SettingApi.rootDomain}/api/v1/shop/product/{idProduct}";
  static const searchDefault =
      "${SettingApi.rootDomain}/suggestions?q={keyword}";
  static const productFlashsale =
      "${SettingApi.rootDomain}/api/v1/shop/product/flashsale";
}

class AddressApi {
  static const addAddress =
      "${SettingApi.rootDomain}/api/v1/customer/address_create";
  static const postEditAddress =
      "${SettingApi.rootDomain}/api/v1/customer/address_edit/{idAddress}";
  static const getListAddress =
      "${SettingApi.rootDomain}/api/v1/customer/address";
  static const deleteAddress =
      "${SettingApi.rootDomain}/api/v1/customer/address_delete/{idAddress}";
  static const getAddressId =
      "${SettingApi.rootDomain}/api/v1/customer/address_edit/{idAddress}";
}

class CategoryApi {
  static const getDetailCategory =
      "${SettingApi.rootDomain}/api/v1/shop/category/{idCategory}";
  static const getCategory = "${SettingApi.rootDomain}/api/v1/shop/category";

  static const getTopCategory =
      "${SettingApi.rootDomain}/api/v1/shop/category?lang=en&type=topcategories&page[size]=10";
}

class BrandApi {
  static const getListBrand =
      "${SettingApi.rootDomain}/api/v1/shop/brand?type=khudc";
  static const getTopBrand =
      "${SettingApi.rootDomain}/api/v1/shop/brand?lang=en&type=topbrand&page[size]=10";
  static const getDetailBrand =
      "${SettingApi.rootDomain}/api/v1/shop/brand/9ca4f2f5-0367-4d43-b154-de43b63abba0";
}

class ReviewApi {
  static const getAllReviews =
      "${SettingApi.rootDomain}/api/v1/shop/review/{idProduct}";

  static const postReviewProduct =
      "${SettingApi.rootDomain}/api/v1/shop/review";
}

class CartApi {
  static const getStatusOrders =
      "${SettingApi.rootDomain}/api/v1/shop/status/order";
  // orders
  static const getHistoryOrders =
      "${SettingApi.rootDomain}/api/v1/shop/orders/list/{idCustomer}?status={status}";
  static const checkOrderPrice =
      "${SettingApi.rootDomain}/api/v1/shop/orders/checkpromotionorder";
  static const getOderDetail =
      "${SettingApi.rootDomain}/api/v1/shop/orders/detail/{idCustomer}/{idOrder}";
}

class DeliveryApi {
  static const create =
      "${SettingApi.giaohangtietkiem}/services/shipment/order/?ver=1.5";

  static const shipmentFee =
      "${SettingApi.giaohangtietkiem}/services/shipment/fee";
}
