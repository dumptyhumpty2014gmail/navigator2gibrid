part of 'app_router_delegate.dart';

class AppBackBtnDispatcher extends RootBackButtonDispatcher {
  final AppRouterDelegate _routerDelegate;

  AppBackBtnDispatcher(this._routerDelegate);

  @override
  Future<bool> didPopRoute() async {
    ///здесь можно отлавливать выход из приложения и предлагать диалог "хотите выйти?" на андроиде
    if (kDebugMode) {
      print('didPopRoute');
    }
    return _routerDelegate.popRoute();
  }
}
