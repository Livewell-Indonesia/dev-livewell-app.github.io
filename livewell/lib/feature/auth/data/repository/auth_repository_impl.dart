import 'package:livewell/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/network/api_exception.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/core/network/parser_json.dart';
import 'package:livewell/feature/auth/data/model/login_model.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/auth/domain/entity/register.dart';
import 'package:livewell/feature/auth/domain/repository/auth_repository.dart';
import 'package:livewell/feature/auth/domain/usecase/post_change_password.dart';
import 'package:livewell/feature/auth/domain/usecase/post_forgot_password.dart';
import 'package:livewell/feature/auth/domain/usecase/post_register.dart';

import '../../domain/entity/login.dart';
import '../../domain/usecase/post_login.dart';

class AuthRepositoryImpl extends NetworkModule implements AuthRepository {
  AuthRepositoryImpl._();

  static AuthRepositoryImpl getInstance() => AuthRepositoryImpl._();
  @override
  Future<Either<Failure, Login>> login(ParamsLogin params) async {
    try {
      final response = await postMethod(Endpoint.login, body: params.toJson());
      final json = responseHandler(response);
      return Right(LoginModel.fromJson(json));
    } catch (ex) {
      Log.error(ex);
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, Register>> register(ParamsRegister params) async {
    try {
      final response =
          await postMethod(Endpoint.register, body: params.toJson());
      final json = responseHandler(response);
      return Right(RegisterModel.fromJson(json));
    } catch (ex) {
      Log.error(ex);
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, Register>> forgotPassword(
      ParamsForgotPassword params) async {
    try {
      final response =
          await postMethod(Endpoint.forgotPassword, body: params.toJson());
      final json = responseHandler(response);
      return Right(RegisterModel.fromJson(json));
    } catch (ex) {
      Log.error(ex);
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, Register>> changePassword(
      ChangePasswordParams params) async {
    try {
      final response =
          await postMethod(Endpoint.changePassword, body: params.toJson());
      final json = responseHandler(response);
      return Right(RegisterModel.fromJson(json));
    } catch (ex) {
      Log.error(ex);
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
