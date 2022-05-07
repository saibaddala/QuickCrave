class AppConstants {
  static const String appName = "Foodart";
  static const int appVersion = 1;

  // static const String baseUrl = "http://10.0.2.2:8000";
  static const String baseUrl = "https://mvs.bslmeiyu.com";
  static const String popularProductsUri = "/api/v1/products/popular";
  static const String recommendedProductsUri = "/api/v1/products/recommended";
  static const String uploadUrl = "/uploads/";

  static const String signUpUrl = "/api/v1/auth/register";
  static const String signInUrl = "/api/v1/auth/login";
  static const String userInfoUrl = "/api/v1/customer/info";

  static const String userToken = "";
  static const String userPhoneNumber = "";
  static const String userPassword = "";

  static const String userAddress = "user_address";
  static const String addUserAddress = "/api/v1/customer/address/add";
  static const String addressListUri = "/api/v1/customer/address/list";
  static const String geoCodeUri = "/api/v1/config/geocode-api";

  static const String storedCartListBcozNotCheckedOut = "Stored-Cart-List";
  static const String cartHistoryList = "Cart-History-List";
}
