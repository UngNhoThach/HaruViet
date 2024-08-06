class SettingApi {
  static const rootDomain = "https://dev.sni.vn";
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
