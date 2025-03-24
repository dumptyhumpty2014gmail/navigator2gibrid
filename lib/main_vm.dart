import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigator2gibrid/app_router/app_configuration.dart';
import 'package:navigator2gibrid/app_router/app_pages/start_splash_page.dart';
import 'package:navigator2gibrid/app_router/app_router_delegate.dart';

import 'data/local_repository.dart';

///упрощенный глобальный стейт менеджер как бы
class MainVM extends ChangeNotifier {
  final LocalRepository localRepository;
  final AppRouterDelegate router;
  MainVM({required this.localRepository, required this.router});
  bool? _isLogin;
  bool? get isLogin => _isLogin;

  void init() {
    checkLogin();
  }

  Future<void> checkLogin() async {
    _isLogin = await localRepository.getLoginState();
    redirectLogin(isInit: true);
  }

  void changeLoginState(bool state) {
    final result = localRepository.saveLoginState(state);
    if (result) {
      _isLogin = state;
      redirectLogin();
    }
  }

  void redirectLogin({bool isInit = false}) {
    if (_isLogin == true) {
      if (isInit) {
        router.replace<AppPageStart>(AppConfiguration.booksList());
      } else {
        router.setNewRoutePath(AppConfiguration.booksList());
      }
    } else {
      //нужно восстанавливать конфигурацию
      router.setNewRoutePath(AppConfiguration.login());
    }
  }
}
