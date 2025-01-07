class SettingApi {
  static const domainRoot = "https://dns.sni.vn/haruviet";
  static const giaohangtietkiem = "https://services.giaohangtietkiem.vn";
  static const getCountryList = "/api/v1/shop/province?id_country={id_country}";
  static const getDistrictList =
      "/api/v1/shop/district?id_province={id_province}";
  static const getWardList = "/api/v1/shop/ward/?id_district={id_district}";
}

// CUSTOMERS API
class CustomersApi {
  static const login = "/api/v1/customer/login";
  static const register = "/api/v1/customer/register";
  static const verify = "/api/v1/customer/verify";
  static const forgotPass = "/api/v1/customer/forgot";

  static const getInfoUser = "/api/v1/customer/info";
  static const updatePassWord = "/api/v1/customer/reset";
  static const loginGoogle = "/api/v1/customer/google/login";

  static const updateInfo = "/api/v1/customer/upinfo";
}

// PRODUCT API
class ProductApi {
  static const getListProducts =
      "/api/v1/shop/product?page[size]={size}&page[number]={totalproduct}";
  static const getProductDetails = "/api/v1/shop/product/{idProduct}";
  static const searchDefault = "/suggestions?q={keyword}";
}

class AddressApi {
  static const addAddress = "/api/v1/customer/address_create";
  static const postEditAddress = "/api/v1/customer/address_edit/{idAddress}";
  static const getListAddress = "/api/v1/customer/address";
  static const deleteAddress = "/api/v1/customer/address_delete/{idAddress}";
  static const getAddressId = "/api/v1/customer/address_edit/{idAddress}";
  static const setAddressDefault = "/api/v1/customer/set_addressdefault";
}

class CategoryApi {
  static const getDetailCategory = "/api/v1/shop/category/{idCategory}";
  static const getCategory = "/api/v1/shop/category";

  static const getTopCategory =
      "/api/v1/shop/category?lang=en&type=topcategories&page[size]=10";
}

class BrandApi {
  static const getListBrand =
      "/api/v1/shop/brand?lang=en&page[size]={pageSize}&page[number]={pageNumber}";

  static const getTopBrand =
      "/api/v1/shop/brand?lang=en&type=topbrand&page[size]={pageSize}";

  static const getDetailBrand =
      "/api/v1/shop/brand/9ca4f2f5-0367-4d43-b154-de43b63abba0";
}

class ReviewApi {
  static const getAllReviews = "/api/v1/shop/review/{idProduct}";

  static const postReviewProduct = "/api/v1/shop/review";
}

class CartApi {
  static const getStatusOrders = "/api/v1/shop/status/order";
  // orders
  static const getHistoryOrders =
      "/api/v1/shop/orders/list/{idCustomer}?status={status}";
  static const checkOrderPrice = "/api/v1/shop/orders/checkpromotionorder";
  static const getOderDetail =
      "/api/v1/shop/orders/detail/{idCustomer}/{idOrder}";

  //cart order
  static const createOrder = "/api/v1/customer/create_order";
  static const getCartOrder = "/api/v1/shop/cart";
  static const removeItemInCart = "/api/v1/shop/cart/removeditem";
  static const addCartOrder = "/api/v1/shop/cart/add";
  static const updateCartOrder = "/api/v1/shop/cart/update";
  static const checkShippingFee = "/api/v1/shop/orders/checkshipping";
}

class ShippingApi {
  static const paymentMethods = "/api/v1/shop/paymentmethod";
  static const shippingMethods = "/api/v1/shop/shippingmethod";
}

class DeliveryApi {
  static const create =
      "${SettingApi.giaohangtietkiem}/services/shipment/order/?ver=1.5";

  static const shipmentFee =
      "${SettingApi.giaohangtietkiem}/services/shipment/fee";
}
