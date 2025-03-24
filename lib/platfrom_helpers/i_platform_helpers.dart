import 'package:flutter/foundation.dart';

import 'stub_helpers.dart' if (dart.library.io) 'other_platform_helpers.dart' if (dart.library.js_interop) 'web_helpers.dart';

abstract class IPlatformHelper {
  String getLocale() {
    return 'ru';
  }

  void pathUrlStrategy() {}
  factory IPlatformHelper() => getPlatformHelper();
  static String assetPath() {
    if (kIsWeb) {
      return '';
    } else {
      return 'assets';
    }
  }
}
