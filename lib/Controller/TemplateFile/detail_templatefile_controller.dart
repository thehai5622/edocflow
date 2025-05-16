import 'dart:io';

import 'package:edocflow/Model/templatefile.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:get/get.dart';

class DetailTemplatefileController extends GetxController {
  late String uuid;
  RxBool isLoading = false.obs;
  TemplateFile detail = TemplateFile();
  Rx<File> file = Rx<File>(File(""));
  RxString fileSize = "".obs;

  @override
  void onInit() {
    uuid = Get.arguments?["uuid"] ?? "";
    getDetail();
    super.onInit();
  }

  getDetail() {
    isLoading.value = true;
    try {
      APICaller.getInstance().get("v1/template-file/$uuid").then((value) {
        if (value != null) {
          detail = TemplateFile.fromJson(value['data']);
          APICaller.getInstance()
              .downloadAndGetFile(detail.file ?? "")
              .then((value) {
            if (value != null) {
              file.value = value;
              file.value.length().then((data) {
                fileSize.value = "$data bytes";
              });
            }
            isLoading.value = false;
          });
        }
      });
    } catch (e) {
      isLoading.value = false;
    }
  }
}
