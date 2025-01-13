import 'package:edocflow/View/dashboard.dart';
import 'package:get/get.dart';

part 'app_route.dart';

class AppPage {
  AppPage._();

  static const String initialRoute = Routes.dashboard;

  static final List<GetPage<dynamic>> routes = [
    GetPage(name: Routes.dashboard, page: () => Dashboard()),
    // GetPage(name: Routes.home, page: () => Home()),
  ];
}
