import 'package:flutter/foundation.dart';

class Config {
  static const environment = String.fromEnvironment('ENV', defaultValue: 'DEV');
  static final Map<String, Map<String, dynamic>> _args = {
    'DEV': _dev,
    'STG': _stg,
    'PROD': _prod,
  };
  static const String _keyIsLogEnable = 'isLogEnable';
  static const String _keyBaseUrl = 'baseUrl';
  static const String _keyConnectTimeout = 'connectTimeout';
  static const String _keyReceiveTimeout = 'receiveTimeout';
  static const String _keyIsHttpLogEnable = 'isHttpLogInterceptorEnable';

  static final _dev = {
    _keyIsLogEnable: true,
    _keyIsHttpLogEnable: true,
    _keyBaseUrl: 'https://plebofleet.calvinbenhardi.com',
    _keyConnectTimeout: 60 * 1000,
    _keyReceiveTimeout: 60 * 1000,
  };

  static final _stg = {
    _keyIsLogEnable: false,
    _keyIsHttpLogEnable: false,
    _keyBaseUrl: 'https://plebofleet.calvinbenhardi.com',
    _keyConnectTimeout: 60 * 1000,
    _keyReceiveTimeout: 60 * 1000,
  };

  static final _prod = {
    _keyIsLogEnable: false,
    _keyIsHttpLogEnable: false,
    _keyBaseUrl: 'https://plebofleet.calvinbenhardi.com',
    _keyConnectTimeout: 60 * 1000,
    _keyReceiveTimeout: 60 * 1000,
  };

  static bool get isLogEnable =>
      kReleaseMode ? false : _args[environment]![_keyIsLogEnable] as bool;

  static bool get isHttpLogEnable =>
      kReleaseMode ? false : _args[environment]![_keyIsHttpLogEnable] as bool;

  static String get baseUrl => _args[environment]![_keyBaseUrl] as String;

  static int get connectTimeout =>
      _args[environment]![_keyConnectTimeout] as int;

  static int get receiveTimeout =>
      _args[environment]![_keyReceiveTimeout] as int;

  //Todo, note: modify disini untuk kondisi real release modenya
  // Default is true,
  //     Disable when build modenya Release & Env nya PROD
  //     run release mode dan spesifik env:
  //     flutter run --dart-define="ENV=DEV" --release
  //     flutter run --dart-define="ENV=PROD" --release
  //     run debug mode dan spesifik env:
  //     flutter run --dart-define="ENV=PROD"
  //     flutter run

  static bool isDebugINformationEnable() {
    bool result = true;
    result = !(environment == "PROD" && kReleaseMode);
    return result;
  }
}
