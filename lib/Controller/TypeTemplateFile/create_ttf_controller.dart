import 'package:edocflow/Controller/TypeTemplateFile/type_template_file_controller.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTypeTemplateFileController extends GetxController {
  RxBool isWaitSubmit = false.obs;
  TextEditingController name = TextEditingController();

  void back() {
    Get.back();
  }

  void submit() {
    isWaitSubmit.value = true;
    try {
      final param = {
        "name": name.text.trim(),
      };

      APICaller.getInstance().post('v1/typetemplatefile', body: param).then((response) {
        if (Get.isRegistered<TypeTemplateFileController>()) {
          Get.find<TypeTemplateFileController>().refreshData();
        }
        Get.back();
        Utils.showSnackBar(title: 'Thông báo', message: response['message']);
      });
    } catch (e) {
      Utils.showSnackBar(title: 'Thông báo', message: '$e');
    } finally {
      isWaitSubmit.value = false;
    }
  }
}
