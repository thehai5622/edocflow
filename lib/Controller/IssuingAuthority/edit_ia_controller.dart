import 'package:edocflow/Controller/IssuingAuthority/issuingauthority_controller.dart';
import 'package:edocflow/Model/Issuingauthority.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditIssuingAuthorityController extends GetxController {
  RxBool isWaitSubmit = false.obs;
  TextEditingController name = TextEditingController();
  late IssuingAuthority item;

  @override
  void onInit() {
    super.onInit();
    item = Get.arguments;
    name.text = item.name ?? '';
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
      APICaller.getInstance().put('v1/issuingauthority/${item.uuid}', body: param).then((response) {
        if (Get.isRegistered<IssuingAuthorityController>()) {
          Get.find<IssuingAuthorityController>().refreshData();
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
