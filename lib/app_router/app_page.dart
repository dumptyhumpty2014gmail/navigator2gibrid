import 'package:flutter/material.dart';

import 'app_page_url.dart';

abstract interface class IAppPageMixin {
  ///для вывода url
  AppPageUrl get pageUrl;

  ///получить parametrs
  Map<String, String> get queryParameters;
}

abstract class AppPage extends Page implements IAppPageMixin {}
