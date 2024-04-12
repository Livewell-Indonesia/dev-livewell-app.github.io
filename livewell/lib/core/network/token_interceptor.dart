import 'dart:async';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/feature/auth/data/model/login_model.dart';
import 'package:livewell/feature/auth/domain/entity/login.dart';
import 'package:livewell/routes/app_navigator.dart';

import '../error/failures.dart';
import 'network_module.dart';

class TokenInterceptor extends Interceptor with NetworkModule {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var statusCode = err.response!.statusCode;
    if ((statusCode == 401 && err.response?.data['message'] != 'invalid email or password') || (statusCode == 400 && err.response?.data['message'] == 'missing or malformed jwt')) {}
    super.onError(err, handler);
  }
}

class NewTokenInteceptor extends QueuedInterceptor with NetworkModule {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final options = err.requestOptions;
      if (err.requestOptions.path == Endpoint.refreshToken) {
        await SharedPref.removeToken();
        await SharedPref.removeRefreshToken();
        EasyLoading.dismiss();
        Get.find<LanguageController>().changeLocalization(AvailableLanguage.en).then((value) {
          AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
        });
      } else {
        Log.info("Token Expired");
        await refreshToken();
        options.headers['Authorization'] = await SharedPref.getToken();
        final originalResult = await dio.fetch(options);
        handler.resolve(originalResult);
      }
    } else {
      return handler.next(err);
    }
  }

  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
  //   if (options.headers['Authorization'] != null) {
  //     options.headers['Authorization'] = await SharedPref.getToken();
  //   } else {
  //     Log.info("api Call without token, no need to validate first");
  //     handler.next(options);
  //   }
  //   return super.onRequest(options, handler);
  // }

  Future<void> refreshToken() async {
    try {
      final refreshToken = await SharedPref.getRefreshToken();
      final response = await postMethod(Endpoint.refreshToken, body: {'refresh_token': refreshToken});
      final json = responseHandler(response);
      final data = LoginModel.fromJson(json);
      await SharedPref.saveToken(data.accessToken ?? '');
      await SharedPref.saveRefreshToken(data.refreshToken ?? '');
    } catch (ex) {
      await SharedPref.removeToken();
      await SharedPref.removeRefreshToken();
      EasyLoading.dismiss();
      Get.find<LanguageController>().changeLocalization(AvailableLanguage.en).then((value) {
        AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
      });
    }
  }
}
