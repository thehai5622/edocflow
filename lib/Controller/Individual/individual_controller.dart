import 'package:edocflow/Global/constant.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:get/get.dart';

class IndividualController extends GetxController {
  RxString name = ''.obs;
  RxString avatar = ''.obs;

  @override
  void onInit() {
    super.onInit();
    Utils.getStringValueWithKey(Constant.NAME).then((value) {
      name.value = value;
    });
  }
}
