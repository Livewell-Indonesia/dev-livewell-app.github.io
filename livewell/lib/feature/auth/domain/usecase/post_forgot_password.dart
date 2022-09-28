import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/auth/domain/entity/register.dart';

import '../../../../core/error/failures.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../repository/auth_repository.dart';

class PostForgotPassword extends UseCase<Register, ParamsForgotPassword> {
  late AuthRepository repository;

  PostForgotPassword.instance() {
    repository = AuthRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, Register>> call(ParamsForgotPassword params) async {
    return await repository.forgotPassword(params);
  }
}

class ParamsForgotPassword {
  String email;

  ParamsForgotPassword({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
