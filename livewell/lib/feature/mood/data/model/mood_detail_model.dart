class MoodDetail {
  MoodDetailData? response;

  MoodDetail({this.response});

  MoodDetail.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new MoodDetailData.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['record_at'] = this.recordAt;
    data['value'] = this.value;
    data['desc'] = this.desc;
    data['user_reference_id'] = this.userReferenceId;
    return data;
  }
}
