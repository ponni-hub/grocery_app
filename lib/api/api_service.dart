// ApiService class
import 'dart:convert';
import 'package:grocery_app/config.dart';
import 'package:grocery_app/models/category_model.dart';
import 'package:grocery_app/models/product_item.dart';
import 'package:http/http.dart' as http;

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

      print("Response Code: \${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return categoriesFromJson(data);
      } else {
        print('Failed to load categories: \${response.body}');
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
List<int>?productIds,

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

    if(productIds != null){
      queryString["include"]=productIds.join(",").toString();
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

      print("Response Code: \${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return productsFromJson(data);
      } else {
        print('Failed to load categories: \${response.body}');
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

      print("Response Code: \${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProductModel.fromJson(data);
      } else {
        print('Failed to load categories: \${response.body}');
        return null;
      }
    } catch (e) {
      print("Error fetching categories: $e");
      return null;
    }
  }
}

