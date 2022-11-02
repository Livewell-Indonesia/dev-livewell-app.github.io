import '../../../food/data/model/foods_model.dart';

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
  String? mealServings;
  num? caloriesInG;
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
  String? measurementDescription;
  num? servingSize;

  MealHistoryModel(
      {this.id,
      this.mealName,
      this.mealBrand,
      this.mealType,
      this.restaurant,
      this.createdAt,
      this.updatedAt,
      this.mealServings,
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
      this.mealAt,
      this.measurementDescription,
      this.servingSize});

  MealHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealName = json['meal_name'];
    mealBrand = json['meal_brand'];
    mealType = json['meal_type'];
    restaurant = json['restaurant'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mealServings = json['meal_servings'];
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
    servingSize = json['serving_size'];
  }

  Foods toFoodsObject() {
    return Foods(
        foodName: mealName,
        foodDescription: "",
        foodType: mealType,
        brandName: mealBrand,
        provider: "",
        servings: [
          Servings(
            servingDescription: mealServings,
            calcium: calciumInMg.toString(),
            calories: caloriesInG.toString(),
            carbohydrate: carbohydratesInG.toString(),
            fat: fatInG.toString(),
            iron: ironInMg.toString(),
            measurementDescription: measurementDescription,
            monounsaturatedFat: monosaturatedFatInG.toString(),
            polyunsaturatedFat: polyunsaturatedFatInG.toString(),
            potassium: potassiumInMg.toString(),
            protein: proteinInG.toString(),
            saturatedFat: saturatedFatInG.toString(),
            sodium: sodiumInMg.toString(),
            transFat: transfatInG.toString(),
            vitaminA: vitaminAInMcg.toString(),
            vitaminC: vitaminCInMg.toString(),
            vitaminD: vitaminDInMcg.toString(),
            vitaminE: vitaminEInMg.toString(),
            vitaminK: vitaminKInMcg.toString(),
            vitaminB1: vitaminB1InMg.toString(),
            vitaminB2: vitaminB2InMg.toString(),
            vitaminB3: vitaminB3InMg.toString(),
            vitaminB5: vitaminB5InMg.toString(),
            vitaminB6: vitaminB6InMg.toString(),
            vitaminB7: vitaminB7InMcg.toString(),
            vitaminB9: vitaminB9InMcg.toString(),
            vitaminB12: vitaminB12InMcg.toString(),
            phosphorus: phosphorusInMg.toString(),
            magnesium: magnesiumInMg.toString(),
            chloride: chlorideInMg.toString(),
            iodine: iodineInMcg.toString(),
            zinc: zincInMg.toString(),
            selenium: seleniumInMcg.toString(),
            fluoride: fluorideInMg.toString(),
            chromium: chromiumInMcg.toString(),
            molybdenum: molybdenumInMcg.toString(),
          ),
        ]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['meal_name'] = this.mealName;
    data['meal_brand'] = this.mealBrand;
    data['meal_type'] = this.mealType;
    data['restaurant'] = this.restaurant;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['calories_in_g'] = (this.caloriesInG ?? 0) * (this.servingSize ?? 1);
    data['carbohydrates_in_g'] =
        (this.carbohydratesInG ?? 0) * (this.servingSize ?? 1);
    data['protein_in_g'] = (this.proteinInG ?? 0) * (this.servingSize ?? 1);
    data['fat_in_g'] = (this.fatInG ?? 0) * (this.servingSize ?? 1);
    data['saturated_fat_in_g'] =
        (this.saturatedFatInG ?? 0) * (this.servingSize ?? 1);
    data['transfat_in_g'] = (this.transfatInG ?? 0) * (this.servingSize ?? 1);
    data['monosaturated_fat_in_g'] =
        (this.monosaturatedFatInG ?? 0) * (this.servingSize ?? 1);
    data['polyunsaturated_fat_in_g'] =
        (this.polyunsaturatedFatInG ?? 0) * (this.servingSize ?? 1);
    data['vitamin_a_in_mcg'] =
        (this.vitaminAInMcg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_c_in_mg'] =
        (this.vitaminCInMg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_d_in_mcg'] =
        (this.vitaminDInMcg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_e_in_mg'] =
        (this.vitaminEInMg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_k_in_mcg'] =
        (this.vitaminKInMcg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_b1_in_mg'] =
        (this.vitaminB1InMg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_b2_in_mg'] =
        (this.vitaminB2InMg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_b3_in_mg'] =
        (this.vitaminB3InMg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_b5_in_mg'] =
        (this.vitaminB5InMg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_b6_in_mg'] =
        (this.vitaminB6InMg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_b7_in_mcg'] =
        (this.vitaminB7InMcg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_b9_in_mcg'] =
        (this.vitaminB9InMcg ?? 0) * (this.servingSize ?? 1);
    data['vitamin_b12_in_mcg'] =
        (this.vitaminB12InMcg ?? 0) * (this.servingSize ?? 1);
    data['calcium_in_mg'] = (this.calciumInMg ?? 0) * (this.servingSize ?? 1);
    data['phosphorus_in_mg'] =
        (this.phosphorusInMg ?? 0) * (this.servingSize ?? 1);
    data['magnesium_in_mg'] =
        (this.magnesiumInMg ?? 0) * (this.servingSize ?? 1);
    data['sodium_in_mg'] = (this.sodiumInMg ?? 0) * (this.servingSize ?? 1);
    data['potassium_in_mg'] =
        (this.potassiumInMg ?? 0) * (this.servingSize ?? 1);
    data['chloride_in_mg'] = (this.chlorideInMg ?? 0) * (this.servingSize ?? 1);
    data['iron_in_mg'] = (this.ironInMg ?? 0) * (this.servingSize ?? 1);
    data['iodine_in_mcg'] = (this.iodineInMcg ?? 0) * (this.servingSize ?? 1);
    data['zinc_in_mg'] = (this.zincInMg ?? 0) * (this.servingSize ?? 1);
    data['selenium_in_mcg'] =
        (this.seleniumInMcg ?? 0) * (this.servingSize ?? 1);
    data['fluoride_in_mg'] = (this.fluorideInMg ?? 0) * (this.servingSize ?? 1);
    data['chromium_in_mcg'] =
        (this.chromiumInMcg ?? 0) * (this.servingSize ?? 1);
    data['molybdenum_in_mcg'] =
        (this.molybdenumInMcg ?? 0) * (this.servingSize ?? 1);
    data['meal_at'] = this.mealAt;
    data['serving_size'] = this.servingSize;
    return data;
  }
}
