enum Status {
  SUCCESS,
  ERROR,
  UNREACHABLE,
}

class Result<T> {
  Result(
    this.status,
    this.body, {
    this.code = 0,
    this.message = "",
  });

  final int code;
  final Status? status;
  final T body;
  final String? message;

  static Result<T> success<T>(T? data, String? message) {
    return Result(
      Status.SUCCESS,
      data!,
      message: message,
    );
  }

  static Result<T> error<T>(int code, T errorBody, {String? message}) {
    return Result(
      Status.ERROR,
      errorBody,
      code: code,
      message: message,
    );
  }

  static Result<T> timeout<T >(T? errorBody,  String message) {
    return Result(
      Status.UNREACHABLE,
      errorBody!,
      code: 0,
      message: message,
    );
  }
}
