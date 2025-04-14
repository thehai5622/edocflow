part of 'app_page.dart';

abstract class Routes {
  Routes._();
  static const dashboard = _Paths.dashboard;
  static const splash = _Paths.splash;
  static const home = _Paths.home;
  static const login = _Paths.login;
  static const field = _Paths.field;
  static const createField = _Paths.createField;
  static const editField = _Paths.editField;
}

abstract class _Paths {
  _Paths._();
  static const String dashboard = '/dashboard';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String field = '/field';
  static const String createField = '/create-field';
  static const String editField = '/edit-field';
}
