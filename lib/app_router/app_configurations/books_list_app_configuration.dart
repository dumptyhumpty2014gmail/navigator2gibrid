part of 'i_app_configuration.dart';

class BooksListAppConfiguration implements IAppConfiguration {
  @override
  List<IAppPage> getPages() {
    return [BooksListAppPage()];
  }
}
