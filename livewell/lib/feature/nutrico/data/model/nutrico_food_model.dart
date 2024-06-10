// To parse this JSON data, do
//
//     final nutricoFoodModel = nutricoFoodModelFromJson(jsonString);

import 'dart:convert';

import 'package:livewell/feature/food/data/model/foods_model.dart';

NutricoFoodModel nutricoFoodModelFromJson(String str) => NutricoFoodModel.fromJson(json.decode(str));

String nutricoFoodModelToJson(NutricoFoodModel data) => json.encode(data.toJson());

class NutricoFoodModel {
  Response? response;

  NutricoFoodModel({
    this.response,
  });

  factory NutricoFoodModel.fromJson(Map<String, dynamic> json) => NutricoFoodModel(
        response: json["response"] == null ? null : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response?.toJson(),
      };
}

class Response {
  String? imageUrl;
  String? foodName;
  FoodEstimation? foodEstimation;
  String? searchReferenceId;

  Response({
    this.imageUrl,
    this.foodName,
    this.foodEstimation,
    this.searchReferenceId,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        imageUrl: json["image_url"],
        foodName: json["food_name"],
        foodEstimation: json["food_estimation"] == null ? null : FoodEstimation.fromJson(json["food_estimation"]),
        searchReferenceId: json["search_reference_id"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "food_name": foodName,
        "food_estimation": foodEstimation?.toJson(),
        "search_reference_id": searchReferenceId,
      };
}

class FoodEstimation {
  String? score;
  String? foodName;
  String? originalInput;
  String? foodDescription;
  String? q1AiInterpret;
  String? q2Allergy;
  String? foodType;
  String? brandName;
  Servings? servings;
  String? provider;
  String? referenceId;

  FoodEstimation({
    this.score,
    this.foodName,
    this.originalInput,
    this.foodDescription,
    this.q1AiInterpret,
    this.q2Allergy,
    this.foodType,
    this.brandName,
    this.servings,
    this.provider,
    this.referenceId,
  });

  factory FoodEstimation.fromJson(Map<String, dynamic> json) => FoodEstimation(
        score: json["score"],
        foodName: json["food_name"],
        originalInput: json["original_input"],
        foodDescription: json["food_description"],
        q1AiInterpret: json["q1_ai_interpret"],
        q2Allergy: json["q2_allergy"],
        foodType: json["food_type"],
        brandName: json["brand_name"],
        servings: json["servings"] == null ? null : Servings.fromJson(json["servings"]),
        provider: json["provider"],
        referenceId: json["reference_id"],
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "food_name": foodName,
        "original_input": originalInput,
        "food_description": foodDescription,
        "q1_ai_interpret": q1AiInterpret,
        "q2_allergy": q2Allergy,
        "food_type": foodType,
        "brand_name": brandName,
        "servings": servings?.toJson(),
        "provider": provider,
        "reference_id": referenceId,
      };
}
