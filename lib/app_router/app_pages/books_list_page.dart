part of 'i_app_page.dart';

class BooksListAppPage implements IAppPage {
  @override
  Page get page => BooksListPage();

  @override
  PagePath get pagePath => PagePath.booksList;

  @override
  Map<String, String> get queryParameters => {};
}

class BooksListPage extends Page {
  BooksListPage() : super(key: ValueKey('bookslist'), restorationId: 'bookslist');

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BooksListScreen();
      },
    );
  }
}
