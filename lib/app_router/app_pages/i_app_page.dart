import 'package:flutter/material.dart';

import '../../ui/pages/book_page/book_screen.dart';
import '../../ui/pages/books_list_page/books_list_screen.dart';
import '../../ui/pages/login_page/login_screen.dart';
import '../../ui/pages/start_page/start_screen.dart';
part 'start_splash_page.dart';
part 'login_page.dart';
part 'books_list_page.dart';
part 'book_page.dart';

sealed class IAppPage {
  ///непосредственно страница
  ///Обязательно использовать ValueKey, чтобы при изменении pages в роутере не было пересоздания.
  ///Пример: StartSplashPage() : super(key: ValueKey('startPage'), restorationId: 'startPage');
  Page get page;

  ///для вывода url
  PagePath get pagePath;

  ///получить parametrs
  Map<String, String> get queryParameters;
}

enum PagePath {
  startSlash('/'),
  login('login'),
  base('base'),
  booksList('books'),
  book('book'),
  authorsList('authors'),
  author('author');

  ///строка должна быть уникальная
  final String path;

  const PagePath(this.path);
}
