part of 'app_router_delegate.dart';

class AppRouteInformationParser extends RouteInformationParser<AppConfiguration> {
  @override
  Future<AppConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    //Срабатывает конкретно, когда запускается урл (или происходит рефреш) в браузере
    //срабатывает, так же,  когда нажимают стрелку "назад"(или "вперед")
    //и запускает setNewRoutePath, куда передает "конфигурацию"
    //если есть RouteInformationProvider, то почему-то тупо берет из value этого провайдера

    ///Вариант 1 Декларативный

    final uri = routeInformation.uri;
    if (kDebugMode) {
      print(
        'step PARSER parse state=${routeInformation.state} segmets=${uri.pathSegments.length} fullpath=${uri.pathSegments.join('/')} qery ${uri.queryParameters}',
      );
    }

    ///ловим только корректные пути и возвращаем конфигурацию
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[1] == AppPageUrl.book.path &&
          uri.pathSegments[0] == AppPageUrl.booksList.path &&
          uri.queryParameters.containsKey('bookid')) {
        //TODO наименование параметра нужно, наверное, через статик сделать
        return AppConfiguration(pages: [AppPageBookList(), AppPageBook(id: int.parse(uri.queryParameters['bookid']!))]);
      }
    } else if (uri.pathSegments.length == 1) {
      final segment0 = uri.pathSegments[0];
      if (segment0 == AppPageUrl.booksList.path) {
        return AppConfiguration(pages: [AppPageBookList()]);
      } else if (segment0 == AppPageUrl.login.path) {
        return AppConfiguration(pages: [AppPageLogin()]);
      }
    }
    return AppConfiguration(pages: [AppPageStart()]);
  }

  @override
  RouteInformation? restoreRouteInformation(AppConfiguration configuration) {
    //срабатывает каждый раз, когда меняется геттер currentConfiguration
    //из присланной конфигурации формирует url
    String url = '';
    Map<String, dynamic> queryParameters = {};
    for (var page in configuration.pages) {
      url += '/${page.pageUrl.path}';
      queryParameters.addAll(page.queryParameters);
    }

    if (kDebugMode) {
      print('step PARSER restore ${configuration.toString()} url $url');
    }
    return RouteInformation(uri: Uri(path: url, queryParameters: queryParameters));
  }
}
