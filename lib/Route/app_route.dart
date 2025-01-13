part of 'app_page.dart';

abstract class Routes {
  Routes._();
  static const dashboard = _Paths.dashboard;
  static const home = _Paths.home;
}

abstract class _Paths {
  _Paths._();
  static const String dashboard = '/dashboard';
  static const String home = '/home';
}
