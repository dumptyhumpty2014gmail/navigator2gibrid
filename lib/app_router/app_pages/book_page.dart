part of 'i_app_page.dart';

class BookAppPage implements IAppPage {
  final int? id;

  BookAppPage({required this.id});
  @override
  Page get page => BookPage(id: id);

  @override
  PagePath get pagePath => PagePath.book;

  @override
  Map<String, String> get queryParameters => {'book': id.toString()};
}

class BookPage extends Page {
  final int? id;
  BookPage({this.id}) : super(key: ValueKey('book_$id'), restorationId: 'book_$id');

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BookDetailsScreen(id: id);
      },
    );
  }
}
