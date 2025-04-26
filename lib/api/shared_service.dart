import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:grocery_app/models/login_response_model.dart';
import 'dart:convert';
class SharedService {
  static Future<bool> isLoggedIn() async {
    return await APICacheManager().isAPICacheKeyExist("login_details");
  }

  static Future<void> setLoginDetails(LoginResponseModel model) async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "login_details",
      syncData: jsonEncode(model.toJson()),
    );

    await APICacheManager().addCacheData(cacheModel);
  }

  static Future<LoginResponseModel> getLoginDetails() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");

      return loginResponseJson(cacheData.syncData);
    }

    // Option 1: Throw an exception if no cache is found
    throw Exception('Login details not found in cache');

    // Option 2: Return a default empty LoginResponseModel object
    // return LoginResponseModel(
    //   token: '',
    //   userEmail: '',
    //   userNicename: '',
    //   userDisplayName: '',
    //   id: '',
    // );
  }
}
