// To parse this JSON data, do
//
//     final wellnessDetailModel = wellnessDetailModelFromJson(jsonString);

import 'dart:convert';

WellnessDetailModel wellnessDetailModelFromJson(String str) => WellnessDetailModel.fromJson(json.decode(str));

String wellnessDetailModelToJson(WellnessDetailModel data) => json.encode(data.toJson());

class WellnessDetailModel {
  Response? response;

  WellnessDetailModel({
    this.response,
  });

  factory WellnessDetailModel.fromJson(Map<String, dynamic> json) => WellnessDetailModel(
        response: json["response"] == null ? null : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response?.toJson(),
      };
}

class Response {
  DateTime? date;
  Data? rawData;
  Data? displayData;
  Details? details;

  Response({
    this.date,
    this.rawData,
    this.displayData,
    this.details,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        rawData: json["raw_data"] == null ? null : Data.fromJson(json["raw_data"]),
        displayData: json["display_data"] == null ? null : Data.fromJson(json["display_data"]),
        details: json["details"] == null ? null : Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "raw_data": rawData?.toJson(),
        "display_data": displayData?.toJson(),
        "details": details?.toJson(),
      };
}

class Details {
  Activity? activity;
  Activity? calories;
  Activity? hydration;
  Activity? mood;
  Activity? sleep;

  Details({
    this.activity,
    this.calories,
    this.hydration,
    this.mood,
    this.sleep,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        activity: json["activity"] == null ? null : Activity.fromJson(json["activity"]),
        calories: json["calories"] == null ? null : Activity.fromJson(json["calories"]),
        hydration: json["hydration"] == null ? null : Activity.fromJson(json["hydration"]),
        mood: json["mood"] == null ? null : Activity.fromJson(json["mood"]),
        sleep: json["sleep"] == null ? null : Activity.fromJson(json["sleep"]),
      );

  Map<String, dynamic> toJson() => {
        "activity": activity?.toJson(),
        "calories": calories?.toJson(),
        "hydration": hydration?.toJson(),
        "mood": mood?.toJson(),
        "sleep": sleep?.toJson(),
      };
}

class Activity {
  double? value;
  String? displayValue;
  String? unit;
  String? displayUnit;

  Activity({
    this.value,
    this.displayValue,
    this.unit,
    this.displayUnit,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        value: json["value"]?.toDouble(),
        displayValue: json["display_value"],
        unit: json["unit"],
        displayUnit: json["display_unit"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "display_value": displayValue,
        "unit": unit,
        "display_unit": displayUnit,
      };
}

class Data {
  int? hydrationScore;
  int? sleepScore;
  int? moodScore;
  int? nutritionScore;
  int? activityScore;
  int? totalScore;
  bool? isStreak;
  DateTime? recordAt;

  Data({
    this.hydrationScore,
    this.sleepScore,
    this.moodScore,
    this.nutritionScore,
    this.activityScore,
    this.totalScore,
    this.isStreak,
    this.recordAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
