import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';

import '../../data/model/foods_model.dart';

class AddMealParams {
  String? mealName;
  String? mealBrand;
  String? mealNutritions;
  String? mealType;
  String? restaurantName;
  String? mealServings;
  Nutritions? nutritions;
  String? mealAt;
  String? numberOfUnits;

  AddMealParams(
      {mealName,
      mealBrand,
      mealNutritions,
      mealType,
      nutritions,
      mealAt,
      mealServings,
      numberOfUnits});

  AddMealParams.asParams(
      Foods food, String numberOfServings, MealTime mealTime, String time) {
    mealName = food.foodName;
    mealBrand = food.brandName;
    mealNutritions = null;
    mealType = mealTime.name;
    restaurantName = food.brandName;
    nutritions = Nutritions.asParams(food.servings![0], numberOfServings);
    mealServings =
        "$numberOfServings ${food.servings?[0].measurementDescription ?? ""}";
    numberOfUnits = numberOfServings;
    mealAt = time;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meal_name'] = mealName;
    data['meal_brand'] = mealBrand;
    data['meal_nutritions'] = mealNutritions;
    data['meal_type'] = mealType;
    if (nutritions != null) {
      data['nutritions'] = nutritions!.toJson();
    }
    data['meal_at'] = mealAt;
    data['meal_servings'] = mealServings;
    data['number_of_units'] = numberOfUnits;
    return data;
  }
}

class Nutritions {
  Nutrition? calories;
  Nutrition? carbohydrates;
  Nutrition? protein;
  Nutrition? fat;
  Nutrition? saturatedFat;
  Nutrition? transfat;
  Nutrition? monosaturatedFat;
  Nutrition? polyunsaturatedFat;
  Nutrition? vitaminA;
  Nutrition? vitaminC;
  Nutrition? vitaminD;
  Nutrition? vitaminE;
  Nutrition? vitaminK;
  Nutrition? vitaminB1;
  Nutrition? vitaminB2;
  Nutrition? vitaminB3;
  Nutrition? vitaminB5;
  Nutrition? vitaminB6;
  Nutrition? vitaminB12;
  Nutrition? vitaminB7;
  Nutrition? vitaminB9;
  Nutrition? calcium;
  Nutrition? phosphorus;
  Nutrition? magnesium;
  Nutrition? sodium;
  Nutrition? potassium;
  Nutrition? chloride;
  Nutrition? iron;
  Nutrition? iodine;
  Nutrition? zinc;
  Nutrition? selenium;
  Nutrition? fluoride;
  Nutrition? chromium;
  Nutrition? molybdenum;

  Nutritions({
    carbohydrates,
    protein,
    fat,
    saturatedFat,
    transfat,
    monosaturatedFat,
    polyunsaturatedFat,
    vitaminA,
    vitaminC,
    vitaminD,
    calcium,
    sodium,
    iron,
    calories,
    potassium,
    vitaminE,
    vitaminK,
    vitaminB1,
    vitaminB2,
    vitaminB3,
    vitaminB5,
    vitaminB6,
    vitaminB12,
    vitaminB7,
    vitaminB9,
    phosphorus,
    magnesium,
    chloride,
    iodine,
    zinc,
    selenium,
    fluoride,
    chromium,
    molybdenum,
  });

