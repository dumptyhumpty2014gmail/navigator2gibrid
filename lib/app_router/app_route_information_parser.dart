part of '../main.dart';

class AppRouteInformationParser extends RouteInformationParser<IAppConfiguration> {
  @override
  Future<IAppConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
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
      if (uri.pathSegments[1] == PagePath.book.path && uri.pathSegments[0] == PagePath.booksList.path && uri.queryParameters.containsKey('book')) {
        return BooksBookAppConfiguration(id: int.parse(uri.queryParameters['book']!));
      }
    } else if (uri.pathSegments.length == 1) {
      final segment0 = uri.pathSegments[0];
      if (segment0 == PagePath.booksList.path) {
        return BooksListAppConfiguration();
      } else if (segment0 == PagePath.login.path) {
        return LoginAppConfiguration();
      }
    }
    return StartAppConfiguration();
  }

  @override
  RouteInformation? restoreRouteInformation(IAppConfiguration configuration) {
    //срабатывает каждый раз, когда меняется геттер currentConfiguration
    //из присланной конфигурации формирует url
    String url = '';
    Map<String, dynamic> queryParameters = {};
    for (var page in configuration.getPages()) {
      url += '/${page.pagePath.path}';
      queryParameters.addAll(page.queryParameters);
    }

    if (kDebugMode) {
      print('step PARSER restore ${configuration.toString()} url $url');
    }
    return RouteInformation(uri: Uri(path: url, queryParameters: queryParameters));
  }
}
