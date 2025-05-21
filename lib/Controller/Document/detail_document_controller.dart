import 'package:edocflow/Model/document.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:get/get.dart';

class DetailDocumentController extends GetxController{
  late String uuid;
  RxBool isLoading = false.obs;
  Document detail = Document();

  @override
  void onInit() {
    uuid = Get.arguments?["uuid"] ?? "";
    getDetail();
    super.onInit();
  }

  getDetail() {
    isLoading.value = true;
    try {
      APICaller.getInstance().get("v1/document/$uuid").then((value) {
        if (value != null) {
          detail =  Document.fromJson(value['data']);
          isLoading.value = false;
        }
      });
    } catch (e) {
      isLoading.value = false;
    }
  }
}
