// / Config class
class Config {
  static const String key = "ck_068cfada7a9de6e3b5ded88215ce9018bb988738";
  static const String secret = "cs_0117375f38ac68014bb7bf996ec3d49222e386c0";

  static const String apiURL = "ecobloomsbh.com";
  static const String apiEndPoint = "/wp-json/wc/v3";
  static const String categoriesURL = "products/categories";

  static String get fullCategoriesPath => "$apiEndPoint/$categoriesURL";

  static String productsURL ="products";
}
