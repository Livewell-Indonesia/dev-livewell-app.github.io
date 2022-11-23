import 'dart:convert';

class FoodsModel {
  List<Foods>? foods;

  FoodsModel({this.foods});

  factory FoodsModel.fromJson(Map<String, dynamic>? json) {
    return FoodsModel(
      foods: json == null
          ? []
          : List<Foods>.from(json["foods"].map((x) => Foods.fromJson(x))),
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

  Foods.copyWith(Foods food) {
    foodName = food.foodName;
    foodDescription = food.foodDescription;
    foodType = food.foodType;
    brandName = food.brandName;
    servings = food.servings;
    provider = food.provider;
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
  String? calories;
  String? carbohydrate;
  String? protein;
  String? fat;
  String? saturatedFat;
  String? transFat;
  String? monounsaturatedFat;
  String? polyunsaturatedFat;
  String? vitaminA;
  String? vitaminC;
  String? vitaminD;
  String? vitaminE;
  String? vitaminK;
  String? vitaminB1;
  String? vitaminB2;
  String? vitaminB3;
  String? vitaminB5;
  String? vitaminB6;
  String? vitaminB12;
  String? vitaminB7;
  String? vitaminB9;
  String? calcium;
  String? phosphorus;
  String? magnesium;
  String? sodium;
  String? potassium;
  String? chloride;
  String? iron;
  String? iodine;
  String? zinc;
  String? selenium;
  String? fluoride;
  String? chromium;
  String? molybdenum;

  String? cholesterol;

  String? fiber;

  String? measurementDescription;
  String? metricServingAmount;
  String? metricServingUnit;

  String? numberOfUnits;

  String? servingDescription;
  String? servingId;
  String? servingUrl;

  String? sugar;

  int get servingAmountInt {
    return double.parse(metricServingAmount ?? "0.0").round().toInt();
  }

  String get servingDesc {
    if (servingAmountInt == 0) {
      return "";
    }
    if (metricServingUnit == null) {
      return "";
    }
    return "($servingAmountInt $metricServingUnit)";
  }

  Servings(
      {this.calories,
      this.carbohydrate,
      this.protein,
      this.fat,
      this.saturatedFat,
      this.transFat,
      this.monounsaturatedFat,
      this.polyunsaturatedFat,
      this.vitaminA,
      this.vitaminC,
      this.vitaminD,
      this.vitaminE,
      this.vitaminK,
      this.vitaminB1,
      this.vitaminB2,
      this.vitaminB3,
      this.vitaminB5,
      this.vitaminB6,
      this.vitaminB12,
      this.vitaminB7,
      this.vitaminB9,
      this.calcium,
      this.phosphorus,
      this.magnesium,
      this.sodium,
      this.potassium,
      this.chloride,
      this.iron,
      this.iodine,
      this.zinc,
      this.selenium,
      this.fluoride,
      this.chromium,
      this.molybdenum,
      this.cholesterol,
      this.fiber,
      this.measurementDescription,
      this.metricServingAmount,
      this.metricServingUnit,
      this.numberOfUnits,
      this.servingDescription,
      this.servingId,
      this.servingUrl,
      this.sugar});

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
    vitaminE = json['vitamin_e'];
    vitaminK = json['vitamin_k'];
    vitaminB1 = json['vitamin_b1'];
    vitaminB2 = json['vitamin_b2'];
    vitaminB3 = json['vitamin_b3'];
    vitaminB5 = json['vitamin_b5'];
    vitaminB6 = json['vitamin_b6'];
    vitaminB12 = json['vitamin_b12'];
    vitaminB7 = json['vitamin_b7'];
    vitaminB9 = json['vitamin_b9'];
    calcium = json['calcium'];
    phosphorus = json['phosphorus'];
    magnesium = json['magnesium'];
    sodium = json['sodium'];
    potassium = json['potassium'];
    chloride = json['chloride'];
    iron = json['iron'];
    iodine = json['iodine'];
    zinc = json['zinc'];
    selenium = json['selenium'];
    fluoride = json['fluoride'];
    chromium = json['chromium'];
    molybdenum = json['molybdenum'];
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
