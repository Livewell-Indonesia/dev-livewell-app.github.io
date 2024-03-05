import 'dart:convert';

class FeatureLimitModel {
  List<Response>? response;

  FeatureLimitModel({
    this.response,
  });

  FeatureLimitModel copyWith({
    List<Response>? response,
  }) =>
      FeatureLimitModel(
        response: response ?? this.response,
      );

  factory FeatureLimitModel.fromRawJson(String str) =>
      FeatureLimitModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeatureLimitModel.fromJson(Map<String, dynamic> json) =>
      FeatureLimitModel(
        response: json["response"] == null
            ? []
            : List<Response>.from(
                json["response"]!.map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class Response {
  String? featureName;
  int? currentUsage;
  int? currentLimit;
  int? defaultLimit;
  DateTime? expiredAt;

  Response({
    this.featureName,
    this.currentUsage,
    this.currentLimit,
    this.defaultLimit,
    this.expiredAt,
  });

  Response copyWith({
    String? featureName,
    int? currentUsage,
    int? currentLimit,
    int? defaultLimit,
    DateTime? expiredAt,
  }) =>
      Response(
        featureName: featureName ?? this.featureName,
        currentUsage: currentUsage ?? this.currentUsage,
        currentLimit: currentLimit ?? this.currentLimit,
        defaultLimit: defaultLimit ?? this.defaultLimit,
        expiredAt: expiredAt ?? this.expiredAt,
      );

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        featureName: json["feature_name"],
        currentUsage: json["current_usage"],
        currentLimit: json["current_limit"],
        defaultLimit: json["default_limit"],
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.parse(json["expired_at"]),
      );

  Map<String, dynamic> toJson() => {
        "feature_name": featureName,
        "current_usage": currentUsage,
        "current_limit": currentLimit,
        "default_limit": defaultLimit,
        "expired_at": expiredAt?.toIso8601String(),
      };
}
