import 'dart:io';

import 'i_platform_helpers.dart';

class OtherPlatformHelpers implements IPlatformHelper {
  @override
  String getLocale() {
    return Platform.localeName;
  }

  @override
  void pathUrlStrategy() {
    //для мобилок ничего не запускаем
  }
}

IPlatformHelper getPlatformHelper() => OtherPlatformHelpers();
