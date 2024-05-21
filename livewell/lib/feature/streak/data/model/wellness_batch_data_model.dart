// To parse this JSON data, do
//
//     final wellnessBatchModel = wellnessBatchModelFromJson(jsonString);

import 'dart:convert';

WellnessBatchModel wellnessBatchModelFromJson(String str) => WellnessBatchModel.fromJson(json.decode(str));

String wellnessBatchModelToJson(WellnessBatchModel data) => json.encode(data.toJson());

class WellnessBatchModel {
  WellNessResponse? response;

  WellnessBatchModel({
    this.response,
  });

  factory WellnessBatchModel.fromJson(Map<String, dynamic> json) => WellnessBatchModel(
        response: json["response"] == null ? null : WellNessResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response?.toJson(),
      };
}

class WellNessResponse {
  DateTime? dateFrom;
  DateTime? dateTo;
  List<WellnessData>? rawData;
  List<WellnessData>? displayData;

  WellNessResponse({
    this.dateFrom,
    this.dateTo,
    this.rawData,
    this.displayData,
  });

  factory WellNessResponse.fromJson(Map<String, dynamic> json) => WellNessResponse(
        dateFrom: json["date_from"] == null ? null : DateTime.parse(json["date_from"]),
        dateTo: json["date_to"] == null ? null : DateTime.parse(json["date_to"]),
        rawData: json["raw_data"] == null ? [] : List<WellnessData>.from(json["raw_data"]!.map((x) => WellnessData.fromJson(x))),
        displayData: json["display_data"] == null ? [] : List<WellnessData>.from(json["display_data"]!.map((x) => WellnessData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date_from": "${dateFrom!.year.toString().padLeft(4, '0')}-${dateFrom!.month.toString().padLeft(2, '0')}-${dateFrom!.day.toString().padLeft(2, '0')}",
        "date_to": "${dateTo!.year.toString().padLeft(4, '0')}-${dateTo!.month.toString().padLeft(2, '0')}-${dateTo!.day.toString().padLeft(2, '0')}",
        "raw_data": rawData == null ? [] : List<dynamic>.from(rawData!.map((x) => x.toJson())),
        "display_data": displayData == null ? [] : List<dynamic>.from(displayData!.map((x) => x.toJson())),
      };
}

class WellnessData {
  int? hydrationScore;
  int? sleepScore;
  int? moodScore;
  int? nutritionScore;
  int? activityScore;
  int? totalScore;
  bool? isStreak;
  DateTime? recordAt;

  WellnessData({
    this.hydrationScore,
    this.sleepScore,
    this.moodScore,
    this.nutritionScore,
    this.activityScore,
    this.totalScore,
    this.isStreak,
    this.recordAt,
  });

  factory WellnessData.fromJson(Map<String, dynamic> json) => WellnessData(
        hydrationScore: json["hydration_score"],
        sleepScore: json["sleep_score"],
        moodScore: json["mood_score"],
        nutritionScore: json["nutrition_score"],
        activityScore: json["activity_score"],
        totalScore: json["total_score"],
        isStreak: json["is_streak"],
        recordAt: json["record_at"] == null ? null : DateTime.parse(json["record_at"]),
      );

  Map<String, dynamic> toJson() => {
        "hydration_score": hydrationScore,
        "sleep_score": sleepScore,
        "mood_score": moodScore,
        "nutrition_score": nutritionScore,
        "activity_score": activityScore,
        "total_score": totalScore,
        "is_streak": isStreak,
        "record_at": recordAt?.toIso8601String(),
      };
}
