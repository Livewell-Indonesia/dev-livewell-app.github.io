class MealHistories {
  List<MealHistory>? mealHistories;

  MealHistories({this.mealHistories});

  MealHistories.fromJson(Map<String, dynamic> json) {
    if (json['mealHistories'] != null) {
      mealHistories = <MealHistory>[];
      json['mealHistories'].forEach((v) {
        mealHistories!.add(new MealHistory.fromJson(v));
      });
    } else {
      mealHistories = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mealHistories != null) {
      data['mealHistories'] =
          this.mealHistories!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['meal_type'] = this.mealType;
    return data;
  }
}
