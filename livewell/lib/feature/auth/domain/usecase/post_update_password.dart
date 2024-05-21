import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:livewell/feature/auth/domain/entity/register.dart';
import 'package:livewell/feature/auth/domain/repository/auth_repository.dart';

class UpdatePasswordParams {
  final String password;
  final String confirmPassword;

  UpdatePasswordParams({required this.password, required this.confirmPassword});

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'confirmation_password': confirmPassword,
    };
  }
}

class PostUpdatePassword implements UseCase<Register, UpdatePasswordParams> {
  late AuthRepository repository;

  PostUpdatePassword.instance() {
    repository = AuthRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, Register>> call(UpdatePasswordParams params) async {
    return await repository.updatePassword(params);
  }
}
