import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sentry/sentry.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

import '../error/error_const.dart';
import 'api_exception.dart';
import 'dio_module.dart';
import 'result.dart';

mixin NetworkModule {
  Dio get dio => DioModule.getInstance();

  BaseOptions? _baseOptions;

  final Map<String, String> header = {};
  final String authorization = "Authorization";
  CancelToken cancelToken = CancelToken();

  Future<Result<T>> _safeCallApi<T>(Future<Response<T>> call) async {
    try {
      final response = await call;
      return Result.success(
        response.data as T,
        response.statusMessage,
        response.statusCode,
      );
    } on DioError catch (e, stacktrace) {
      Sentry.captureException(e, stackTrace: stacktrace);
      if (e.type == DioErrorType.response) {
        return Result.error(e.response!.statusCode ?? 400, e.response!.data, message: e.response!.data['message']);
      } else {
        return Result.timeout(
          '' as dynamic,
          ErrorConst.networkError,
        );
      }
    }
  }

  Future<Result<dynamic>> getMethod(
    String endpoint, {
    Map<String, dynamic>? param,
    Map<String, String>? headers,
  }) async {
    if (headers != null) {
      headers.addAll(await userAgentClientHintsHeader());
    }
    Options _options = Options(headers: headers);

    final response = await _safeCallApi(
      dio.get(
        endpoint,
        queryParameters: param,
        options: _options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>> postMethod(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? param,
  }) async {
    if (headers != null) {
      headers.addAll(await userAgentClientHintsHeader());
    }
    Options _options = Options(headers: headers);
    final response = await _safeCallApi(
      dio.post(
        endpoint,
        data: jsonEncode(body),
        queryParameters: param,
        options: _options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>> putMethod(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    if (headers != null) {
      headers.addAll(await userAgentClientHintsHeader());
    }
    Options _options = Options(headers: headers);

    final response = await _safeCallApi(
      dio.put(
        endpoint,
        data: body,
        options: _options,
      ),
    );

    return response;
  }

  Future<Result> postUploadDocument(
    String endpoint,
    String url, {
    Map<String, String>? headers,
    FormData? body,
  }) async {
    if (headers != null) {
      headers.addAll(await userAgentClientHintsHeader());
    }
    Options _options = Options(headers: headers);
    Dio dio = DioModule.getInstance(
      BaseOptions(baseUrl: url),
    );

    final response = await _safeCallApi(
      dio.post(
        endpoint,
        data: body,
        options: _options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>> deleteMethod(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    Options _options = Options(headers: headers);

    final response = await _safeCallApi(
      dio.delete(
        endpoint,
        data: body,
        options: _options,
      ),
    );

    return response;
  }

  /// [dynamic] this method is return response from [Response.remote]
  dynamic responseHandler(Result<dynamic> result) {
    switch (result.status) {
      case Status.SUCCESS:
        return result.body;
      case Status.ERROR:
        if (result.code == 401) {
          throw UnAuthorizedExceptions(result.message ?? '');
        } else {
          throw ErrorRequestException(result.code!, result.message);
        }
      case Status.UNREACHABLE:
        throw NetworkException(result.message);
      default:
        throw ArgumentError();
    }
  }

  String handleError(dynamic ex) {
    ///Error Unauthorized Exceptions
    if (ex is UnAuthorizedExceptions) {
      return ex.errorBody.toString();
    }

    ///Error Request Exceptions
    else if (ex is ErrorRequestException) {
      return ex.errorBody.toString();
    }

    ///Error Network Exceptions
    else if (ex is NetworkException) {
      return ex.message.toString();
    } else {
      return 'Error!!!';
    }
  }
}
