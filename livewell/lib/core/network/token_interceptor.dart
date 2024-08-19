import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/dio_module.dart';
import 'package:livewell/feature/auth/data/model/login_model.dart';
import 'package:livewell/routes/app_navigator.dart';

import 'network_module.dart';

class NewTokenInteceptor extends QueuedInterceptor with NetworkModule {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['Authorization'] != null) {
      // check if token is expired

      if (JwtDecoder.tryDecode(options.headers['Authorization']!) == null || JwtDecoder.isExpired(options.headers['Authorization']!)) {
        final result = await refreshToken();
        options.headers['Authorization'] = result;
        handler.next(options);
      } else {
        handler.next(options);
      }
    }
    return super.onRequest(options, handler);
  }

  Future<String> refreshToken() async {
    if (DioModule.refreshTokenCompleter != null) {
      return DioModule.refreshTokenCompleter!.future;
    } else {
      DioModule.refreshTokenCompleter = Completer<String>();
      try {
        await _refreshToken();
        final newToken = await SharedPref.getToken();
        if (!DioModule.refreshTokenCompleter!.isCompleted) {
          DioModule.refreshTokenCompleter!.complete(newToken);
        }
        return newToken;
      } catch (e) {
        if (!DioModule.refreshTokenCompleter!.isCompleted) {
          DioModule.refreshTokenCompleter!.completeError(e);
        }
        rethrow;
      } finally {
        DioModule.refreshTokenCompleter = null;
      }
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

  Future<void> _refreshToken() async {
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
      Get.find<LanguageController>().changeLocalization(AvailableLanguage.id).then((value) {
        AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
      });
      rethrow;
    }
  }
}
