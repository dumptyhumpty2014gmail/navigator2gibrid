import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../main_vm.dart';
import 'app_configurations/i_app_configuration.dart';
import 'app_pages/i_app_page.dart';

part 'app_back_btn_dispatcher.dart';

class AppRouterDelegate extends RouterDelegate<IAppConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<IAppConfiguration> {
  final MainVM vm;
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate({required this.vm}) : navigatorKey = GlobalKey<NavigatorState>() {
    vm.addListener(mainStateListener);
  }

  @override
  void dispose() {
    vm.removeListener(mainStateListener);
    super.dispose();
  }

  bool? _isLogin;
  void mainStateListener() {
    if (kDebugMode) {
      print('mainStateListener ${vm.isLogin}');
    }

    ///можно написать короче, но для лучшего понимания
    if (_isLogin == null && vm.isLogin == false) {
      //приложение запустилось, но мы не залогинены, переходим на страницу логина и очищаем текущую конфигурацию
      setNewRoutePath(LoginAppConfiguration());
    } else if (_isLogin == true && vm.isLogin == false) {
      //мы были залогинены, но сейчас не залогинены, переходим на страницу логина
      setNewRoutePath(LoginAppConfiguration());
    } else if (_isLogin == false && vm.isLogin == true) {
      //мы не были залогинены, но залогинились
      setNewRoutePath(BooksListAppConfiguration());
    } else if (_isLogin == null && vm.isLogin == true) {
      //приложение запустилось, мы залогинены, переходим на сохраненную или на полученную из браузера конфигурацию
      if (_curConfiguration is StartAppConfiguration) {
        setNewRoutePath(BooksListAppConfiguration());
      }
    }
    _isLogin = vm.isLogin;
  }

  IAppConfiguration? _curConfiguration = StartAppConfiguration();
  @override
  IAppConfiguration? get currentConfiguration => _curConfiguration;
  List<Page<dynamic>> _pages = [];
  List<MaterialPage> get pages => List.unmodifiable(_pages);
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,

      pages: _pages.isEmpty ? [StartAppPage().page] : List.of(_pages.map((e) => e)),
      onDidRemovePage: (Page route) {
        //срабатывает даже когда мы убираем в списке какую-то страницу

        if (kDebugMode) {
          print('onDidRemovePage Route removed: ${route.toString()}');
        }

        ///для отлавливания не декларативного перехода
        if (_curConfiguration is BooksBookAppConfiguration && route is BookPage) {
          setNewRoutePath(BooksListAppConfiguration());
        }
      },
    );
  }

  @override
  Future<void> setNewRoutePath(IAppConfiguration configuration) async {
    if (kDebugMode) {
      print('setNewRoutePath ${configuration.runtimeType}');
    }
    if (configuration is StartAppConfiguration) {
      if (_isLogin != null) {
        return;
      }
    }
    _curConfiguration = configuration;
    _pages = [...configuration.getPages().map((e) => e.page)];
    notifyListeners();
  }

  @override
  Future<bool> popRoute() {
    if (kDebugMode) {
      print('popRoute');
    }
    return super.popRoute();
  }
}
