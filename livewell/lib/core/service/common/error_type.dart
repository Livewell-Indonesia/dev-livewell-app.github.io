enum ErrorType {
  unauthorized,
  contentNotFound,
  serviceTimeout,
  serviceNotFound,
  socketException,
  badRequest,
  responseParse,
  unknownError,
}

extension ErrorTypeMessage on ErrorType {
  String? get message => valueMap[this];

  static const valueMap = {
    ErrorType.unauthorized: "Unauthorized user",
    ErrorType.contentNotFound: "Content Not Found",
    ErrorType.serviceTimeout: "Connection Timeout",
    ErrorType.serviceNotFound: "Endpoint Not Found",
    ErrorType.socketException: "Failed host lookup",
    ErrorType.badRequest: "Bad Request",
    ErrorType.responseParse: "Unable to parse response body",
    ErrorType.unknownError: "Unknown Error",
  };
}
