// To parse this JSON data, do
//
//     final sleepHistoryModel = sleepHistoryModelFromJson(jsonString);

import 'dart:convert';

SleepHistoryModel sleepHistoryModelFromJson(String str) => SleepHistoryModel.fromJson(json.decode(str));

String sleepHistoryModelToJson(SleepHistoryModel data) => json.encode(data.toJson());

class SleepHistoryModel {
  Map<String, Response>? response;

  SleepHistoryModel({
    this.response,
  });

  factory SleepHistoryModel.fromJson(Map<String, dynamic> json) => SleepHistoryModel(
        response: Map.from(json["response"]!).map((k, v) => MapEntry<String, Response>(k, Response.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "response": Map.from(response!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Response {
  DateTime? startTime;
  DateTime? endTime;
  int? total;
  Unit? unit;
  List<Detail>? details;

  Response({
    this.startTime,
    this.endTime,
    this.total,
    this.unit,
    this.details,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
        endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        total: json["total"],
        unit: unitValues.map[json["unit"]] == null ? null : unitValues.map[json["unit"]]!,
        details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "total": total,
        "unit": unitValues.reverse[unit],
        "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  int? value;
  Type? type;
  Unit? unit;
  String? dateFrom;
  String? dateTo;

  Detail({
    this.value,
    this.type,
    this.unit,
    this.dateFrom,
    this.dateTo,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        value: json["value"],
        type: typeValues.map[json["type"]]!,
        unit: unitValues.map[json["unit"]]!,
        dateFrom: json["date_from"],
        dateTo: json["date_to"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "type": typeValues.reverse[type],
        "unit": unitValues.reverse[unit],
        "date_from": dateFrom,
        "date_to": dateTo,
      };
}

enum Type { DEEP_SLEEP, LIGHT_SLEEP, SLEEP_IN_BED }

final typeValues = EnumValues({"DEEP_SLEEP": Type.DEEP_SLEEP, "LIGHT_SLEEP": Type.LIGHT_SLEEP, "SLEEP_IN_BED": Type.SLEEP_IN_BED});

enum Unit { MINUTES }

final unitValues = EnumValues({"MINUTES": Unit.MINUTES});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
