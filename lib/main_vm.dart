import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'data/local_repository.dart';

///упрощенный глобальный стейт менеджер как бы
class MainVM extends ChangeNotifier {
  final LocalRepository localRepository;
  MainVM({required this.localRepository});
  bool? _isLogin;
  bool? get isLogin => _isLogin;

  void init() {
    checkLogin();
  }

  Future<void> checkLogin() async {
    _isLogin = await localRepository.getLoginState();
    notifyListeners();
  }

  void changeLoginState(bool state) {
    final result = localRepository.saveLoginState(state);
    if (result) {
      _isLogin = state;
      notifyListeners();
    }
  }
}
