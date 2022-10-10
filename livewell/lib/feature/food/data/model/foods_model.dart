import 'dart:convert';

class FoodsModel {
  List<Foods>? foods;

  FoodsModel({this.foods});

  factory FoodsModel.fromJson(Map<String, dynamic> json) {
    return FoodsModel(
      foods: List<Foods>.from(json["foods"].map((x) => Foods.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Foods {
  String? foodName;
  String? foodDescription;
  String? foodType;
  String? brandName;
  List<Servings>? servings;
  String? provider;

  String get foodDesc {
    return "${(servings?[0].calories ?? "0")} cal, ${(servings?[0].servingDescription ?? "")} ${brandName ?? ""}";
  }

  Foods(
      {this.foodName,
      this.foodDescription,
      this.foodType,
      this.brandName,
      this.servings,
      this.provider});

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        foodName: json['food_name'] as String?,
        foodDescription: json['food_description'] as String?,
        foodType: json['food_type'] as String?,
        brandName: json['brand_name'] as String?,
        servings: // check if json['servings'] is an object or array
            json['servings'] is Map<String, dynamic>
                ? [Servings.fromJson(json['servings'] as Map<String, dynamic>)]
                : List<Servings>.from(
                    json['servings'].map((x) => Servings.fromJson(x))),
        provider: json['provider'] as String?,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_name'] = this.foodName;
    data['food_description'] = this.foodDescription;
    data['food_type'] = this.foodType;
    data['brand_name'] = this.brandName;
    if (this.servings != null) {
      data['servings'] = this.servings!.map((v) => v.toJson()).toList();
    }
    data['provider'] = this.provider;
    return data;
  }
}

class Servings {
  String? calcium;
  String? calories;
  String? carbohydrate;
  String? cholesterol;
  String? fat;
  String? fiber;
  String? iron;
  String? measurementDescription;
  String? metricServingAmount;
  String? metricServingUnit;
  String? monounsaturatedFat;
  String? numberOfUnits;
  String? polyunsaturatedFat;
  String? potassium;
  String? protein;
  String? saturatedFat;
  String? servingDescription;
  String? servingId;
  String? servingUrl;
  String? sodium;
  String? sugar;
  String? transFat;
  String? vitaminA;
  String? vitaminC;
  String? vitaminD;

  Servings(
      {this.calcium,
      this.calories,
      this.carbohydrate,
      this.cholesterol,
      this.fat,
      this.fiber,
      this.iron,
      this.measurementDescription,
      this.metricServingAmount,
      this.metricServingUnit,
      this.monounsaturatedFat,
      this.numberOfUnits,
      this.polyunsaturatedFat,
      this.potassium,
      this.protein,
      this.saturatedFat,
      this.servingDescription,
      this.servingId,
      this.servingUrl,
      this.sodium,
      this.sugar,
      this.transFat,
      this.vitaminA,
      this.vitaminC,
      this.vitaminD});

  Servings.fromJson(Map<String, dynamic> json) {
    calcium = json['calcium'];
    calories = json['calories'];
    carbohydrate = json['carbohydrate'];
    cholesterol = json['cholesterol'];
    fat = json['fat'];
    fiber = json['fiber'];
    iron = json['iron'];
    measurementDescription = json['measurement_description'];
    metricServingAmount = json['metric_serving_amount'];
    metricServingUnit = json['metric_serving_unit'];
    monounsaturatedFat = json['monounsaturated_fat'];
    numberOfUnits = json['number_of_units'];
    polyunsaturatedFat = json['polyunsaturated_fat'];
    potassium = json['potassium'];
    protein = json['protein'];
    saturatedFat = json['saturated_fat'];
    servingDescription = json['serving_description'];
    servingId = json['serving_id'];
    servingUrl = json['serving_url'];
    sodium = json['sodium'];
    sugar = json['sugar'];
    transFat = json['trans_fat'];
    vitaminA = json['vitamin_a'];
    vitaminC = json['vitamin_c'];
    vitaminD = json['vitamin_d'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calcium'] = this.calcium;
    data['calories'] = this.calories;
    data['carbohydrate'] = this.carbohydrate;
    data['cholesterol'] = this.cholesterol;
    data['fat'] = this.fat;
    data['fiber'] = this.fiber;
    data['iron'] = this.iron;
    data['measurement_description'] = this.measurementDescription;
    data['metric_serving_amount'] = this.metricServingAmount;
    data['metric_serving_unit'] = this.metricServingUnit;
    data['monounsaturated_fat'] = this.monounsaturatedFat;
    data['number_of_units'] = this.numberOfUnits;
    data['polyunsaturated_fat'] = this.polyunsaturatedFat;
    data['potassium'] = this.potassium;
    data['protein'] = this.protein;
    data['saturated_fat'] = this.saturatedFat;
    data['serving_description'] = this.servingDescription;
    data['serving_id'] = this.servingId;
    data['serving_url'] = this.servingUrl;
    data['sodium'] = this.sodium;
    data['sugar'] = this.sugar;
    data['trans_fat'] = this.transFat;
    data['vitamin_a'] = this.vitaminA;
    data['vitamin_c'] = this.vitaminC;
    data['vitamin_d'] = this.vitaminD;
    return data;
  }
}
