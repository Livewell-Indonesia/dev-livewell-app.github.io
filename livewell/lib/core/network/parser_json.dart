typedef Parser<T> = T Function(dynamic json);

class ParserJson<T> {
  late T? data;
  late String message;
  late int rescode;
  late Meta? meta;

  ParserJson({required data, required message, required rescode});

  ParserJson.fromJson(Map<String, dynamic> json, Parser<T> parser) {
    data = parser(json['data']);
    message = json['message'];
    rescode = json['rescode'];
    meta = json['meta'] == null ? null : Meta.fromJson(json['meta']);
  }
}

class Meta {
  late int? page;
  late int? rowPerPage;
  late int? total;

  Meta({required page, required rowPerPage, required total});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    rowPerPage = json['row_per_page'];
    total = json['total'];
  }
}
