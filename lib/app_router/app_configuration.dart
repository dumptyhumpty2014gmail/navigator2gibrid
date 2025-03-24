import 'app_page.dart';
import 'app_pages/books_list_page.dart';
import 'app_pages/login_page.dart';
import 'app_pages/start_splash_page.dart';

//сделать конструкторы (почти декларативность)
//TODO сделать геттеры-проверки (опять же, почти декларативность)
class AppConfiguration {
  final List<AppPage> pages;

  AppConfiguration({required this.pages});

  static AppConfiguration start() => AppConfiguration(pages: [AppPageStart()]);
  static AppConfiguration login() => AppConfiguration(pages: [AppPageLogin()]);
  static AppConfiguration booksList() => AppConfiguration(pages: [AppPageBookList()]);
}
