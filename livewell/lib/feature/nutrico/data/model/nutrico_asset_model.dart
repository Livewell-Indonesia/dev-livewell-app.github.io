class NutricoAsset {
  Nutrico? nutrico;

  NutricoAsset({this.nutrico});

  NutricoAsset.fromJson(Map<String, dynamic> json) {
    nutrico =
        json['nutrico'] != null ? new Nutrico.fromJson(json['nutrico']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nutrico != null) {
      data['nutrico'] = this.nutrico!.toJson();
    }
    return data;
  }
}

class Nutrico {
  String? key;
  String? module;
  String? title;
  String? subTitle;
  String? example1SubHeader;
  String? example1Description;
  String? example2SubHeader;
  String? example2Description;
  String? example3SubHeader;
  String? example3Description;

  Nutrico(
      {this.key,
      this.module,
      this.title,
      this.subTitle,
      this.example1SubHeader,
      this.example1Description,
      this.example2SubHeader,
      this.example2Description,
      this.example3SubHeader,
      this.example3Description});

  Nutrico.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    module = json['module'];
    title = json['title'];
    subTitle = json['sub_title'];
    example1SubHeader = json['example_1_sub_header'];
    example1Description = json['example_1_description'];
    example2SubHeader = json['example_2_sub_header'];
    example2Description = json['example_2_description'];
    example3SubHeader = json['example_3_sub_header'];
    example3Description = json['example_3_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['module'] = this.module;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['example_1_sub_header'] = this.example1SubHeader;
    data['example_1_description'] = this.example1Description;
    data['example_2_sub_header'] = this.example2SubHeader;
    data['example_2_description'] = this.example2Description;
    data['example_3_sub_header'] = this.example3SubHeader;
    data['example_3_description'] = this.example3Description;
    return data;
  }
}
