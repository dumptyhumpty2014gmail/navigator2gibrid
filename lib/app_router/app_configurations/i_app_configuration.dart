import '../app_pages/i_app_page.dart';

part 'start_app_configuration.dart';
part 'login_app_configuration.dart';
part 'books_list_app_configuration.dart';
part 'book_app_configuration.dart';

sealed class IAppConfiguration {
  ///список страниц для этого состояния
  List<IAppPage> getPages();
}
