import 'dart:convert';

List<ActivityDataModel> activityDataModelFromJson(String str) =>
    List<ActivityDataModel>.from(
        json.decode(str).map((x) => ActivityDataModel.fromJson(x)));

String homeModelToJson(List<ActivityDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityDataModel {
  num? totalValue;
  String? type;
  String? unit;
  String? dateFrom;
  String? dateTo;
  List<Details>? details;

  ActivityDataModel(
      {this.totalValue,
      this.type,
      this.unit,
      this.dateFrom,
      this.dateTo,
      this.details});

  ActivityDataModel.fromJson(Map<String, dynamic> json) {
    totalValue = json['total_value'];
    type = json['type'];
    unit = json['unit'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_value'] = this.totalValue;
    data['type'] = this.type;
    data['unit'] = this.unit;
    data['date_from'] = this.dateFrom;
    data['date_to'] = this.dateTo;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  num? value;
  String? type;
  String? unit;
  String? dateFrom;
  String? dateTo;

  Details({this.value, this.type, this.unit, this.dateFrom, this.dateTo});

  Details.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    type = json['type'];
    unit = json['unit'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['type'] = this.type;
    data['unit'] = this.unit;
    data['date_from'] = this.dateFrom;
    data['date_to'] = this.dateTo;
    return data;
  }
}
