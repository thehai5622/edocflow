import 'package:edocflow/Controller/Document/document_in_controller.dart';
import 'package:edocflow/Model/document.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:get/get.dart';

class DetailDocumentController extends GetxController {
  late String uuid;
  bool isIn = false;
  RxBool isLoading = false.obs;
  Document detail = Document();

  @override
  void onInit() {
    uuid = Get.arguments?["uuid"] ?? "";
    isIn = Get.arguments?["document"] == "in";
    getDetail();
    super.onInit();
  }

  getDetail() {
    isLoading.value = true;
    try {
      APICaller.getInstance().get("v1/document/$uuid").then((value) {
        if (value != null) {
          detail = Document.fromJson(value['data']);
          isLoading.value = false;
        }
      });
    } catch (e) {
      isLoading.value = false;
    }
  }

  submit() {
    switch(detail.status) {
      case 1:
        break;
      case 2:
        signDocument();
        break;
    }
  }

  signDocument() {
    isLoading.value = true;
    try {
      APICaller.getInstance()
          .post("v1/document/sign-document/$uuid", body: {}).then((value) {
        if (value != null) {
          if (Get.isRegistered<DocumentInController>()) {
            Get.find<DocumentInController>().refreshData();
          }
          getDetail();
          Utils.showSnackBar(
            title: 'Thông báo!',
            message: value['message'],
          );
        }
      });
    } catch (e) {
      isLoading.value = false;
    }
  }
}
