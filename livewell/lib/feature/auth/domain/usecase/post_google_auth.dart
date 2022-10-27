import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../entity/login.dart';
import '../repository/auth_repository.dart';

class PostAuthGoogle {
  late AuthRepository repository;

  PostAuthGoogle.instance() {
    repository = AuthRepositoryImpl.getInstance();
  }
  Future<Either<Failure, Login>> call() async {
    return await repository.postAuthGoogle();
  }
}
