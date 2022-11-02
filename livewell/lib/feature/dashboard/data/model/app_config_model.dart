class AppConfigModel {
  bool? quickAdd;
  bool? upcSearch;
  bool? scanMeal;
  bool? recipeToNutrition;

  AppConfigModel(
      {this.quickAdd, this.upcSearch, this.scanMeal, this.recipeToNutrition});

  AppConfigModel.fromJson(Map<String, dynamic> json) {
    quickAdd = json['quick_add'];
    upcSearch = json['upc_search'];
    scanMeal = json['scan_meal'];
    recipeToNutrition = json['recipe_to_nutrition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quick_add'] = this.quickAdd;
    data['upc_search'] = this.upcSearch;
    data['scan_meal'] = this.scanMeal;
    data['recipe_to_nutrition'] = this.recipeToNutrition;
    return data;
  }
}
