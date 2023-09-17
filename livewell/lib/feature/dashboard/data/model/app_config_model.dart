class AppConfigModel {
  bool? quickAdd;
  bool? upcSearch;
  bool? scanMeal;
  bool? recipeToNutrition;
  bool? googleHealth;

  AppConfigModel(
      {this.quickAdd,
      this.upcSearch,
      this.scanMeal,
      this.recipeToNutrition,
      this.googleHealth});

  AppConfigModel.fromJson(Map<String, dynamic> json) {
    quickAdd = json['quick_add'];
    upcSearch = json['upc_search'];
    scanMeal = json['scan_meal'];
    recipeToNutrition = json['recipe_to_nutrition'];
    googleHealth = json['google_health'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quick_add'] = quickAdd;
    data['upc_search'] = upcSearch;
    data['scan_meal'] = scanMeal;
    data['recipe_to_nutrition'] = recipeToNutrition;
    data['google_health'] = googleHealth;
    return data;
  }
}
