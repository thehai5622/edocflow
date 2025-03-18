import 'package:edocflow/Global/constant.dart';
import 'package:edocflow/Route/app_page.dart';
import 'package:edocflow/Service/auth.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    String accessToken = await Utils.getStringValueWithKey(Constant.ACCESS_TOKEN);
    if (accessToken.isEmpty) {
      Get.offAllNamed(Routes.login);
    } else {
      await Auth.login();
    }
  }
}
