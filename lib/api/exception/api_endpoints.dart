class SettingApi {
  static const rootDomain = "https://dev.sni.vn";
  static const rootDomainIsoft = "https://apihrm.issvn.net";
  static const getCountryList = "$rootDomainIsoft/apimobile/countryList";
  static const getDistrictList =
      "$rootDomainIsoft/apimobile/districtList?countryId={countryId}";
  static const getWardList =
      "$rootDomainIsoft/apimobile/wardList?districtId={districtId}";
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

  /// upinfo
}

// PRODUCT API
class ProductApi {}
