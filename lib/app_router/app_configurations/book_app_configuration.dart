part of 'i_app_configuration.dart';

class BooksBookAppConfiguration implements IAppConfiguration {
  final int? id;

  BooksBookAppConfiguration({required this.id});
  @override
  List<IAppPage> getPages() {
    return [BooksListAppPage(), BookAppPage(id: id)];
  }
}