  Nutritions.asParams(Servings servings, String numberOfServings) {
    carbohydrates = Nutrition.asParams(
        double.parse(servings.carbohydrate ?? "0") *
            num.parse(numberOfServings),
        unit: "g");
    protein = Nutrition.asParams(
        double.parse(servings.protein ?? "0") * num.parse(numberOfServings),
        unit: "g");
    fat = Nutrition.asParams(
        double.parse(servings.fat ?? "0") * num.parse(numberOfServings),
        unit: "g");
    saturatedFat = Nutrition.asParams(
        double.parse(servings.saturatedFat ?? "0") *
            num.parse(numberOfServings),
        unit: "g");
    transfat = Nutrition.asParams(
        double.parse(servings.transFat ?? "0") * num.parse(numberOfServings),
        unit: "g");
    monosaturatedFat = Nutrition.asParams(
        double.parse(servings.monounsaturatedFat ?? "0") *
            num.parse(numberOfServings),
        unit: "g");
    polyunsaturatedFat = Nutrition.asParams(
        double.parse(servings.polyunsaturatedFat ?? "0") *
            num.parse(numberOfServings),
        unit: "g");
    vitaminA = Nutrition.asParams(
        double.parse(servings.vitaminA ?? "0") * num.parse(numberOfServings),
        unit: 'mcg');
    vitaminC = Nutrition.asParams(
        double.parse(servings.vitaminC ?? "0") * num.parse(numberOfServings),
        unit: 'mg');

    vitaminD = Nutrition.asParams(
        double.parse(servings.vitaminD ?? "0") * num.parse(numberOfServings),
        unit: 'mcg');
    calcium = Nutrition.asParams(
        double.parse(servings.calcium ?? "0") * num.parse(numberOfServings),
        unit: 'mg');

    sodium = Nutrition.asParams(
        double.parse(servings.sodium ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    iron = Nutrition.asParams(
        double.parse(servings.iron ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    calories = Nutrition.asParams(
        double.parse(servings.calories ?? "0") * num.parse(numberOfServings));
    potassium = Nutrition.asParams(
        double.parse(servings.potassium ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    vitaminE = Nutrition.asParams(
        double.parse(servings.vitaminE ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    vitaminK = Nutrition.asParams(
        double.parse(servings.vitaminK ?? "0") * num.parse(numberOfServings),
        unit: 'mcg');
    vitaminB1 = Nutrition.asParams(
        double.parse(servings.vitaminB1 ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    vitaminB2 = Nutrition.asParams(
        double.parse(servings.vitaminB2 ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    vitaminB3 = Nutrition.asParams(
        double.parse(servings.vitaminB3 ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    vitaminB5 = Nutrition.asParams(
        double.parse(servings.vitaminB5 ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    vitaminB6 = Nutrition.asParams(
        double.parse(servings.vitaminB6 ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    vitaminB12 = Nutrition.asParams(
        double.parse(servings.vitaminB12 ?? "0") * num.parse(numberOfServings),
        unit: 'mcg');
    vitaminB7 = Nutrition.asParams(
        double.parse(servings.vitaminB7 ?? "0") * num.parse(numberOfServings),
        unit: 'mcg');

    vitaminB9 = Nutrition.asParams(
        double.parse(servings.vitaminB9 ?? "0") * num.parse(numberOfServings),
        unit: 'mcg');
    phosphorus = Nutrition.asParams(
        double.parse(servings.phosphorus ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    magnesium = Nutrition.asParams(
        double.parse(servings.magnesium ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    chloride = Nutrition.asParams(
        double.parse(servings.chloride ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    iodine = Nutrition.asParams(
        double.parse(servings.iodine ?? "0") * num.parse(numberOfServings),
        unit: 'mcg');
    zinc = Nutrition.asParams(
        double.parse(servings.zinc ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    selenium = Nutrition.asParams(
        double.parse(servings.selenium ?? "0") * num.parse(numberOfServings),
        unit: 'mcg');
    fluoride = Nutrition.asParams(
        double.parse(servings.fluoride ?? "0") * num.parse(numberOfServings),
        unit: 'mg');
    chromium = Nutrition.asParams(
        double.parse(servings.chromium ?? "0") * num.parse(numberOfServings),
        unit: 'mcg');
    molybdenum = Nutrition.asParams(
        double.parse(servings.molybdenum ?? "0") * num.parse(numberOfServings),
        unit: 'mcg');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (carbohydrates != null) {
      data['carbohydrates'] = carbohydrates!.toJson();
    }
    if (protein != null) {
      data['protein'] = protein!.toJson();
    }
    if (fat != null) {
      data['fat'] = fat!.toJson();
    }
    if (saturatedFat != null) {
      data['saturated_fat'] = saturatedFat!.toJson();
    }
    if (transfat != null) {
      data['transfat'] = transfat!.toJson();
    }
    if (monosaturatedFat != null) {
      data['monosaturated_fat'] = monosaturatedFat!.toJson();
    }
    if (polyunsaturatedFat != null) {
      data['polyunsaturated_fat'] = polyunsaturatedFat!.toJson();
    }
    if (vitaminA != null) {
      data['vitamin_a'] = vitaminA!.toJson();
    }
    if (vitaminC != null) {
      data['vitamin_c'] = vitaminC!.toJson();
    }
    if (vitaminD != null) {
      data['vitamin_d'] = vitaminD!.toJson();
    }
    if (calcium != null) {
      data['calcium'] = calcium!.toJson();
    }
    if (iron != null) {
      data['iron'] = iron!.toJson();
    }
    if (calories != null) {
      data['calories'] = calories!.toJson();
    }
    return data;
  }
}

class Nutrition {
  int? value;
  String? unit;

  Nutrition({value, unit});

  Nutrition.asParams(double value, {String unit = 'g'}) {
    this.value = value.toInt();
    this.unit = unit;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    return data;
  }
}
