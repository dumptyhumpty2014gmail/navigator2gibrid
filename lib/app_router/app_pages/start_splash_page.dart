import 'package:flutter/material.dart';

import '../../ui/pages/start_page/start_screen.dart';
import '../app_page.dart';
import '../app_page_url.dart';

class AppPageStart extends AppPage {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return StartScreen();
      },
    );
  }

  @override
  AppPageUrl get pageUrl => AppPageUrl.startSlash;

  @override
  Map<String, String> get queryParameters => {};
}
