import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../ui/pages/book_page/book_screen.dart';
import '../app_page.dart';
import '../app_page_url.dart';

class AppPageBook extends AppPage {
  final int? id;
  AppPageBook({required this.id});
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return PopScope(
          ///для защиты от pop
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (kDebugMode) {
              print('didPop $didPop result $result');
            }
          },
          child: BookDetailsScreen(id: id),
        );
      },
    );
  }

  @override
  AppPageUrl get pageUrl => AppPageUrl.book;

  @override
  Map<String, String> get queryParameters => {bookidParameterName: id.toString()};

  static const String bookidParameterName = 'bookid';
}
