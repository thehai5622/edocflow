part of 'app_page.dart';

abstract class Routes {
  Routes._();
  static const dashboard = _Paths.dashboard;
  static const splash = _Paths.splash;
  static const home = _Paths.home;
  static const login = _Paths.login;
}

abstract class _Paths {
  _Paths._();
  static const String dashboard = '/dashboard';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
}
