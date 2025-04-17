import 'package:grocery_app/models/category_model.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb

List<ProductModel> productsFromJson(dynamic str) =>
    List<ProductModel>.from((str).map((x) => ProductModel.fromJson(x)));

class ProductModel {
  int? productId;
  String? productName;
  String? description;
  String? price;
  String? regularPrice;
  String? salePrice;
  List<ImageModel>? images;
  List<int>? relatedId;

  ProductModel({
    this.productId,
    this.productName,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.images,
    this.relatedId,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['id'];
    productName = json['name'];
    description = json['short_description']
        ?.toString()
        .replaceAll(RegExp(r'<\/?[^>]+>'), '');
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];

    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(ImageModel.fromJson(v));
      });
    }
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
