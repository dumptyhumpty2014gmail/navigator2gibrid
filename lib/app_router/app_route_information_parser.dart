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

    return getAppConfigurationParseUri(uri);
  }

  @override
  RouteInformation? restoreRouteInformation(AppConfiguration configuration) {
    //срабатывает каждый раз, когда меняется геттер currentConfiguration
    //из присланной конфигурации формирует url
    final uri = getUriFromComfiguration(configuration);
    if (kDebugMode) {
      print('step PARSER restore ${configuration.toString()} url ${uri.path}');
    }
    return RouteInformation(uri: uri);
  }

  ///вынесено в отдельный метод, чтобы можно было и в мобильных сборках восстанвливать конфигурацию
  static AppConfiguration getAppConfigurationParseUri(Uri uri) {
    ///ловим только корректные пути и возвращаем конфигурацию
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[1] == AppPageUrl.book.path &&
          uri.pathSegments[0] == AppPageUrl.booksList.path &&
          uri.queryParameters.containsKey(AppPageBook.bookidParameterName)) {
        return AppConfiguration(pages: [AppPageBookList(), AppPageBook(id: int.parse(uri.queryParameters[AppPageBook.bookidParameterName]!))]);
      }
    } else if (uri.pathSegments.length == 1) {
      final segment0 = uri.pathSegments[0];
      if (segment0 == AppPageUrl.booksList.path) {
        return AppConfiguration.booksList();
      } else if (segment0 == AppPageUrl.login.path) {
        return AppConfiguration.login();
      }
    }

    return AppConfiguration.start();
  }

  static Uri getUriFromComfiguration(AppConfiguration configuration) {
    String url = '';
    Map<String, dynamic> queryParameters = {};
    for (var page in configuration.pages) {
      url += '/${page.pageUrl.path}';
      queryParameters.addAll(page.queryParameters);
    }
    return Uri(path: url, queryParameters: queryParameters);
  }
}
