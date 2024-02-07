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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (foods != null) {
      data['foods'] = foods!.map((v) => v.toJson()).toList();
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

  String desc() {
    final calories = servings?[0].calories ?? "0";
    final servingDescription = servings?[0].servingDescription == null
        ? ""
        : ", ${servings?[0].servingDescription}";
    return "$calories cal$servingDescription";
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

  factory Foods.fromJson(Map<String, dynamic> json) {
    if (json['servings'] == null) {}
    return Foods(
      foodName: json['food_name'],
      foodDescription: json['food_description'],
      foodType: json['food_type'],
      brandName: json['brand_name'],
      servings: mapServings(json['servings']),
      provider: json['provider'],
    );
  }

  static List<Servings> mapServings(String data) {
    if (data == null) {
      return [];
    }
    var jsonData = json.decode(data.replaceAll("'", '"'));
    if (jsonData is Map<String, dynamic>) {
      jsonData = [jsonData];
    } else {
      jsonData = jsonData as List<dynamic>;
    }
    if (jsonData != null) {
      return jsonData.map<Servings>((json) => Servings.fromJson(json)).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['food_name'] = foodName;
    data['food_description'] = foodDescription;
    data['food_type'] = foodType;
    data['brand_name'] = brandName;
    if (servings != null) {
      data['servings'] = servings!.map((v) => v.toJson()).toList();
    }
    data['provider'] = provider;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calcium'] = calcium;
    data['calories'] = calories;
    data['carbohydrate'] = carbohydrate;
    data['cholesterol'] = cholesterol;
    data['fat'] = fat;
    data['fiber'] = fiber;
    data['iron'] = iron;
    data['measurement_description'] = measurementDescription;
    data['metric_serving_amount'] = metricServingAmount;
    data['metric_serving_unit'] = metricServingUnit;
    data['monounsaturated_fat'] = monounsaturatedFat;
    data['number_of_units'] = numberOfUnits;
    data['polyunsaturated_fat'] = polyunsaturatedFat;
    data['potassium'] = potassium;
    data['protein'] = protein;
    data['saturated_fat'] = saturatedFat;
    data['serving_description'] = servingDescription;
    data['serving_id'] = servingId;
    data['serving_url'] = servingUrl;
    data['sodium'] = sodium;
    data['sugar'] = sugar;
    data['trans_fat'] = transFat;
    data['vitamin_a'] = vitaminA;
    data['vitamin_c'] = vitaminC;
    data['vitamin_d'] = vitaminD;
    return data;
  }
}
