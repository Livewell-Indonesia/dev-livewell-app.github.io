class MoodsModel {
  List<Mood>? response;

  MoodsModel({this.response});

  MoodsModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <Mood>[];
      json['response'].forEach((v) {
        response!.add(Mood.fromJson(v));
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

class Mood {
  String? createdAt;
  String? updatedAt;
  String? recordAt;
  int? value;
  String? desc;
  String? userReferenceId;

  Mood(
      {this.createdAt,
      this.updatedAt,
      this.recordAt,
      this.value,
      this.desc,
      this.userReferenceId});

  Mood.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    recordAt = json['record_at'];
    value = json['value'];
    desc = json['desc'];
    userReferenceId = json['user_reference_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['record_at'] = recordAt;
    data['value'] = value;
    data['desc'] = desc;
    data['user_reference_id'] = userReferenceId;
    return data;
  }
}
