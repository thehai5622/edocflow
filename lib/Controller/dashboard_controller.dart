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
}
