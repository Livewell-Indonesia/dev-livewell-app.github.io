// To parse this JSON data, do
//
//     final loginEntity = loginEntityFromJson(jsonString);

import 'package:livewell/feature/auth/domain/entity/login.dart';

class LoginModel extends Login {
  String? accessToken;
  String? refreshToken;

  LoginModel({accessToken, refreshToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
