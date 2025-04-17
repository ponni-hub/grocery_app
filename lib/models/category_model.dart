import 'package:flutter/foundation.dart'; // for kIsWeb

List<CategoryModel> categoriesFromJson(dynamic str) =>
    List<CategoryModel>.from((str).map((x) => CategoryModel.fromJson(x)));

class CategoryModel {
  int? categoryId;
  String? categoryName;
  ImageModel? image;

  CategoryModel({this.categoryId, this.categoryName, this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['id'];
    categoryName = json['name']?.replaceAll("&amp;", "&");
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
  }
}

class ImageModel {
  String? url;

  ImageModel({this.url});

  ImageModel.fromJson(Map<String, dynamic> json) {
    String rawUrl = json['src'] ?? '';

    // Handle protocol-relative URLs
    if (rawUrl.startsWith('//')) {
      rawUrl = 'https:' + rawUrl;
    }

    // Use local proxy if on Flutter Web
    if (kIsWeb) {
      const corsProxy = "http://localhost:8080/";
      url = corsProxy + rawUrl;
    } else {
      url = rawUrl;
    }
  }
}
