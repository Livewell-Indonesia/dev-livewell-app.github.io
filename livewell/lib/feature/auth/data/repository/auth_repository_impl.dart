import 'dart:io' show Platform;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
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

  @override
  Future<Either<Failure, Login>> postAuthGoogle() async {
    try {
      var result = await GoogleSignIn(
        clientId: Platform.isIOS
            ? '649229634613-l8tqhjbf9o0lmu3mcs3ouhndi0aj5brk.apps.googleusercontent.com'
            : null,
        scopes: ['email', 'openid'],
      ).signIn();
      try {
        final response = await postMethod(Endpoint.loginGoogle, body: {
          'token': "TCoUNDaZIGUmbUckJaCHeYfirDIXtErAChouNBureNTiOsTyPT",
          'email': result?.email
        });
        final json = responseHandler(response);
        return Right(LoginModel.fromJson(json));
      } catch (ex) {
        Log.error(ex);
        return Left(ServerFailure(message: ex.toString()));
      }
    } catch (error) {
      Log.error(error);
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
