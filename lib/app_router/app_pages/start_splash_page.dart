part of 'i_app_page.dart';

class StartAppPage implements IAppPage {
  @override
  Page get page => StartSplashPage();

  @override
  PagePath get pagePath => PagePath.startSlash;

  @override
  Map<String, String> get queryParameters => {};
}

class StartSplashPage extends Page {
  StartSplashPage() : super(key: ValueKey('startPage'), restorationId: 'startPage');

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return StartScreen();
      },
    );
  }
}
