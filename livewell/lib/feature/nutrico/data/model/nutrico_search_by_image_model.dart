// To parse this JSON data, do
//
//     final nutricoSearchByImageModel = nutricoSearchByImageModelFromJson(jsonString);

import 'dart:convert';

NutricoSearchByImageModel nutricoSearchByImageModelFromJson(String str) => NutricoSearchByImageModel.fromJson(json.decode(str));

String nutricoSearchByImageModelToJson(NutricoSearchByImageModel data) => json.encode(data.toJson());

class NutricoSearchByImageModel {
  Response? response;

  NutricoSearchByImageModel({
    this.response,
  });

  factory NutricoSearchByImageModel.fromJson(Map<String, dynamic> json) => NutricoSearchByImageModel(
        response: json["response"] == null ? null : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response?.toJson(),
      };
}

class Response {
  String? imageUrl;
  String? foodName;

  Response({
    this.imageUrl,
    this.foodName,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        imageUrl: json["image_url"],
        foodName: json["food_name"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "food_name": foodName,
      };
}
