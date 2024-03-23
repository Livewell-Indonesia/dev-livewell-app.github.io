// To parse this JSON data, do
//
//     final nutricoPlusAssetLoadingModel = nutricoPlusAssetLoadingModelFromJson(jsonString);

import 'dart:convert';

List<NutricoPlusAssetLoadingModel> nutricoPlusAssetLoadingModelFromJson(String str) => List<NutricoPlusAssetLoadingModel>.from(json.decode(str).map((x) => NutricoPlusAssetLoadingModel.fromJson(x)));

String nutricoPlusAssetLoadingModelToJson(List<NutricoPlusAssetLoadingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NutricoPlusAssetLoadingModel {
  String? key;
  String? language;
  String? title;
  String? video;
  String? belowPicture;

  NutricoPlusAssetLoadingModel({
    this.key,
    this.language,
    this.title,
    this.video,
    this.belowPicture,
  });

  factory NutricoPlusAssetLoadingModel.fromJson(Map<String, dynamic> json) => NutricoPlusAssetLoadingModel(
        key: json["key"],
        language: json["language"],
        title: json["title"],
        video: json["video"],
        belowPicture: json["below_picture"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "language": language,
        "title": title,
        "video": video,
        "below_picture": belowPicture,
      };
}
