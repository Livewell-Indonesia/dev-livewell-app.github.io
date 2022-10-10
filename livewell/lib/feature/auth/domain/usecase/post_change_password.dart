import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/auth/domain/entity/register.dart';

import '../../../../core/error/failures.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../repository/auth_repository.dart';

class PostChangePassword extends UseCase<Register, ChangePasswordParams> {
  late AuthRepository repository;

  PostChangePassword.getInstance() {
    repository = AuthRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, Register>> call(ChangePasswordParams params) async {
    return await repository.changePassword(params);
  }
}

class ChangePasswordParams {
  final String code;
  final String newPassword;

  ChangePasswordParams({required this.code, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'password': newPassword,
    };
  }
}
