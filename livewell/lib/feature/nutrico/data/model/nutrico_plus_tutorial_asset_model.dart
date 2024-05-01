// To parse this JSON data, do
//
//     final nutricoPlusTutorialAssetModel = nutricoPlusTutorialAssetModelFromJson(jsonString);

import 'dart:convert';

NutricoPlusTutorialAssetModel nutricoPlusTutorialAssetModelFromJson(String str) => NutricoPlusTutorialAssetModel.fromJson(json.decode(str));

String nutricoPlusTutorialAssetModelToJson(NutricoPlusTutorialAssetModel data) => json.encode(data.toJson());

class NutricoPlusTutorialAssetModel {
  NutricoImage? nutricoImage;

  NutricoPlusTutorialAssetModel({
    this.nutricoImage,
  });

  factory NutricoPlusTutorialAssetModel.fromJson(Map<String, dynamic> json) => NutricoPlusTutorialAssetModel(
        nutricoImage: json["nutrico_image"] == null ? null : NutricoImage.fromJson(json["nutrico_image"]),
      );

  Map<String, dynamic> toJson() => {
        "nutrico_image": nutricoImage?.toJson(),
      };
}

class NutricoImage {
  String? key;
  String? module;
  String? title;
  String? subTitle;
  String? image1;
  String? example1Text;
  String? image2;
  String? example2Text;
  String? image3;
  String? example3Text;

  NutricoImage({
    this.key,
    this.module,
    this.title,
    this.subTitle,
    this.image1,
    this.example1Text,
    this.image2,
    this.example2Text,
    this.image3,
    this.example3Text,
  });

  factory NutricoImage.fromJson(Map<String, dynamic> json) => NutricoImage(
        key: json["key"],
        module: json["module"],
        title: json["title"],
        subTitle: json["sub_title"],
        image1: json["image_1"],
        example1Text: json["example_1_text"],
        image2: json["image_2"],
        example2Text: json["example_2_text"],
        image3: json["image_3"],
        example3Text: json["example_3_text"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "module": module,
        "title": title,
        "sub_title": subTitle,
        "image_1": image1,
        "example_1_text": example1Text,
        "image_2": image2,
        "example_2_text": example2Text,
        "image_3": image3,
        "example_3_text": example3Text,
      };
}
