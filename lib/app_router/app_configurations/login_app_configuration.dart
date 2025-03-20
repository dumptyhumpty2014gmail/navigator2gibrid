part of 'i_app_configuration.dart';

class LoginAppConfiguration implements IAppConfiguration {
  @override
  List<IAppPage> getPages() {
    return [LoginAppPage()];
  }
}
