import 'package:edocflow/View/Login/login.dart';
import 'package:edocflow/View/dashboard.dart';
import 'package:edocflow/View/splash.dart';
import 'package:get/get.dart';

part 'app_route.dart';

class AppPage {
  AppPage._();

  static const String initialRoute = Routes.splash;

  static final List<GetPage<dynamic>> routes = [
    GetPage(name: Routes.dashboard, page: () => Dashboard()),
    GetPage(name: Routes.splash, page: () => Splash()),
    // GetPage(name: Routes.home, page: () => Home()),
    GetPage(name: Routes.login, page: () => Login()),
  ];
}
