import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  LocalRepository._internal();
  static final LocalRepository _instance = LocalRepository._internal();
  factory LocalRepository() => _instance;
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static const String _loginKey = 'isLogin';
  Future<bool> getLoginState() async {
    return _prefs?.getBool(_loginKey) ?? false;
  }

  bool saveLoginState(bool state) {
    if (_prefs == null) {
      return false;
    }
    _prefs?.setBool(_loginKey, state);
    return true;
  }
}
