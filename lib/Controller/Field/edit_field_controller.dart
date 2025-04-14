import 'package:edocflow/Controller/Field/field_controller.dart';
import 'package:edocflow/Model/field.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditFieldController extends GetxController {
  RxBool isWaitSubmit = false.obs;
  TextEditingController name = TextEditingController();
  late Field field;

  @override
  void onInit() {
    super.onInit();
    field = Get.arguments;
    name.text = field.name ?? '';
  }

  void back() {
    Get.back();
  }

  submit() {
    isWaitSubmit.value = true;
    try {
      final param = {
        "name": name.text.trim(),
      };
      APICaller.getInstance().put('v1/field/${field.uuid}', body: param).then((response) {
        if (Get.isRegistered<FieldController>()) {
          Get.find<FieldController>().refreshData();
        }
        Get.back();
        isWaitSubmit.value = false;
        Utils.showSnackBar(title: 'Thông báo', message: response['message']);
      });
    } catch (e) {
      Utils.showSnackBar(title: 'Thông báo', message: '$e');
    } finally {
      isWaitSubmit.value = false;
    }
  }
}
