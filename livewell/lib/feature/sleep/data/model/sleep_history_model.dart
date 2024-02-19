import 'dart:convert';

class SleepHistoryModel {
  Map<String, Response>? response;

  SleepHistoryModel({
    this.response,
  });

  SleepHistoryModel copyWith({
    Map<String, Response>? response,
  }) =>
      SleepHistoryModel(
        response: response ?? this.response,
      );

  factory SleepHistoryModel.fromRawJson(String str) =>
      SleepHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SleepHistoryModel.fromJson(Map<String, dynamic> json) =>
      SleepHistoryModel(
        response: Map.from(json["response"]!)
            .map((k, v) => MapEntry<String, Response>(k, Response.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "response": Map.from(response!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
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

  Response copyWith({
    DateTime? startTime,
    DateTime? endTime,
    int? total,
    Unit? unit,
    List<Detail>? details,
  }) =>
      Response(
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        total: total ?? this.total,
        unit: unit ?? this.unit,
        details: details ?? this.details,
      );

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        total: json["total"],
        unit: unitValues.map[json["unit"] ?? "MINUTES"]!,
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "total": total,
        "unit": unitValues.reverse[unit],
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
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

  Detail copyWith({
    int? value,
    Type? type,
    Unit? unit,
    String? dateFrom,
    String? dateTo,
  }) =>
      Detail(
        value: value ?? this.value,
        type: type ?? this.type,
        unit: unit ?? this.unit,
        dateFrom: dateFrom ?? this.dateFrom,
        dateTo: dateTo ?? this.dateTo,
      );

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

enum Type { SLEEP_IN_BED }

final typeValues = EnumValues({"SLEEP_IN_BED": Type.SLEEP_IN_BED});

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
