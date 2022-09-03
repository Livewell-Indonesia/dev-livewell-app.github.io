import 'package:dio/dio.dart';
import 'package:rfitness_flutter/src/core/local_storage/shared_pref.dart';
import 'package:rfitness_flutter/src/core/navigator/navigation.dart';
import 'package:rfitness_flutter/src/core/network/network_module.dart';

class TokenInterceptor extends Interceptor with NetworkModule {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var statusCode = err.response!.statusCode;
    if ((statusCode == 401 &&
            err.response?.data['message'] != 'invalid email or password') ||
        (statusCode == 400 &&
            err.response?.data['message'] == 'missing or malformed jwt')) {
      SharedPref.deleteToken();
      NavigationService.instance.goToWelcomePage();
    }
    super.onError(err, handler);
  }
}
