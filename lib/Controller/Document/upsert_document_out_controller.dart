import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpsertDocumentOutController extends GetxController {
  late String uuid;
  late String title;
  RxBool isWaitSubmit = false.obs;
  TextEditingController name = TextEditingController();

  @override
  void onInit() {
    uuid = Get.arguments?["uuid"] ?? "";
    if (uuid == "") {
      title = "Thêm văn bản đi";
    } else {
      title = "Chỉnh sửa văn bản đi";
      // getDetail();
    }
    super.onInit();
  }
}
