import 'package:flutter/material.dart';

import '../../ui/pages/login_page/login_screen.dart';
import '../app_page.dart';
import '../app_page_url.dart';

class AppPageLogin extends AppPage {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return LoginScreen();
      },
    );
  }

  @override
  AppPageUrl get pageUrl => AppPageUrl.login;

  @override
  Map<String, String> get queryParameters => {};
}
