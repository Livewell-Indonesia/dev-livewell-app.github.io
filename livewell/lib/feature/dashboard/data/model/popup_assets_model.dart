class PopupAssetsModel {
  Exercise? exercise;
  Exercise? sleep;
  Exercise? water;

  PopupAssetsModel({this.exercise, this.sleep, this.water});

  PopupAssetsModel.fromJson(Map<String, dynamic> json) {
    exercise =
        json['exercise'] != null ? Exercise.fromJson(json['exercise']) : null;
    sleep = json['sleep'] != null ? Exercise.fromJson(json['sleep']) : null;
    water = json['water'] != null ? Exercise.fromJson(json['water']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (exercise != null) {
      data['exercise'] = exercise!.toJson();
    }
    if (sleep != null) {
      data['sleep'] = sleep!.toJson();
    }
    if (water != null) {
      data['water'] = water!.toJson();
    }
    return data;
  }
}

class Exercise {
  String? key;
  String? module;
  String? abovePicture;
  String? picture;
  String? belowPicture;
  String? extrasBelow;

  Exercise(
      {this.key,
      this.module,
      this.abovePicture,
      this.picture,
      this.belowPicture,
      this.extrasBelow});

  Exercise.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    module = json['module'];
    abovePicture = json['above_picture'];
    picture = json['picture'];
    belowPicture = json['below_picture'];
    extrasBelow = json['extras_below'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['module'] = module;
    data['above_picture'] = abovePicture;
    data['picture'] = picture;
    data['below_picture'] = belowPicture;
    data['extras_below'] = extrasBelow;
    return data;
  }
}
