import 'package:edocflow/Model/user.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class DetailUserController extends GetxController {
  late String uuid;
  RxBool isLoading = false.obs;
  User detail = User();
  final String baseUrl = dotenv.env['API_URL'] ?? '';

  @override
  void onInit() {
    uuid = Get.arguments?["uuid"] ?? "";
    getDetail();
    super.onInit();
  }

  getDetail() {
    isLoading.value = true;
    try {
      APICaller.getInstance().get("v1/user/detail/$uuid").then((value) {
        if (value != null) {
          detail =  User.fromJson(value['data']);
          isLoading.value = false;
        }
      });
    } catch (e) {
      isLoading.value = false;
    }
  }
}
