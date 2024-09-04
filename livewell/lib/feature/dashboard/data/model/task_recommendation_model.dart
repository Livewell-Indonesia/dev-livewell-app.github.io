// To parse this JSON data, do
//
//     final taskRecommendationModel = taskRecommendationModelFromJson(jsonString);

import 'dart:convert';

TaskRecommendationModel taskRecommendationModelFromJson(String str) => TaskRecommendationModel.fromJson(json.decode(str));

String taskRecommendationModelToJson(TaskRecommendationModel data) => json.encode(data.toJson());

class TaskRecommendationModel {
  Response? response;

  TaskRecommendationModel({
    this.response,
  });

  factory TaskRecommendationModel.fromJson(Map<String, dynamic> json) => TaskRecommendationModel(
        response: json["response"] == null ? null : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response?.toJson(),
      };
}

class Response {
  String? recommendation;
  List<ListElement>? list;
  DateTime? time;
  String? referenceId;

  Response({
    this.recommendation,
    this.list,
    this.time,
    this.referenceId,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        recommendation: json["recommendation"],
        list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        referenceId: json["reference_id"],
      );

  Map<String, dynamic> toJson() => {
        "recommendation": recommendation,
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
        "time": time?.toIso8601String(),
        "reference_id": referenceId,
      };
}

class ListElement {
  String? title;
  String? text;
  String? type;

  ListElement({
    this.title,
    this.text,
    this.type,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        title: json["title"],
        text: json["text"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "type": type,
      };
}
