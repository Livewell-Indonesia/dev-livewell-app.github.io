import 'dart:convert';

List<ActivityDataModel> activityDataModelFromJson(String str) =>
    List<ActivityDataModel>.from(
        json.decode(str).map((x) => ActivityDataModel.fromJson(x)));

String homeModelToJson(List<ActivityDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityDataModel {
  num? value;
  String? type;
  String? unit;
  String? dateFrom;
  String? dateTo;

  ActivityDataModel(
      {this.value, this.type, this.unit, this.dateFrom, this.dateTo});

  ActivityDataModel.fromJson(Map<String, dynamic> json) {
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
