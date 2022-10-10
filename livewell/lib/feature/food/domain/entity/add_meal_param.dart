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

  AddMealParams(
      {mealName,
      mealBrand,
      mealNutritions,
      mealType,
      nutritions,
      mealAt,
      mealServings});

  AddMealParams.asParams(Foods food, MealTime mealTime, String time) {
    mealName = food.foodName;
    mealBrand = food.brandName;
    mealNutritions = null;
    mealType = mealTime.name;
    restaurantName = food.brandName;
    nutritions = Nutritions.asParams(food.servings![0]);
    mealServings = food.servings![0].servingDescription;
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
    return data;
  }
}

class Nutritions {
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
  Nutrition? calcium;
  Nutrition? sodium;
  Nutrition? chloride;
  Nutrition? iron;
  Nutrition? calories;
  Nutrition? potassium;

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
  });

  Nutritions.asParams(Servings servings) {
    carbohydrates = Nutrition.asParams(
        double.parse(servings.carbohydrate ?? "0"),
        unit: "g");
    protein =
        Nutrition.asParams(double.parse(servings.protein ?? "0"), unit: "g");
    fat = Nutrition.asParams(double.parse(servings.fat ?? "0"), unit: "g");
    saturatedFat = Nutrition.asParams(
        double.parse(servings.saturatedFat ?? "0"),
        unit: "g");
    transfat =
        Nutrition.asParams(double.parse(servings.transFat ?? "0"), unit: "g");
    monosaturatedFat = Nutrition.asParams(
        double.parse(servings.monounsaturatedFat ?? "0"),
        unit: "g");
    polyunsaturatedFat = Nutrition.asParams(
        double.parse(servings.polyunsaturatedFat ?? "0"),
        unit: "g");
    vitaminA =
        Nutrition.asParams(double.parse(servings.vitaminA ?? "0"), unit: 'mcg');
    vitaminC =
        Nutrition.asParams(double.parse(servings.vitaminC ?? "0"), unit: 'mg');
    vitaminD =
        Nutrition.asParams(double.parse(servings.vitaminD ?? "0"), unit: 'mcg');
    calcium =
        Nutrition.asParams(double.parse(servings.calcium ?? "0"), unit: 'mg');
    sodium = Nutrition.asParams(double.parse(servings.sodium ?? "0"));
    iron = Nutrition.asParams(double.parse(servings.iron ?? "0"), unit: 'mg');
    calories = Nutrition.asParams(double.parse(servings.calories ?? "0"));
    potassium =
        Nutrition.asParams(double.parse(servings.potassium ?? "0"), unit: 'mg');
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
