class DashboardModel {
  Dashboard? dashboard;
  List<Details>? details;

  DashboardModel({this.dashboard, this.details});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    dashboard = json['dashboard'] != null
        ? Dashboard.fromJson(json['dashboard'])
        : null;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dashboard != null) {
      data['dashboard'] = dashboard!.toJson();
    }
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dashboard {
  num? target;
  num? caloriesLeft;
  num? caloriesTaken;
  num? totalCarbsInG;
  num? totalFatsInG;
  num? totalProteinInG;
  num? totalCalories;

  Dashboard(
      {this.target,
      this.caloriesLeft,
      this.caloriesTaken,
      this.totalCarbsInG,
      this.totalFatsInG,
      this.totalProteinInG,
      this.totalCalories});

  Dashboard.fromJson(Map<String, dynamic> json) {
    target = json['target'];
    caloriesLeft = json['calories_left'];
    caloriesTaken = json['calories_taken'];
    totalCarbsInG = json['total_carbs_in_g'];
    totalFatsInG = json['total_fats_in_g'];
    totalProteinInG = json['total_protein_in_g'];
    totalCalories = json['total_calories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['target'] = target;
    data['calories_left'] = caloriesLeft;
    data['calories_taken'] = caloriesTaken;
    data['total_carbs_in_g'] = totalCarbsInG;
    data['total_fats_in_g'] = totalFatsInG;
    data['total_protein_in_g'] = totalProteinInG;
    data['total_calories'] = totalCalories;
    return data;
  }
}

class Details {
  String? mealName;
  String? mealBrand;
  String? mealType;
  String? createdAt;
  String? updatedAt;
  num? carbohydratesInG;
  num? proteinInG;
  num? fatInG;
  num? saturatedFatInG;
  num? transfatInG;
  num? monosaturatedFatInG;
  num? polyunsaturatedFatInG;
  num? vitaminAInMcg;
  num? vitaminCInMg;
  num? vitaminDInMcg;
  num? vitaminEInMg;
  num? vitaminKInMcg;
  num? vitaminB1InMg;
  num? vitaminB2InMg;
  num? vitaminB3InMg;
  num? vitaminB5InMg;
  num? vitaminB6InMg;
  num? vitaminB7InMcg;
  num? vitaminB9InMcg;
  num? vitaminB12InMcg;
  num? calciumInMg;
  num? phosphorusInMg;
  num? magnesiumInMg;
  num? sodiumInMg;
  num? potassiumInMg;
  num? chlorideInMg;
  num? ironInMg;
  num? iodineInMcg;
  num? zincInMg;
  num? seleniumInMcg;
  num? fluorideInMg;
  num? chromiumInMcg;
  num? molybdenumInMcg;
  String? mealAt;
  String? userReferenceId;
  String? restaurant;
  num? caloriesInG;

  Details(
      {this.mealName,
      this.mealBrand,
      this.mealType,
      this.createdAt,
      this.updatedAt,
      this.carbohydratesInG,
      this.proteinInG,
      this.fatInG,
      this.saturatedFatInG,
      this.transfatInG,
      this.monosaturatedFatInG,
      this.polyunsaturatedFatInG,
      this.vitaminAInMcg,
      this.vitaminCInMg,
      this.vitaminDInMcg,
      this.vitaminEInMg,
      this.vitaminKInMcg,
      this.vitaminB1InMg,
      this.vitaminB2InMg,
      this.vitaminB3InMg,
      this.vitaminB5InMg,
      this.vitaminB6InMg,
      this.vitaminB7InMcg,
      this.vitaminB9InMcg,
      this.vitaminB12InMcg,
      this.calciumInMg,
      this.phosphorusInMg,
      this.magnesiumInMg,
      this.sodiumInMg,
      this.potassiumInMg,
      this.chlorideInMg,
      this.ironInMg,
      this.iodineInMcg,
      this.zincInMg,
      this.seleniumInMcg,
      this.fluorideInMg,
      this.chromiumInMcg,
      this.molybdenumInMcg,
      this.mealAt,
      this.userReferenceId,
      this.restaurant,
      this.caloriesInG});

  Details.fromJson(Map<String, dynamic> json) {
    mealName = json['meal_name'];
    mealBrand = json['meal_brand'];
    mealType = json['meal_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    carbohydratesInG = json['carbohydrates_in_g'];
    proteinInG = json['protein_in_g'];
    fatInG = json['fat_in_g'];
    saturatedFatInG = json['saturated_fat_in_g'];
    transfatInG = json['transfat_in_g'];
    monosaturatedFatInG = json['monosaturated_fat_in_g'];
    polyunsaturatedFatInG = json['polyunsaturated_fat_in_g'];
    vitaminAInMcg = json['vitamin_a_in_mcg'];
    vitaminCInMg = json['vitamin_c_in_mg'];
    vitaminDInMcg = json['vitamin_d_in_mcg'];
    vitaminEInMg = json['vitamin_e_in_mg'];
    vitaminKInMcg = json['vitamin_k_in_mcg'];
    vitaminB1InMg = json['vitamin_b1_in_mg'];
    vitaminB2InMg = json['vitamin_b2_in_mg'];
    vitaminB3InMg = json['vitamin_b3_in_mg'];
    vitaminB5InMg = json['vitamin_b5_in_mg'];
    vitaminB6InMg = json['vitamin_b6_in_mg'];
    vitaminB7InMcg = json['vitamin_b7_in_mcg'];
    vitaminB9InMcg = json['vitamin_b9_in_mcg'];
    vitaminB12InMcg = json['vitamin_b12_in_mcg'];
    calciumInMg = json['calcium_in_mg'];
    phosphorusInMg = json['phosphorus_in_mg'];
    magnesiumInMg = json['magnesium_in_mg'];
    sodiumInMg = json['sodium_in_mg'];
    potassiumInMg = json['potassium_in_mg'];
    chlorideInMg = json['chloride_in_mg'];
    ironInMg = json['iron_in_mg'];
    iodineInMcg = json['iodine_in_mcg'];
    zincInMg = json['zinc_in_mg'];
    seleniumInMcg = json['selenium_in_mcg'];
    fluorideInMg = json['fluoride_in_mg'];
    chromiumInMcg = json['chromium_in_mcg'];
    molybdenumInMcg = json['molybdenum_in_mcg'];
    mealAt = json['meal_at'];
    userReferenceId = json['user_reference_id'];
    restaurant = json['restaurant'];
    caloriesInG = json['calories_in_g'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meal_name'] = mealName;
    data['meal_brand'] = mealBrand;
    data['meal_type'] = mealType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['carbohydrates_in_g'] = carbohydratesInG;
    data['protein_in_g'] = proteinInG;
    data['fat_in_g'] = fatInG;
    data['saturated_fat_in_g'] = saturatedFatInG;
    data['transfat_in_g'] = transfatInG;
    data['monosaturated_fat_in_g'] = monosaturatedFatInG;
    data['polyunsaturated_fat_in_g'] = polyunsaturatedFatInG;
    data['vitamin_a_in_mcg'] = vitaminAInMcg;
    data['vitamin_c_in_mg'] = vitaminCInMg;
    data['vitamin_d_in_mcg'] = vitaminDInMcg;
    data['vitamin_e_in_mg'] = vitaminEInMg;
    data['vitamin_k_in_mcg'] = vitaminKInMcg;
    data['vitamin_b1_in_mg'] = vitaminB1InMg;
    data['vitamin_b2_in_mg'] = vitaminB2InMg;
    data['vitamin_b3_in_mg'] = vitaminB3InMg;
    data['vitamin_b5_in_mg'] = vitaminB5InMg;
    data['vitamin_b6_in_mg'] = vitaminB6InMg;
    data['vitamin_b7_in_mcg'] = vitaminB7InMcg;
    data['vitamin_b9_in_mcg'] = vitaminB9InMcg;
    data['vitamin_b12_in_mcg'] = vitaminB12InMcg;
    data['calcium_in_mg'] = calciumInMg;
    data['phosphorus_in_mg'] = phosphorusInMg;
    data['magnesium_in_mg'] = magnesiumInMg;
    data['sodium_in_mg'] = sodiumInMg;
    data['potassium_in_mg'] = potassiumInMg;
    data['chloride_in_mg'] = chlorideInMg;
    data['iron_in_mg'] = ironInMg;
    data['iodine_in_mcg'] = iodineInMcg;
    data['zinc_in_mg'] = zincInMg;
    data['selenium_in_mcg'] = seleniumInMcg;
    data['fluoride_in_mg'] = fluorideInMg;
    data['chromium_in_mcg'] = chromiumInMcg;
    data['molybdenum_in_mcg'] = molybdenumInMcg;
    data['meal_at'] = mealAt;
    data['user_reference_id'] = userReferenceId;
    data['restaurant'] = restaurant;
    data['calories_in_g'] = caloriesInG;
    return data;
  }
}
