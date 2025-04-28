import 'package:flutter/material.dart' hide CarouselController;

// Fixed method name (small 's')
List<SliderModel> slidersFromJson(dynamic str) =>
    List<SliderModel>.from((str).map((x) => SliderModel.fromJson(x)));

class SliderModel {
  String? title;
  String? content;
  String? image;

  SliderModel({
    this.title,
    this.content,
    this.image,
  });

  SliderModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    image = json['image'];
  }
}
