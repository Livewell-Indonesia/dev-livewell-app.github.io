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
        (double.tryParse(servings.carbohydrate ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: "g");
    protein = Nutrition.asParams(
        (double.tryParse(servings.protein ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: "g");
    fat = Nutrition.asParams(
        (double.tryParse(servings.fat ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: "g");
    saturatedFat = Nutrition.asParams(
        (double.tryParse(servings.saturatedFat ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: "g");
    transfat = Nutrition.asParams(
        (double.tryParse(servings.transFat ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: "g");
    monosaturatedFat = Nutrition.asParams(
        (double.tryParse(servings.monounsaturatedFat ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: "g");
    polyunsaturatedFat = Nutrition.asParams(
        (double.tryParse(servings.polyunsaturatedFat ?? "0") ?? 0.0) *
            num.parse(numberOfServings),
        unit: "g");
    vitaminA = Nutrition.asParams(
        (double.tryParse(servings.vitaminA ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mcg');
    vitaminC = Nutrition.asParams(
        (double.tryParse(servings.vitaminC ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');

    vitaminD = Nutrition.asParams(
        (double.tryParse(servings.vitaminD ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mcg');
    calcium = Nutrition.asParams(
        (double.tryParse(servings.calcium ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');

    sodium = Nutrition.asParams(
        (double.tryParse(servings.sodium ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    iron = Nutrition.asParams(
        (double.tryParse(servings.iron ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    calories = Nutrition.asParams(
        (double.tryParse(servings.calories ?? "0") ?? 0) *
            num.parse(numberOfServings));
    potassium = Nutrition.asParams(
        (double.tryParse(servings.potassium ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    vitaminE = Nutrition.asParams(
        (double.tryParse(servings.vitaminE ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    vitaminK = Nutrition.asParams(
        (double.tryParse(servings.vitaminK ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mcg');
    vitaminB1 = Nutrition.asParams(
        (double.tryParse(servings.vitaminB1 ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    vitaminB2 = Nutrition.asParams(
        (double.tryParse(servings.vitaminB2 ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    vitaminB3 = Nutrition.asParams(
        (double.tryParse(servings.vitaminB3 ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    vitaminB5 = Nutrition.asParams(
        (double.tryParse(servings.vitaminB5 ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    vitaminB6 = Nutrition.asParams(
        (double.tryParse(servings.vitaminB6 ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    vitaminB12 = Nutrition.asParams(
        (double.tryParse(servings.vitaminB12 ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mcg');
    vitaminB7 = Nutrition.asParams(
        (double.tryParse(servings.vitaminB7 ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mcg');

    vitaminB9 = Nutrition.asParams(
        (double.tryParse(servings.vitaminB9 ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mcg');
    phosphorus = Nutrition.asParams(
        (double.tryParse(servings.phosphorus ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    magnesium = Nutrition.asParams(
        (double.tryParse(servings.magnesium ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    chloride = Nutrition.asParams(
        (double.tryParse(servings.chloride ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    iodine = Nutrition.asParams(
        (double.tryParse(servings.iodine ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mcg');
    zinc = Nutrition.asParams(
        (double.tryParse(servings.zinc ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    selenium = Nutrition.asParams(
        (double.tryParse(servings.selenium ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mcg');
    fluoride = Nutrition.asParams(
        (double.tryParse(servings.fluoride ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mg');
    chromium = Nutrition.asParams(
        (double.tryParse(servings.chromium ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mcg');
    molybdenum = Nutrition.asParams(
        (double.tryParse(servings.molybdenum ?? "0") ?? 0) *
            num.parse(numberOfServings),
        unit: 'mcg');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  num? value;
  String? unit;

  Nutrition({value, unit});

  Nutrition.asParams(double this.value, {String this.unit = 'g'});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    return data;
  }
}
