class SleepActivityModel {
  int? totalValue;
  String? type;
  String? unit;
  String? dateFrom;
  String? dateTo;
  List<Details>? details;

  SleepActivityModel(
      {this.totalValue,
      this.type,
      this.unit,
      this.dateFrom,
      this.dateTo,
      this.details});

  SleepActivityModel.fromJson(Map<String, dynamic> json) {
    totalValue = json['total_value'];
    type = json['type'];
    unit = json['unit'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_value'] = totalValue;
    data['type'] = type;
    data['unit'] = unit;
    data['date_from'] = dateFrom;
    data['date_to'] = dateTo;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? value;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['type'] = type;
    data['unit'] = unit;
    data['date_from'] = dateFrom;
    data['date_to'] = dateTo;
    return data;
  }
}
