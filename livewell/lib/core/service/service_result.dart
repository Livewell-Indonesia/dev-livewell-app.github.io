import 'common/error_type.dart';
import 'internal_response.dart';

class ServiceResult {
  InternalResponse? internalResponse;
  bool? isExecError;
  ErrorType? execErrorType;
  String? execErrorMessage;
  int? execStatusCode;
}
