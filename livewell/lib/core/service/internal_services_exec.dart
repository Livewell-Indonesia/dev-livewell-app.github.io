import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:livewell/core/service/service_result.dart';

import '../log.dart';
import 'common/error_type.dart';
import 'internal_response.dart';

mixin InternalServiceExec {
  Future<ServiceResult> exec(Future<Response<dynamic>> post) async {
    ServiceResult serviceResult = ServiceResult();
    Response res;
    try {
      res = await post;
      //Log.info(res.data);
      /*try {
        //API plebo response content-type not json type.
        final jsonResult = json.decode(res.data);
        var internalRes = InternalResponse.fromJson(jsonResult);
        serviceResult.internalResponse = internalRes;
        serviceResult.execStatusCode = res.statusCode;
        serviceResult.isExecError = false;
        serviceResult.execErrorType = null;
        serviceResult.execErrorMessage = null;
      } catch (ex) {
        Log.error(ex);
        ErrorType errorType = ErrorType.responseParse;
        serviceResult.internalResponse = null;
        serviceResult.isExecError = true;
        serviceResult.execErrorType = errorType;
        serviceResult.execErrorMessage = ex.toString();
      }*/

      //Ternyata ada case 204 no content
      try {
        //API plebo response content-type not json type.
        if (res.data != null) {
          var jsonResult = jsonDecode(res.data);
          var internalRes = InternalResponse.fromJson(jsonResult);
          serviceResult.internalResponse = internalRes;
        } else {
          var internalRes =
              InternalResponse(errorCode: 0, payload: null, errorMessage: null);
          serviceResult.internalResponse = internalRes;
        }

        serviceResult.execStatusCode = res.statusCode;
        serviceResult.isExecError = false;
        serviceResult.execErrorType = null;
        serviceResult.execErrorMessage = null;
      } catch (ex, stacktrace) {
        //ignore error data parsing
        Log.error("Error Json Parsing ${ex.toString()} | $stacktrace");
        var internalRes =
            InternalResponse(errorCode: 0, payload: null, errorMessage: null);
        serviceResult.internalResponse = internalRes;
        serviceResult.execStatusCode = res.statusCode;
        serviceResult.isExecError = false;
        serviceResult.execErrorType = null;
        serviceResult.execErrorMessage = null;
      }
    } on DioError catch (ex) {
      Log.error(ex);
      ErrorType? errorType;

      if (ex.error is SocketException) {
        errorType = ErrorType.socketException;
      } else if (ex.type == DioErrorType.connectTimeout) {
        errorType = ErrorType.serviceTimeout;
      } else {
        errorType = ErrorType.unknownError;
      }

      //Error but still have response json-body
      if (ex.response != null && ex.response!.data != null) {
        //error
        Log.info(ex.message);
        Log.info(ex.response!.data);

        try {
          //API plebo response content-type not json type.
          final jsonResult = json.decode(ex.response!.data);
          var internalRes = InternalResponse.fromJson(jsonResult);

          serviceResult.internalResponse = internalRes;
          serviceResult.execStatusCode = ex.response!.statusCode;
          serviceResult.isExecError = false;
        } catch (ex2) {
          //Error and response not json
          Log.error(ex2);

          if (ex.response!.statusCode == HttpStatus.notFound) {
            errorType = ErrorType.serviceNotFound;
          } else if (ex.response!.statusCode == HttpStatus.unauthorized) {
            errorType = ErrorType.unauthorized;
          } else if (ex.response!.statusCode == HttpStatus.badRequest) {
            errorType = ErrorType.badRequest;
          } else {
            errorType = ErrorType.unknownError;
          }

          serviceResult.internalResponse = null;
          serviceResult.isExecError = true;
          serviceResult.execErrorType = errorType;
          serviceResult.execErrorMessage = ex2.toString();
        }
      } else {
        //Error exec level
        serviceResult.internalResponse = null;
        serviceResult.isExecError = true;
        serviceResult.execErrorType = errorType;
        serviceResult.execErrorMessage = ex.message;
      }
    }

    return serviceResult;
  }
}
