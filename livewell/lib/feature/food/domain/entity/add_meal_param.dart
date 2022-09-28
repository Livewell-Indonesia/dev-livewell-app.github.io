import 'package:intl/intl.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';

import '../../data/model/foods_model.dart';

class AddMealParams {
  String? mealName;
  String? mealBrand;
  String? mealNutritions;
  String? mealType;
  Nutritions? nutritions;
  String? mealAt;

  AddMealParams(
      {this.mealName,
      this.mealBrand,
      this.mealNutritions,
      this.mealType,
      this.nutritions,
      this.mealAt});

  AddMealParams.asParams(Foods food, MealTime mealTime, String time) {
    mealName = food.foodName;
    mealBrand = food.brandName;
    mealNutritions = null;
    mealType = mealTime.name;
    nutritions = Nutritions.asParams(food.servings![0]);
    mealAt = time;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meal_name'] = this.mealName;
    data['meal_brand'] = this.mealBrand;
    data['meal_nutritions'] = this.mealNutritions;
    data['meal_type'] = this.mealType;
    if (this.nutritions != null) {
      data['nutritions'] = this.nutritions!.toJson();
    }
    data['meal_at'] = this.mealAt;
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

  Nutritions({
    this.carbohydrates,
    this.protein,
    this.fat,
    this.saturatedFat,
    this.transfat,
    this.monosaturatedFat,
    this.polyunsaturatedFat,
    this.vitaminA,
    this.vitaminC,
    this.vitaminD,
    this.calcium,
    this.sodium,
    this.iron,
  });

  Nutritions.asParams(Servings servings) {
    carbohydrates =
        Nutrition.asParams(double.parse(servings.carbohydrate ?? "0"));
    protein = Nutrition.asParams(double.parse(servings.protein ?? "0"));
    fat = Nutrition.asParams(double.parse(servings.fat ?? "0"));
    saturatedFat =
        Nutrition.asParams(double.parse(servings.saturatedFat ?? "0"));
    transfat = Nutrition.asParams(double.parse(servings.transFat ?? "0"));
    monosaturatedFat =
        Nutrition.asParams(double.parse(servings.monounsaturatedFat ?? "0"));
    polyunsaturatedFat =
        Nutrition.asParams(double.parse(servings.polyunsaturatedFat ?? "0"));
    vitaminA = Nutrition.asParams(double.parse(servings.vitaminA ?? "0"));
    vitaminC = Nutrition.asParams(double.parse(servings.vitaminC ?? "0"));
    vitaminD = Nutrition.asParams(double.parse(servings.vitaminD ?? "0"));
    calcium = Nutrition.asParams(double.parse(servings.calcium ?? "0"));
    sodium = Nutrition.asParams(double.parse(servings.sodium ?? "0"));
    iron = Nutrition.asParams(double.parse(servings.iron ?? "0"));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carbohydrates != null) {
      data['carbohydrates'] = this.carbohydrates!.toJson();
    }
    if (this.protein != null) {
      data['protein'] = this.protein!.toJson();
    }
    if (this.fat != null) {
      data['fat'] = this.fat!.toJson();
    }
    if (this.saturatedFat != null) {
      data['saturated_fat'] = this.saturatedFat!.toJson();
    }
    if (this.transfat != null) {
      data['transfat'] = this.transfat!.toJson();
    }
    if (this.monosaturatedFat != null) {
      data['monosaturated_fat'] = this.monosaturatedFat!.toJson();
    }
    if (this.polyunsaturatedFat != null) {
      data['polyunsaturated_fat'] = this.polyunsaturatedFat!.toJson();
    }
    if (this.vitaminA != null) {
      data['vitamin_a'] = this.vitaminA!.toJson();
    }
    if (this.vitaminC != null) {
      data['vitamin_c'] = this.vitaminC!.toJson();
    }
    if (this.vitaminD != null) {
      data['vitamin_d'] = this.vitaminD!.toJson();
    }
    if (this.calcium != null) {
      data['calcium'] = this.calcium!.toJson();
    }
    if (this.iron != null) {
      data['iron'] = this.iron!.toJson();
    }
    return data;
  }
}

class Nutrition {
  int? value;
  String? unit;

  Nutrition({this.value, this.unit});

  Nutrition.asParams(double value) {
    this.value = value.toInt();
    this.unit = 'g';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    return data;
  }
}
