import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:livewell/feature/auth/domain/entity/login.dart';
import 'package:livewell/feature/auth/domain/repository/auth_repository.dart';

class PostLogin implements UseCase<Login, ParamsLogin> {
  late AuthRepository repository;

  PostLogin.instance() {
    repository = AuthRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, Login>> call(ParamsLogin params) async {
    return await repository.login(params);
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
