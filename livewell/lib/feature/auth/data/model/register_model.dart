import 'package:livewell/feature/auth/domain/entity/register.dart';

class RegisterModel extends Register {
  @override
  // ignore: overridden_fields
  String? message;

  RegisterModel({message});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
