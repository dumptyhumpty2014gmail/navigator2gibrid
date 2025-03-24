import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigator2gibrid/app_router/app_pages/book_page.dart';
import 'package:navigator2gibrid/app_router/app_pages/books_list_page.dart';
import 'package:navigator2gibrid/app_router/app_pages/login_page.dart';
import 'package:navigator2gibrid/app_router/app_pages/start_splash_page.dart';

import '../main_vm.dart';
import 'app_configuration.dart';
import 'app_page.dart';
import 'app_page_url.dart';

part 'app_back_btn_dispatcher.dart';
part 'app_route_information_parser.dart';

class AppRouterDelegate extends RouterDelegate<AppConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppConfiguration> {
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
      setNewRoutePath(AppConfiguration(pages: [AppPageLogin()]));
    } else if (_isLogin == true && vm.isLogin == false) {
      //мы были залогинены, но сейчас не залогинены, переходим на страницу логина
      setNewRoutePath(AppConfiguration(pages: [AppPageLogin()]));
    } else if (_isLogin == false && vm.isLogin == true) {
      //мы не были залогинены, но залогинились
      setNewRoutePath(AppConfiguration(pages: [AppPageBookList()]));
    } else if (_isLogin == null && vm.isLogin == true) {
      //приложение запустилось, мы залогинены, переходим на сохраненную или на полученную из браузера конфигурацию
      if ((_currentConfiguration?.pages.length ?? 0) == 1 && _currentConfiguration?.pages[0] is AppPageStart) {
        setNewRoutePath(AppConfiguration(pages: [AppPageBookList()]));
      }
    }
    _isLogin = vm.isLogin;
  }

  AppConfiguration? _currentConfiguration = AppConfiguration(pages: []);
  @override
  AppConfiguration? get currentConfiguration => _currentConfiguration;
  List<AppPage> _pages = [AppPageStart()];
  List<AppPage> get pages => List.unmodifiable(_pages);
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('build ${_pages.length}');
    }
    return Navigator(
      key: navigatorKey,

      pages: _pages.isEmpty ? [AppPageStart()] : List.of(_pages.map((e) => e)),
      onDidRemovePage: (Page route) {
        //срабатывает даже когда мы убираем в списке какую-то страницу

        if (kDebugMode) {
          print('onDidRemovePage Route removed: ${route.toString()}');
          print('onDidRemovePage last page: ${_pages.last.toString()}');
        }
        //срабатывает на изменение страниц. к примеру, на "удаление" стартовой при выводе login или при иных заменах
        ///для отлавливания не декларативного перехода pop. Его нужно ловить в отдельном PopScope
        // if ((_currentConfiguration?.pages.length ?? 0) <= 1 || route is! AppPageStart) {
        //   //пока ничего не делаем
        // } else {
        //   // setNewRoutePath(AppConfiguration(pages: _pages.sublist(0, _pages.length - 1)));
        // }
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppConfiguration configuration) async {
    if (kDebugMode) {
      print('setNewRoutePath ${configuration.runtimeType}');
    }
    if (configuration.pages.length == 1 && configuration.pages[0] is AppPageStart) {
      if (_isLogin != null) {
        return;
      }
    }
    _currentConfiguration = configuration;
    _pages = [...configuration.pages];
    notifyListeners();
  }

  @override
  Future<bool> popRoute() {
    if (kDebugMode) {
      print('popRoute');
    }
    return super.popRoute();
  }

  void addPage(AppPage nextPage) {
    if ((_currentConfiguration?.pages ?? []).contains(nextPage)) return;
    _pages = [..._currentConfiguration!.pages, nextPage];
    _currentConfiguration = AppConfiguration(pages: _pages);
    notifyListeners();
  }

  void back() {
    if (_pages.length == 1) return;
    _pages = [..._currentConfiguration!.pages.sublist(0, _currentConfiguration!.pages.length - 1)];
    _currentConfiguration = AppConfiguration(pages: _pages);
    notifyListeners();
  }
}
