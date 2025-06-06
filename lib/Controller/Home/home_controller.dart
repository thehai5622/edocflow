import 'package:edocflow/Global/constant.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString name = ''.obs;
  RxString avatar = ''.obs;
  final String baseUrl = dotenv.env['API_URL'] ?? '';

  @override
  void onInit() {
    super.onInit();
    Utils.getStringValueWithKey(Constant.NAME).then((value) {
      name.value = value;
    });
    Utils.getStringValueWithKey(Constant.AVATAR).then((value) {
      avatar.value = baseUrl + value;
    });
  }

  updateName(String name) {
    this.name.value = name;
  }

  updateAvatar(String avatar) {
    this.avatar.value = baseUrl + avatar;
  }
}
