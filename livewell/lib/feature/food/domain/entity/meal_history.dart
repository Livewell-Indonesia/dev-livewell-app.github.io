class MealHistories {
  List<MealHistory>? mealHistories;

  MealHistories({this.mealHistories});

  MealHistories.fromJson(Map<String, dynamic> json) {
    if (json['mealHistories'] != null) {
      mealHistories = <MealHistory>[];
      json['mealHistories'].forEach((v) {
        mealHistories!.add(MealHistory.fromJson(v));
      });
    } else {
      mealHistories = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mealHistories != null) {
      data['mealHistories'] = mealHistories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MealHistory {
  String? date;
  String? mealType;

  MealHistory({this.date, this.mealType});

  MealHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    mealType = json['meal_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['meal_type'] = mealType;
    return data;
  }
}
