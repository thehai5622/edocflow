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
  static const typeTemplateFile = _Paths.typeTemplateFile;
  static const createTtf = _Paths.createTtf;
  static const editTtf = _Paths.editTtf;
  static const issuingAuthority = _Paths.issuingAuthority;
  static const createIa = _Paths.createIa;
  static const editIa = _Paths.editIa;
  static const individual = _Paths.individual;
  static const changePass = _Paths.changePass;
  static const profile = _Paths.profile;
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
  static const String typeTemplateFile = '/typetemplatefile';
  static const String createTtf = '/create-ttf';
  static const String editTtf = '/edit-ttf';
  static const String issuingAuthority = '/issuingauthority';
  static const String createIa = '/create-ia';
  static const String editIa = '/edit-ia';
  static const String individual = '/individual';
  static const String changePass = '/change-pass';
  static const String profile= '/profile';
}
