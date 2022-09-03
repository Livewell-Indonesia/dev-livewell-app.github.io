import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class InternalServiceOption {
  final Dio _dio;

  InternalServiceOption(this._dio, {bool isLogEnable = false}) {
    dio.interceptors.addAll({
      LogInterceptor(
        requestBody: isLogEnable,
        responseBody: isLogEnable,
        request: isLogEnable,
        error: isLogEnable,
        requestHeader: isLogEnable,
        responseHeader: isLogEnable,
      ),
    });

    //fix issue CERTIFICATE_VERIFY_FAILED
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Dio get dio => _dio;
}
