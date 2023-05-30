import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:livewell/feature/profile/domain/repository/profile_repository.dart';

class UploadPhoto extends UseCase<RegisterModel, File> {
  late UserProfileRepository repository;

  UploadPhoto.instance() {
    repository = UserProfileRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, RegisterModel>> call(File params) async {
    return await repository.uploadPhoto(params);
  }
}
