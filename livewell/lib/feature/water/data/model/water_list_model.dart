class WaterListModel {
  List<WaterModel>? response;

  WaterListModel({this.response});

  WaterListModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <WaterModel>[];
      json['response'].forEach((v) {
        response!.add(WaterModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WaterModel {
  String? createdAt;
  String? updatedAt;
  String? recordAt;
  int? value;
  String? type;
  String? unit;
  String? userReferenceId;

  WaterModel(
      {this.createdAt,
      this.updatedAt,
      this.recordAt,
      this.value,
      this.type,
      this.unit,
      this.userReferenceId});

  WaterModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    recordAt = json['record_at'];
    value = json['value'];
    type = json['type'];
    unit = json['unit'];
    userReferenceId = json['user_reference_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['record_at'] = recordAt;
    data['value'] = value;
    data['type'] = type;
    data['unit'] = unit;
    data['user_reference_id'] = userReferenceId;
    return data;
  }
}
