import 'nutri_score_model.dart';

class NutriscoreDetailModel {
  String? date;
  num? totalPossibleWeighted;
  num? totalWeightedScore;
  num? totalPoints;
  Details? details;

  NutriscoreDetailModel(
      {this.date,
      this.totalPossibleWeighted,
      this.totalWeightedScore,
      this.totalPoints,
      this.details});

  NutriscoreDetailModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    totalPossibleWeighted = json['total_possible_weighted'];
    totalWeightedScore = json['total_weighted_score'];
    totalPoints = json['total_points'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }
}
