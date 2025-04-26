import 'package:edocflow/Global/constant.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxString name = ''.obs;
  RxString avatar = ''.obs;
  final String baseUrl = dotenv.env['API_URL'] ?? '';

  @override
  void onInit() {
    super.onInit();
    Utils.getStringValueWithKey(Constant.NAME).then((value) {
      name.value = baseUrl + value;
    });
  }
}
