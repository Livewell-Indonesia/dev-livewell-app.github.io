class WeightHistory {
  String? userReferenceId;
  String? recordAt;
  num? height;
  num? weight;
  num? bmi;
  num? bmr;

  WeightHistory(
      {this.userReferenceId,
      this.recordAt,
      this.height,
      this.weight,
      this.bmi,
      this.bmr});

  WeightHistory.fromJson(Map<String, dynamic> json) {
    userReferenceId = json['user_reference_id'];
    recordAt = json['record_at'];
    height = json['height'];
    weight = json['weight'];
    bmi = json['bmi'];
    bmr = json['bmr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_reference_id'] = userReferenceId;
    data['record_at'] = recordAt;
    data['height'] = height;
    data['weight'] = weight;
    data['bmi'] = bmi;
    data['bmr'] = bmr;
    return data;
  }
}
