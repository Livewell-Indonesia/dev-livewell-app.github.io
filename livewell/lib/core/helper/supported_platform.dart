import 'dart:io';

import 'package:flutter/foundation.dart';

enum SupportedPlatformType { web, android, ios, unsupported }

class SupportedPlatform {
  static SupportedPlatformType get current {
    if (kIsWeb) {
      return SupportedPlatformType.web;
    }
    if (Platform.isAndroid) {
      return SupportedPlatformType.android;
    } else if (Platform.isIOS) {
      return SupportedPlatformType.ios;
    } else {
      return SupportedPlatformType.unsupported;
    }
  }
}
