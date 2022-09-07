import 'package:equatable/equatable.dart';
import 'package:livewell/core/base/usecase.dart';

class PostLogin implements UseCase<String, ParamsLogin> {
  @override
  Future<String> call(ParamsLogin params) {
    return Future.delayed(const Duration(seconds: 1), () => 'Hello World');
  }
}

class ParamsLogin extends Equatable {
  final String? email;
  final String? password;

  const ParamsLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
