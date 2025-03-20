part of 'i_app_page.dart';

class LoginAppPage implements IAppPage {
  @override
  Page get page => LoginPage();

  @override
  PagePath get pagePath => PagePath.login;

  @override
  Map<String, String> get queryParameters => {};
}

class LoginPage extends Page {
  LoginPage() : super(key: ValueKey(PagePath.login.path), restorationId: PagePath.login.path);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return LoginScreen();
      },
    );
  }
}
