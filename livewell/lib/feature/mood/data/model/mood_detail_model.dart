class MoodDetail {
  MoodDetailData? response;

  MoodDetail({this.response});

  MoodDetail.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? MoodDetailData.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class MoodDetailData {
  String? createdAt;
  String? updatedAt;
  String? recordAt;
  int? value;
  String? desc;
  String? userReferenceId;

  MoodDetailData(
      {this.createdAt,
      this.updatedAt,
      this.recordAt,
      this.value,
      this.desc,
      this.userReferenceId});

  MoodDetailData.fromJson(Map<String, dynamic> json) {
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
