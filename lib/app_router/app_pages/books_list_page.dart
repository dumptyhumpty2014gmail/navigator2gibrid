import 'package:flutter/material.dart';

import '../../ui/pages/books_list_page/books_list_screen.dart';
import '../app_page.dart';
import '../app_page_url.dart';

class AppPageBookList extends AppPage {
  @override
  ValueKey get key => ValueKey('AppPageBookList');
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BooksListScreen();
      },
    );
  }

  @override
  AppPageUrl get pageUrl => AppPageUrl.booksList;

  @override
  Map<String, String> get queryParameters => {};
}
