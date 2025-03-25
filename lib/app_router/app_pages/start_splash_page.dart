import 'package:flutter/material.dart';

import '../../ui/pages/start_page/start_screen.dart';
import '../app_page.dart';
import '../app_page_url.dart';

class AppPageStart extends AppPage {
  @override
  ValueKey get key => const ValueKey('AppPageStart');
  @override
  Route<StartScreen> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: const Duration(milliseconds: 0), //стартовый экран без анимации
      pageBuilder: (context, _, __) => StartScreen(),
    );
  }

  @override
  AppPageUrl get pageUrl => AppPageUrl.startSlash;

  @override
  Map<String, String> get queryParameters => {};
}
