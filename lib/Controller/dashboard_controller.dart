import 'package:edocflow/Service/api_caller.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt currentIndex = 0.obs;
  RxString nameTest = "".obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = false;
  }

  changePage(int index) {
    currentIndex.value = index;
  }

  getInfoTest() async {
    final response =
        await APICaller.getInstance().get('v1/user/me').then((value) {
      if (value != null) {
        print(value);
        nameTest.value = value['data']['name'];
        return value;
      }
    });
  }
}
