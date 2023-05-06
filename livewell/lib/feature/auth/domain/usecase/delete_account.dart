import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:livewell/feature/auth/domain/entity/login.dart';
import 'package:livewell/feature/auth/domain/repository/auth_repository.dart';

class DeleteAccount {
  late AuthRepository repository;
  DeleteAccount.instance() {
    repository = AuthRepositoryImpl.getInstance();
  }

  Future<Either<Failure, Login>> call() async {
    return await repository.deleteAccount();
  }
}
