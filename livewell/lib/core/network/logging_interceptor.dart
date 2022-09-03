import 'dart:async';

import 'package:dio/dio.dart';
import 'package:livewell/core/log.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.colorGreen(
      "--> ${options.method.toUpperCase()} ${(options.baseUrl) + options.path}",
    );

    Log.info("Headers:");
    options.headers.forEach(
      (k, v) => print('$k: $v'),
    );

    Log.info("queryParameters:");
    options.queryParameters.forEach(
      (k, v) => Log.colorGreen('$k: $v'),
    );

    if (options.data != null) {
      Log.colorGreen("Body: ${options.data}");
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    Log.info(
      "<-- ${response.statusCode} ${response.requestOptions.baseUrl + response.requestOptions.path}",
    );

    Log.info("Headers:");
    response.headers.forEach(
      (k, v) => print('$k: $v'),
    );

    Log.info("Response: ${response.data}");
    Log.info("<-- END HTTP");
    Log.info(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError dioError, ErrorInterceptorHandler handler) async {
    Log.error(
      'ERROR[${dioError.response?.statusCode}] => PATH: ${dioError.requestOptions.path}',
    );

    Log.error(
      "<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL')}",
    );

    Log.error(
      "${dioError.response != null ? dioError.response!.data : 'Unknown Error'}",
    );

    Log.error("<-- End error");

    return super.onError(dioError, handler);
  }
}
