import 'package:dio/dio.dart';

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
