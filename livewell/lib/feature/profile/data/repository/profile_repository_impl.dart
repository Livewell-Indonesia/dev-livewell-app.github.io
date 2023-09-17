import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/local_storage/shared_pref.dart';
import '../../../auth/data/model/register_model.dart';
import '../../domain/repository/profile_repository.dart';
import '../../domain/usecase/update_user_info.dart';

class UserProfileRepositoryImpl with NetworkModule
    implements UserProfileRepository {
  UserProfileRepositoryImpl._();

  static UserProfileRepositoryImpl getInstance() =>
      UserProfileRepositoryImpl._();

  @override
  Future<Either<Failure, RegisterModel>> updateUserProfile(
      UpdateUserInfoParams params) async {
    try {
      final response = await postMethod(Endpoint.user,
          body: params.toJson(),
          headers: {authorization: await SharedPref.getToken()});
      final data = responseHandler(response);
      return Right(RegisterModel.fromJson(data));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterModel>> uploadPhoto(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "document": await MultipartFile.fromFile(file.path,
            filename: fileName, contentType: MediaType.parse('image/png')),
      });
      await postUploadDocument(Endpoint.uploadPhoto, Endpoint.api,
          headers: {authorization: await SharedPref.getToken()},
          body: formData);
      return Right(RegisterModel());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
