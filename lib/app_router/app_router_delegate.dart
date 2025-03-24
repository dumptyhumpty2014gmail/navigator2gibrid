import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigator2gibrid/app_router/app_pages/book_page.dart';
import 'package:navigator2gibrid/app_router/app_pages/books_list_page.dart';
import 'package:navigator2gibrid/app_router/app_pages/start_splash_page.dart';

import 'app_configuration.dart';
import 'app_page.dart';
import 'app_page_url.dart';

part 'app_back_btn_dispatcher.dart';
part 'app_route_information_parser.dart';

class AppRouterDelegate extends RouterDelegate<AppConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppConfiguration> {
  final transitionDelegate = NoAnimationTransitionDelegate();
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

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
      transitionDelegate: transitionDelegate,
      pages: _pages.isEmpty ? [AppPageStart()] : List.of(_pages.map((e) => e)),
      onDidRemovePage: (Page route) {
        //срабатывает даже когда мы убираем в списке какую-то страницу

        if (kDebugMode) {
          print('onDidRemovePage Route removed: ${route.toString()}');
          print('onDidRemovePage last page: ${_pages.last.toString()}');
        }

        ///эксперименты
        // if (_pages.last.runtimeType == route.runtimeType) {
        //   if (kDebugMode) {
        //     print('onDidRemovePage last for remove page: ${_pages.last.toString()}');
        //     _pages.add(_pages.last);
        //   }
        // }

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
      return;
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

  void replaceAppPage<T extends AppPage>(AppConfiguration configuration) {
    if (_pages.last.runtimeType == T) {
      _pages = [..._currentConfiguration!.pages.sublist(0, _currentConfiguration!.pages.length - 1), ...configuration.pages];
      _currentConfiguration = AppConfiguration(pages: _pages);
      notifyListeners();
    }
  }
}

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];

    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      if (kDebugMode) {
        print('newPageRouteHistory ${pageRoute.runtimeType}');
      }
      results.add(pageRoute);
    }

    for (final exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }
      if (kDebugMode) {
        print('locationToExitingPageRoute ${exitingPageRoute.runtimeType}');
      }
      results.add(exitingPageRoute);
    }
    return results;
  }
}
