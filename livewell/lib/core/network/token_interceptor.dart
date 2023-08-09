import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/result.dart';
import 'package:livewell/feature/auth/data/model/login_model.dart';
import 'package:livewell/feature/auth/domain/entity/login.dart';
import 'package:livewell/routes/app_navigator.dart';

import '../error/failures.dart';
import 'network_module.dart';

class TokenInterceptor extends Interceptor implements NetworkModule {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var statusCode = err.response!.statusCode;
    if ((statusCode == 401 &&
            err.response?.data['message'] != 'invalid email or password') ||
        (statusCode == 400 &&
            err.response?.data['message'] == 'missing or malformed jwt')) {}
    super.onError(err, handler);
  }

  @override
  // TODO: implement authorization
  String get authorization => throw UnimplementedError();

  @override
  Future<Result> deleteMethod(String endpoint,
      {Map<String, String>? headers, Map<String, dynamic>? body}) {
    // TODO: implement deleteMethod
    throw UnimplementedError();
  }

  @override
  Future<Result> getMethod(String endpoint,
      {Map<String, dynamic>? param, Map<String, String>? headers}) {
    // TODO: implement getMethod
    throw UnimplementedError();
  }

  @override
  String handleError(ex) {
    // TODO: implement handleError
    throw UnimplementedError();
  }

  @override
  // TODO: implement header
  Map<String, String> get header => throw UnimplementedError();

  @override
  Future<Result> postMethod(String endpoint,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? param}) {
    // TODO: implement postMethod
    throw UnimplementedError();
  }

  @override
  Future<Result> postUploadDocument(String endpoint, String url,
      {Map<String, String>? headers, FormData? body}) {
    // TODO: implement postUploadDocument
    throw UnimplementedError();
  }

  @override
  Future<Result> putMethod(String endpoint,
      {Map<String, dynamic>? headers, Map<String, dynamic>? body}) {
    // TODO: implement putMethod
    throw UnimplementedError();
  }

  @override
  responseHandler(Result result) {
    // TODO: implement responseHandler
    throw UnimplementedError();
  }
}

class NewTokenInteceptor extends Interceptor implements NetworkModule {
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
          AppNavigator.pushAndRemove(routeName: '/');
        }, (r) async {
          await SharedPref.saveToken(r.accessToken ?? '');
          await SharedPref.saveRefreshToken(r.refreshToken ?? '');
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

  @override
  // TODO: implement authorization
  String get authorization => throw UnimplementedError();

  @override
  Future<Result> deleteMethod(String endpoint,
      {Map<String, String>? headers, Map<String, dynamic>? body}) {
    // TODO: implement deleteMethod
    throw UnimplementedError();
  }

  @override
  Future<Result> getMethod(String endpoint,
      {Map<String, dynamic>? param, Map<String, String>? headers}) {
    // TODO: implement getMethod
    throw UnimplementedError();
  }

  @override
  String handleError(ex) {
    // TODO: implement handleError
    throw UnimplementedError();
  }

  @override
  // TODO: implement header
  Map<String, String> get header => throw UnimplementedError();

  @override
  Future<Result> postMethod(String endpoint,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? param}) {
    // TODO: implement postMethod
    throw UnimplementedError();
  }

  @override
  Future<Result> postUploadDocument(String endpoint, String url,
      {Map<String, String>? headers, FormData? body}) {
    // TODO: implement postUploadDocument
    throw UnimplementedError();
  }

  @override
  Future<Result> putMethod(String endpoint,
      {Map<String, dynamic>? headers, Map<String, dynamic>? body}) {
    // TODO: implement putMethod
    throw UnimplementedError();
  }

  @override
  responseHandler(Result result) {
    // TODO: implement responseHandler
    throw UnimplementedError();
  }
}
