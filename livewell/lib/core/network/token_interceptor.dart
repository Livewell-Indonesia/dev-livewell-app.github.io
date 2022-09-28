import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/feature/auth/data/model/login_model.dart';
import 'package:livewell/feature/auth/domain/entity/login.dart';
import 'package:livewell/routes/app_navigator.dart';

import '../../feature/auth/presentation/page/landing/landing_auth_screen.dart';
import '../error/failures.dart';
import 'network_module.dart';

class TokenInterceptor extends Interceptor with NetworkModule {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var statusCode = err.response!.statusCode;
    if ((statusCode == 401 &&
            err.response?.data['message'] != 'invalid email or password') ||
        (statusCode == 400 &&
            err.response?.data['message'] == 'missing or malformed jwt')) {}
    super.onError(err, handler);
  }
}

class NewTokenInteceptor extends Interceptor with NetworkModule {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['Authorization'] != null) {
      Log.info("api Call using token, need to validate first");
      bool isTokenExpired = JwtDecoder.isExpired(await SharedPref.getToken());
      Log.info("Checking Token");
      Log.info(
          "current time ${DateTime.now()}, token expiration ${JwtDecoder.getExpirationDate(await SharedPref.getToken())}");
      if (isTokenExpired) {
        Log.info("Token Expired");
        var response = await refreshToken();
        response.fold((l) async {
          await SharedPref.removeToken();
          await SharedPref.removeRefreshToken();
          AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
        }, (r) async {
          await SharedPref.saveToken(r.accessToken ?? '');
          options.headers['Authorization'] = r.accessToken;
          handler.next(options);
        });
      } else {
        Log.info("Token still valid");
        handler.next(options);
      }
    } else {
      Log.info("api Call without token, no need to validate first");
      handler.next(options);
    }
  }

  Future<Either<Failure, Login>> refreshToken() async {
    try {
      final response = await postMethod(Endpoint.refreshToken,
          body: {"refresh_token": await SharedPref.getRefreshToken()});
      final json = responseHandler(response);
      final data = LoginModel.fromJson(json);
      return Right(data);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
