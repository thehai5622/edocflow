import 'package:edocflow/View/Login/login.dart';
import 'package:edocflow/View/dashboard.dart';
import 'package:get/get.dart';

part 'app_route.dart';

class AppPage {
  AppPage._();

  static const String initialRoute = Routes.login;

  static final List<GetPage<dynamic>> routes = [
    GetPage(name: Routes.dashboard, page: () => Dashboard()),
    // GetPage(name: Routes.home, page: () => Home()),
    GetPage(name: Routes.login, page: () => Login()),
  ];
}
