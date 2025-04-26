// ApiService class
import 'dart:convert';
import 'package:grocery_app/config.dart';
import 'package:grocery_app/models/category_model.dart';
import 'package:grocery_app/models/customer_model.dart';
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
    List<int>? productIds,
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

  static Future<bool> registerUser(CustomerModel model) async {
    // Encode the basic auth token properly
    var authToken =
        base64.encode(utf8.encode('${Config.key}:${Config.secret}'));

    // Create proper request headers
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $authToken'
    };
    var url = Uri.https(
      Config.apiURL,
      Config.apiEndPoint + Config.customerURL,
    );

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.tojson()));

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }




// static Future<bool> loginCustomer(String username,String password) async {

//     // Create proper request headers
//     Map<String, String> requestHeaders = {
//       'Content-Type': 'application/x-www-form-urlencoded',
//     };
//     var url = Uri.https(
//       Config.apiURL,
//       Config.apiEndPoint + Config.customerLoginURL,
//     );

//     var response = await client.post(url,
//         headers: requestHeaders, body: {
//           "username":username,
//           "password":password,

//         }
        
//         );

//     if (response.statusCode == 200) {

// var jsonString =json.decoder(response.body);
// var decodedData = parsejwt(jsonString["token"]);

// var id =decodedData["data"]["user"]["id"].toString();
// jsonString["id"]=id; 
//       return true;  
//     } else {
//       return false;
//     }
//   }

// static Map <String, dynamic> parsejwt (String token){

//   final parts = token .split('.');
//   if(parts .length !=3){
//     throw Exception('Invalid token');
//   }

//   final payload =_decodeBase64{parts[1]};
//   final payloadMap = json.decode(payload);
//   if(payloadMap is! Map<String,dynamic>){
//     throw Exception('invalid payload');
//   }
//   return payloadMap;
//  }
// static String _decodeBase64(String str){
//   String output =str.replaceAll('.', '+').replaceAll('_', '/');

// switch (output.length % 4){
//   case 0;
//     break;
//     case 2;
//     output +='==';
//     break;
//     case 3;
//     output += '-';
//     break;
//     default;
//      throw Exception('illegal base64url string!"');

// }

// return utf8.decode(base64Url.decode(output));

// }



}
