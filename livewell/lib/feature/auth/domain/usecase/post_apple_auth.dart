import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:livewell/feature/auth/domain/repository/auth_repository.dart';

import '../entity/login.dart';

class PostAppleAuth {
  late AuthRepository repository;

  PostAppleAuth.instance() {
    repository = AuthRepositoryImpl.getInstance();
  }
  Future<Either<Failure, Login>> call() async {
    return await repository.postAuthApple();
  }
}
