import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///не понял как его нормально использовать. пока обошелся и без него
class AppRouteInformationProvider extends RouteInformationProvider with WidgetsBindingObserver, ChangeNotifier {
  //если мы так задаем, то parseRouteInformation вызывается всегда с этим RouteInformation, а не из строки браузера...
  RouteInformation _value = RouteInformation(uri: Uri.parse('/'));
  @override
  RouteInformation get value => _value;

  /// Для режима множественных записей этот метод создает новую запись истории поверх
  /// текущей записи, если `replace` имеет значение false, таким образом, пользователь
  /// будет на новой записи истории, как будто он посетил новую страницу, а кнопка
  /// браузера «Назад» возвращает пользователя к предыдущей записи. Если
  /// `replace` имеет значение true, этот метод обновляет только URL и состояние в
  /// текущей записи истории, не добавляя новую.
  @override
  void routerReportsNewRouteInformation(
    RouteInformation routeInformation, {
    RouteInformationReportingType type = RouteInformationReportingType.none,
  }) {
    if (kDebugMode) {
      print('step PROVIDER routerReportsNewRouteInformation ${routeInformation.uri} ${routeInformation.state}');
    }
    SystemNavigator.routeInformationUpdated(uri: routeInformation.uri, state: routeInformation.state);
    _value = routeInformation;
    notifyListeners();
  }
}
