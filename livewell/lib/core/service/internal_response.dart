import 'dart:convert';

/// build : "202202221537"
/// version : "3.62"
/// errorCode : 4353
/// errorMessage : "message"
/// time : 0.480811811
/// payload : {}

InternalResponse resFromJson(String str) =>
    InternalResponse.fromJson(json.decode(str));

class InternalResponse {
  InternalResponse({
    int? errorCode,
    String? errorMessage,
    dynamic payload,
  }) {
    _errorCode = errorCode;
    _errorMessage = errorMessage;
    _payload = payload;
  }

  InternalResponse.fromJson(dynamic json) {
    //Ternyata tidak semua response array dibungkus dalam object, ada yg langsung array
    //Check json is array or object
    if (json is List) {
      _errorCode = 0;
      _errorMessage = null;
      _payload = json;
    } else {
      _errorCode = json['code'] ?? 0;
      _errorMessage = null;

      //Is Error
      if (_errorCode != 0) {
        _errorCode = json['code'] ?? 0;
        if (json['message'] is List) {
          _errorMessage = json['message'][0];
        } else {
          _errorMessage = json['message'];
        }
      } else {
        _payload = json;
      }
    }

    //Log.info(toString());
  }

  int? _errorCode;
  String? _errorMessage;
  dynamic _payload;

  int? get errorCode => _errorCode;

  String? get errorMessage => _errorMessage;

  dynamic get payload => _payload;

  @override
  String toString() {
    return 'InternalResponse{_errorCode: $_errorCode, _errorMessage: $_errorMessage, _payload: $_payload}';
  }
}
