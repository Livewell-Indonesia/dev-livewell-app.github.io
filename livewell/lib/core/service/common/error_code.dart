enum ErrorCode {
  tokenExpired,
  tokenInvalid,
  refreshTokenExpired,
  refreshTokenInvalid,
}

extension ErrorCodeValue on ErrorCode {
  int get value => valueMap[this] ?? 0;

  static const valueMap = {
    ErrorCode.tokenExpired: 4356,
    ErrorCode.tokenInvalid: 4354,
    ErrorCode.refreshTokenExpired: 4359,
    ErrorCode.refreshTokenInvalid: 4357,
  };
}
