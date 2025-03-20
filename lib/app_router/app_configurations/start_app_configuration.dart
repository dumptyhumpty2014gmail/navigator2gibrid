part of 'i_app_configuration.dart';

class StartAppConfiguration implements IAppConfiguration {
  @override
  List<IAppPage> getPages() {
    return [StartAppPage()];
  }
}
