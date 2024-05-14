import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/auth/domain/entity/register.dart';

import '../../../../core/error/failures.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../repository/auth_repository.dart';

class PostRegister implements UseCase<Register, ParamsRegister> {
  late AuthRepository repository;

  PostRegister.instance() {
    repository = AuthRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, Register>> call(ParamsRegister params) async {
    return await repository.register(params);
  }
}

class ParamsRegister extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;

  const ParamsRegister({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmation_password': confirmPassword,
    };
  }
}
