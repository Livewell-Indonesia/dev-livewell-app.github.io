class NutriScoreModel {
  String? date;
  num? totalPossibleWeighted;
  num? totalWeightedScore;
  num? totalPoints;
  Details? details;

  NutriScoreModel(
      {this.date,
      this.totalPossibleWeighted,
      this.totalWeightedScore,
      this.totalPoints,
      this.details});

  NutriScoreModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    totalPossibleWeighted = json['total_possible_weighted'];
    totalWeightedScore = json['total_weighted_score'];
    totalPoints = json['total_points'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['total_possible_weighted'] = totalPossibleWeighted;
    data['total_weighted_score'] = totalWeightedScore;
    data['total_points'] = totalPoints;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  Nutrient? calcium;
  Nutrient? carb;
  Nutrient? fat;
  Nutrient? monounsaturatedFat;
  Nutrient? polyunsaturatedFat;
  Nutrient? potassium;
  Nutrient? protein;
  Nutrient? saturatedFat;
  Nutrient? sodium;
  Nutrient? transFat;
  Nutrient? vitaminA;
  Nutrient? vitaminC;
  Nutrient? water;
  Nutrient? sugar;
  Nutrient? fiber;
  Nutrient? cholesterol;

  Details(
      {this.calcium,
      this.carb,
      this.fat,
      this.monounsaturatedFat,
      this.polyunsaturatedFat,
      this.potassium,
      this.protein,
      this.saturatedFat,
      this.sodium,
      this.transFat,
      this.vitaminA,
      this.vitaminC,
      this.water,
      this.sugar,
      this.fiber,
      this.cholesterol});

  Details.fromJson(Map<String, dynamic> json) {
    calcium =
        json['calcium'] != null ? Nutrient.fromJson(json['calcium']) : null;
    carb = json['carb'] != null ? Nutrient.fromJson(json['carb']) : null;
    fat = json['fat'] != null ? Nutrient.fromJson(json['fat']) : null;
    monounsaturatedFat = json['monounsaturated_fat'] != null
        ? Nutrient.fromJson(json['monounsaturated_fat'])
        : null;
    polyunsaturatedFat = json['polyunsaturated_fat'] != null
        ? Nutrient.fromJson(json['polyunsaturated_fat'])
        : null;
    potassium =
        json['potassium'] != null ? Nutrient.fromJson(json['potassium']) : null;
    protein =
        json['protein'] != null ? Nutrient.fromJson(json['protein']) : null;
    saturatedFat = json['saturated_fat'] != null
        ? Nutrient.fromJson(json['saturated_fat'])
        : null;
    sodium = json['sodium'] != null ? Nutrient.fromJson(json['sodium']) : null;
    transFat =
        json['trans_fat'] != null ? Nutrient.fromJson(json['trans_fat']) : null;
    vitaminA =
        json['vitamin_a'] != null ? Nutrient.fromJson(json['vitamin_a']) : null;
    vitaminC =
        json['vitamin_c'] != null ? Nutrient.fromJson(json['vitamin_c']) : null;
    water = json['water'] != null ? Nutrient.fromJson(json['water']) : null;
    sugar = json['sugar'] != null ? Nutrient.fromJson(json['sugar']) : null;
    fiber = json['fiber'] != null ? Nutrient.fromJson(json['fiber']) : null;
    cholesterol = json['cholesterol'] != null
        ? Nutrient.fromJson(json['cholesterol'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (calcium != null) {
      data['calcium'] = calcium!.toJson();
    }
    if (carb != null) {
      data['carb'] = carb!.toJson();
    }
    if (fat != null) {
      data['fat'] = fat!.toJson();
    }
    if (monounsaturatedFat != null) {
      data['monounsaturated_fat'] = monounsaturatedFat!.toJson();
    }
    if (polyunsaturatedFat != null) {
      data['polyunsaturated_fat'] = polyunsaturatedFat!.toJson();
    }
    if (potassium != null) {
      data['potassium'] = potassium!.toJson();
    }
    if (protein != null) {
      data['protein'] = protein!.toJson();
    }
    if (saturatedFat != null) {
      data['saturated_fat'] = saturatedFat!.toJson();
    }
    if (sodium != null) {
      data['sodium'] = sodium!.toJson();
    }
    if (transFat != null) {
      data['trans_fat'] = transFat!.toJson();
    }
    if (vitaminA != null) {
      data['vitamin_a'] = vitaminA!.toJson();
    }
    if (vitaminC != null) {
      data['vitamin_c'] = vitaminC!.toJson();
    }
    if (water != null) {
      data['water'] = water!.toJson();
    }
    return data;
  }
}

class Nutrient {
  String? nutrient;
  num? eaten;
  num? optimizedNutrient;
  num? points;
  num? possibleWeighted;
  num? weightedScore;

  Nutrient(
      {this.nutrient,
      this.eaten,
      this.optimizedNutrient,
      this.points,
      this.possibleWeighted,
      this.weightedScore});

  Nutrient.fromJson(Map<String, dynamic> json) {
    nutrient = json['nutrient'];
    eaten = json['eaten'];
    optimizedNutrient = json['optimized_nutrient'];
    points = json['points'];
    possibleWeighted = json['possible_weighted'];
    weightedScore = json['weighted_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nutrient'] = nutrient;
    data['eaten'] = eaten;
    data['optimized_nutrient'] = optimizedNutrient;
    data['points'] = points;
    data['possible_weighted'] = possibleWeighted;
    data['weighted_score'] = weightedScore;
    return data;
  }
}
