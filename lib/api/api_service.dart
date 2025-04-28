// ApiService class
import 'dart:convert';
import 'package:grocery_app/config.dart';
import 'package:grocery_app/models/category_model.dart';
import 'package:grocery_app/models/customer_model.dart';
import 'package:grocery_app/models/product_item.dart';
import 'package:http/http.dart' as http;
import 'package:grocery_app/api/shared_service.dart';
import 'package:grocery_app/models/login_response_model.dart';
import 'package:grocery_app/models/slider_model.dart';
import 'package:grocery_app/models/user_model.dart';

class ApiService {
  static var client = http.Client();

  static Future<List<CategoryModel>?> getCategories() async {
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('${Config.key}:${Config.secret}'));

    Map<String, String> queryParams = {
      'parent': '0',
      'per_page': '100',
      'page': '1',
    };

    final uri = Uri.https(
      Config.apiURL,
      '${Config.apiEndPoint}/${Config.categoriesURL}',
      queryParams,
    );

    print("Requesting URL: $uri");

    try {
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
      );

      print("Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return categoriesFromJson(data);
      } else {
        print('Failed to load categories: ${response.body}');
        return null;
      }
    } catch (e) {
      print("Error fetching categories: $e");
      return null;
    }
  }

  static Future<List<ProductModel>?> getProducts({
    int? pageNumber,
    int? pageSize,
    String? strSearch,
    String? categoryId,
    String? sortOrder = "asc",
    String? sortBy,
    List<int>? productIds,
    final String? image,
  }) async {
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('${Config.key}:${Config.secret}'));

    Map<String, dynamic> queryString = {
      '_fields[]': [
        'id',
        'name',
        'price',
        'regular_price',
        'sale_price',
        'short_description',
        'images'
      ],
      'per_page': '100',
      'page': '1',
    };

    if (strSearch != null) {
      queryString["search"] = strSearch;
    }
    if (pageSize != null) {
      queryString["per_page"] = pageSize.toString();
    }
    if (pageNumber != null) {
      queryString["page"] = pageNumber.toString();
    }
    if (categoryId != null) {
      if (strSearch == "" || strSearch == null) {
        queryString["category"] = categoryId;
      }
    }
    if (sortBy != null) {
      queryString["orderBy"] = sortBy;
    }
    if (sortOrder != null) {
      queryString["order"] = sortOrder;
    }
    if (productIds != null) {
      queryString["include"] = productIds.join(",").toString();
    }

    final uri = Uri.https(
      Config.apiURL,
      '${Config.apiEndPoint}/${Config.productsURL}',
      queryString,
    );

    print("Requesting URL: $uri");

    try {
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
      );

      print("Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return productsFromJson(data);
      } else {
        print('Failed to load categories: ${response.body}');
        return null;
      }
    } catch (e) {
      print("Error fetching categories: $e");
      return null;
    }
  }

  static Future<ProductModel?> getProductDetails(productId) async {
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('${Config.key}:${Config.secret}'));

    Map<String, dynamic> queryString = {
      '_fields[]': [
        'id',
        'name',
        'price',
        'regular_price',
        'sale_price',
        'short_description',
        'images',
        'cross_sell_ids'
      ],
      'per_page': '100',
      'page': '1',
    };

    final uri = Uri.https(
      Config.apiURL,
      "${Config.apiEndPoint}/${Config.productsURL}/$productId",
      queryString,
    );

    print("Requesting URL: $uri");

    try {
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
      );

      print("Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProductModel.fromJson(data);
      } else {
        print('Failed to load product: ${response.body}');
        return null;
      }
    } catch (e) {
      print("Error fetching product: $e");
      return null;
    }
  }

  static Future<bool> registerUser(CustomerModel model) async {
    var authToken =
        base64.encode(utf8.encode('${Config.key}:${Config.secret}'));

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $authToken'
    };

    var url = Uri.https(
      Config.apiURL,
      Config.apiEndPoint + Config.customerURL,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.tojson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Map<String, dynamic> parseJwtToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = parts[1];
    var normalized = base64Url.normalize(payload);
    var payloadMap = json.decode(utf8.decode(base64Url.decode(normalized)));

    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  static Future<UserModel?> loginCustomer(
      String username, String password) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var url = Uri.https(
      Config.apiURL,
      Config.customerLoginURL,
    );

    try {
      var response = await client.post(url, headers: requestHeaders, body: {
        "username": username,
        "password": password,
      });

      print("Login Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonString = json.decode(response.body);

        print("Decoded JSON: $jsonString");

        if (jsonString["data"] == null) {
          throw Exception("Login failed: 'data' field is missing in response");
        }

        var data = jsonString["data"];

        var userModel = UserModel.fromJson(data);

        return userModel;
      } else {
        print('Login failed: ${response.body}');
        return null;
      }
    } catch (e) {
      print("Error during login: $e");
      return null;
    }
  }

//  static Future<List<SliderModel>?> getSliders() async {
//     final Map<String, String> requestHeaders = {
//       'Content-Type': 'application/json',
//     };

//     try {
//       var url = Uri.https(
//         Config.apiURL,
//         Config.sliderURL,
//       );

//       print("Requesting Sliders URL: $url");

//       final response = await client.get(url, headers: requestHeaders);

//       print("Sliders Response Code: ${response.statusCode}");

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return slidersFromJson(json.encode(data));
//         // Assuming `slidersFromJson` is your parsing function
//       } else {
//         print('Failed to load sliders: ${response.body}');
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching sliders: $e");
//       return null;
//     }
//   }

  static Future<List<SliderModel>> getSliders() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      SliderModel(image: 'https://via.placeholder.com/600x400'), // ← correct
      SliderModel(image: 'https://via.placeholder.com/600x400'),
    ];
  }

  static Future<List<ProductModel>> getProductslider() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      ProductModel(image: 'https://via.placeholder.com/150'), // ← correct
      ProductModel(image: 'https://via.placeholder.com/150'),
    ];
  }
}
