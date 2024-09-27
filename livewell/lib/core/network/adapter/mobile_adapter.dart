import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

HttpClientAdapter getAdapter() {
  return DefaultHttpClientAdapter()
    ..onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return null;
    };
}
