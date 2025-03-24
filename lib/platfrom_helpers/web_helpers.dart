import 'dart:js_interop';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart';
import 'i_platform_helpers.dart';

class WebPlatformHelpers implements IPlatformHelper {
  @override
  String getLocale() {
    final JSArray<JSString> locales = window.navigator.languages;

    return locales.length == 0 ? 'ru' : locales[0].toDart;
  }

  @override
  void pathUrlStrategy() {
    usePathUrlStrategy();
  }
}

IPlatformHelper getPlatformHelper() => WebPlatformHelpers();
