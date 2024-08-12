import 'dart:async';

import 'package:livewell/core/network/token_interceptor.dart';

import 'api_url.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'logging_interceptor.dart';

class DioModule with DioMixin implements Dio {
  DioModule._([BaseOptions? options]) {
    options ??= BaseOptions(
      baseUrl: Endpoint.api,
      contentType: 'application/json',
      connectTimeout: 30000,

      ///for network time out
      sendTimeout: 30000,
      receiveTimeout: 30000,
    );

    this.options = options;
    interceptors.add(LoggingInterceptor());
    interceptors.add(NewTokenInteceptor());
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  static Dio getInstance([BaseOptions? options]) => DioModule._(options);
  static Completer<String>? refreshTokenCompleter;
}
