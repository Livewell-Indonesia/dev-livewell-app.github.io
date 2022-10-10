class UserMealHistoryModel {
  List<MealHistoryModel>? response;

  UserMealHistoryModel({this.response});

  UserMealHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <MealHistoryModel>[];
      json['response'].forEach((v) {
        response!.add(new MealHistoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MealHistoryModel {
  int? id;
  String? mealName;
  String? mealBrand;
  String? mealType;
  String? restaurant;
  String? createdAt;
  String? updatedAt;
  int? caloriesInG;
  int? carbohydratesInG;
  int? proteinInG;
  int? fatInG;
  int? saturatedFatInG;
  int? transfatInG;
  int? monosaturatedFatInG;
  int? polyunsaturatedFatInG;
  int? vitaminAInMcg;
  int? vitaminCInMg;
  int? vitaminDInMcg;
  int? vitaminEInMg;
  int? vitaminKInMcg;
  int? vitaminB1InMg;
  int? vitaminB2InMg;
  int? vitaminB3InMg;
  int? vitaminB5InMg;
  int? vitaminB6InMg;
  int? vitaminB7InMcg;
  int? vitaminB9InMcg;
  int? vitaminB12InMcg;
  int? calciumInMg;
  int? phosphorusInMg;
  int? magnesiumInMg;
  int? sodiumInMg;
  int? potassiumInMg;
  int? chlorideInMg;
  int? ironInMg;
  int? iodineInMcg;
  int? zincInMg;
  int? seleniumInMcg;
  int? fluorideInMg;
  int? chromiumInMcg;
  int? molybdenumInMcg;
  String? mealAt;

  MealHistoryModel(
      {this.id,
      this.mealName,
      this.mealBrand,
      this.mealType,
      this.restaurant,
      this.createdAt,
      this.updatedAt,
      this.caloriesInG,
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
      this.mealAt});

  MealHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealName = json['meal_name'];
    mealBrand = json['meal_brand'];
    mealType = json['meal_type'];
    restaurant = json['restaurant'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    caloriesInG = json['calories_in_g'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meal_name'] = this.mealName;
    data['meal_brand'] = this.mealBrand;
    data['meal_type'] = this.mealType;
    data['restaurant'] = this.restaurant;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['calories_in_g'] = this.caloriesInG;
    data['carbohydrates_in_g'] = this.carbohydratesInG;
    data['protein_in_g'] = this.proteinInG;
    data['fat_in_g'] = this.fatInG;
    data['saturated_fat_in_g'] = this.saturatedFatInG;
    data['transfat_in_g'] = this.transfatInG;
    data['monosaturated_fat_in_g'] = this.monosaturatedFatInG;
    data['polyunsaturated_fat_in_g'] = this.polyunsaturatedFatInG;
    data['vitamin_a_in_mcg'] = this.vitaminAInMcg;
    data['vitamin_c_in_mg'] = this.vitaminCInMg;
    data['vitamin_d_in_mcg'] = this.vitaminDInMcg;
    data['vitamin_e_in_mg'] = this.vitaminEInMg;
    data['vitamin_k_in_mcg'] = this.vitaminKInMcg;
    data['vitamin_b1_in_mg'] = this.vitaminB1InMg;
    data['vitamin_b2_in_mg'] = this.vitaminB2InMg;
    data['vitamin_b3_in_mg'] = this.vitaminB3InMg;
    data['vitamin_b5_in_mg'] = this.vitaminB5InMg;
    data['vitamin_b6_in_mg'] = this.vitaminB6InMg;
    data['vitamin_b7_in_mcg'] = this.vitaminB7InMcg;
    data['vitamin_b9_in_mcg'] = this.vitaminB9InMcg;
    data['vitamin_b12_in_mcg'] = this.vitaminB12InMcg;
    data['calcium_in_mg'] = this.calciumInMg;
    data['phosphorus_in_mg'] = this.phosphorusInMg;
    data['magnesium_in_mg'] = this.magnesiumInMg;
    data['sodium_in_mg'] = this.sodiumInMg;
    data['potassium_in_mg'] = this.potassiumInMg;
    data['chloride_in_mg'] = this.chlorideInMg;
    data['iron_in_mg'] = this.ironInMg;
    data['iodine_in_mcg'] = this.iodineInMcg;
    data['zinc_in_mg'] = this.zincInMg;
    data['selenium_in_mcg'] = this.seleniumInMcg;
    data['fluoride_in_mg'] = this.fluorideInMg;
    data['chromium_in_mcg'] = this.chromiumInMcg;
    data['molybdenum_in_mcg'] = this.molybdenumInMcg;
    data['meal_at'] = this.mealAt;
    return data;
  }
}
