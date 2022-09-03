abstract class ApiException implements Exception {
  final String? _prefix;
  final String? _message;

  ApiException(this._prefix, this._message);

  String toString() {
    return '$_prefix :$_message}';
  }
}

class UnAuthorizedExceptions extends ApiException {
  final String errorBody;

  UnAuthorizedExceptions(this.errorBody) : super("UnAuthorized", errorBody);
}

class NetworkException extends ApiException {
  final String? message;
  NetworkException(this.message) : super("Network Error", message);
}

class ErrorRequestException extends ApiException {
  final int errorCode;
  final dynamic errorBody;
  ErrorRequestException(this.errorCode, this.errorBody)
      : super("Error $errorCode", "$errorBody");
}
